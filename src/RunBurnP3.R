# ApexRMS - March 2022
# External script to run BurnP3 between every SyncroSim timestep.

# Setup ------------------------------------------------------------------------

# Load libraries
suppressWarnings(suppressPackageStartupMessages(library(rsyncrosim)))
suppressWarnings(suppressPackageStartupMessages(library(tidyverse)))

## Setup necessary files and folders -------------------------------------------

# Set local paths to construct filenames, etc
e <- ssimEnvironment()
workingDir <- e$TempDirectory
scenarioId <- e$ScenarioId
fuelMapDatasheet <- "stsim_OutputSpatialStateAttribute"
burnProbOutputDir <- paste(workingDir, "BurnRasters", sep = "/")
dir.create(file.path(burnProbOutputDir), showWarnings = FALSE)

## Setup SyncroSim to ST-Sim Library -------------------------------------------

#mySession <- session("C:/Program Files/SyncroSim", printCmd = T)
stsimLibrary <- ssimLibrary(forceUpdate=TRUE)
stsimScenario <- scenario()

timestep <- e$BeforeTimestep
prevTimestep <- timestep - 1 
iteration <- e$BeforeIteration

# Determine whether conda is turned on/off
stsimLibInfo <- info(stsimLibrary)

## Get external program variable (fuel types layer) ----------------------------
# Check if output fuel layer was generated 
stateattributename <- datasheet(stsimScenario, name = "stsimBurnP3Plus_Settings")
stateattributename <- stateattributename$StateAttribute

outputFuelSheet <- datasheet(stsimScenario, name = fuelMapDatasheet)
outputFuelSheet <- outputFuelSheet %>%
  filter(Iteration == iteration,
         Timestep == prevTimestep,
         StateAttributeTypeID == stateattributename)

if (nrow(outputFuelSheet) == 0){
  quit()
}

updatedFuelMapPath <- datasheetSpatRaster(
  stsimScenario, 
  datasheet = fuelMapDatasheet,
  timestep = prevTimestep,
  iteration = iteration) %>%
  terra::sources()

## Load BurnP3 template Library from add-on package ----------------------------
burnp3Settings <- datasheet(stsimScenario, name = "stsimBurnP3Plus_Settings")
burnp3LibraryName <- burnp3Settings$Library

# Do not want to overwrite previous libraries as this will cause issues with
# multiprocessing
unzip(burnp3LibraryName, exdir = workingDir, overwrite = TRUE)
libpathlist <- str_split(burnp3LibraryName, pattern = "\\\\")[[1]]
libnameback <- libpathlist[length(libpathlist)]
libnamestring <- str_split(libnameback, pattern = ".backup")[[1]]
libname <- libnamestring[1]

burnp3Library <- ssimLibrary(name = file.path(workingDir, libname),
                             forceUpdate = TRUE, useConda = FALSE)

burnp3ScenarioID <- burnp3Settings$SID
burnp3Scenario <- scenario(burnp3Library, summary = TRUE)
burnp3ScenarioP <- burnp3Scenario[burnp3Scenario$IsResult == "No",]

if (is.null(burnp3ScenarioID)){
  burnp3ScenarioID <- burnp3ScenarioP$ScenarioID[1]
} else {
  if (!burnp3ScenarioID %in% burnp3ScenarioP$ScenarioID){
    stop("Scenario ID does not exist in BurnP3+ Library")
  }}

burnp3Scenario <- scenario(burnp3Library, scenario = burnp3ScenarioID)

## Replace fuel types layer with updated one from ST-Sim -----------------------

landscapeRasters <- datasheet(burnp3Scenario, name = "burnP3Plus_LandscapeRasters")
landscapeRasters$FuelGridFileName <- updatedFuelMapPath
saveDatasheet(burnp3Scenario, landscapeRasters, name = "burnP3Plus_LandscapeRasters")

## Run BurnP3 model ------------------------------------------------------------

burnp3Results <- run(burnp3Scenario, copyExternalInputs = TRUE)

## Load fire probability raster into ST-Sim library ----------------------------

# Probably need to put this in another folder so it doesn't get deleted with 
# library close/overwrite
burnp3BurnProbRaster <- datasheet(
  burnp3Results,
  name = "burnP3Plus_OutputBurnMap") %>%
  filter(Season == "All") %>%
  pull(FileName)

if (is.null(burnp3BurnProbRaster)){
  stop("burnP3 Probability Raster does not exist")
}

burnp3BurnProbRasterNewName <- file.path(burnProbOutputDir, 
                                         burnp3BurnProbRaster %>%
                                           basename() %>%
                                           str_replace(".tif$",
                                                       str_c(".it", iteration,
                                                             ".ts", timestep,
                                                             ".tif"))) %>%
  normalizePath(mustWork = FALSE)

# Move tif file to non-temporary location
file.copy(burnp3BurnProbRaster, burnp3BurnProbRasterNewName, #keep overwrite
          overwrite = TRUE)

transitiongroupname <- datasheet(stsimScenario, name = "stsimBurnP3Plus_Settings")
transitiongroupname <- transitiongroupname$TransitionGroup

updateRunLog(paste0("Timestep: ", timestep, "\r\n",
                    "Iteration: ", iteration, "\r\n",
                    "TransitionGroup: ", transitiongroupname))
print(paste0("Timestep: ", timestep, "\r\n",
                    "Iteration: ", iteration, "\r\n",
                    "TransitionGroup: ", transitiongroupname))

stsimTransitionSpatialMult <- data.frame(
  "Timestep" = timestep, "Iteration" = iteration,
  TransitionGroupID = transitiongroupname,                 
  MultiplierFileName = burnp3BurnProbRasterNewName)
saveDatasheet(stsimScenario, stsimTransitionSpatialMult,
              name = "stsim_TransitionSpatialMultiplier",
              append = TRUE)

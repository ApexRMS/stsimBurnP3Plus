#ApexRMS November 2022
# stsimBurnP3Plus addon to load external program datasheet that runs BurnP3Plus
# between each stsim timestep

# Setup ------------------------------------------------------------------------

# Load libraries
library(rsyncrosim)
library(terra)
library(tidyverse)
library(fs)

## Setup necessary files and folders -------------------------------------------

## Set working directory from SyncroSim environment
e <- ssimEnvironment()
workingDir <- e$TempDirectory
dir.create(file.path(workingDir), showWarnings = FALSE)

## Load Library, Result Scenario, and Parent Scenario
myLibrary <- ssimLibrary()
myScenario <- scenario()

## Ensure Multiprocessing is setup correctly
multiprocessing <- datasheet(myScenario, name = "core_Multiprocessing")
if(multiprocessing$EnableMultiprocessing == TRUE & multiprocessing$EnableCopyExternalFiles == FALSE){
  stop("'Copy scenario inputs for each job' option must be enabled for multiprocessing")
}

## Ensure BurnP3+ Package is installed
installedPackages <- package()

if (!"burnP3Plus" %in% installedPackages$name){
  stop("BurnP3+ Package must be installed")
}
if (!"burnP3PlusCell2Fire" %in% installedPackages$name){
  stop("burnP3PlusCell2Fire Package must be installed")
}

## Ensure Maps have the same extents
maps <- datasheet(myScenario, name = "stsim_InitialConditionsSpatial")

if (ext(rast(maps$StratumFileName)) != ext(rast(maps$StateClassFileName))){
  stop("Extents of Stratum and State Class rasters do not match")
}

if (ext(rast(maps$StateClassFileName)) != ext(rast(maps$AgeFileName))){
  stop("Extents of State Class and Age rasters do not match")
}

## Timesteps and Iterations
runcontrol <- datasheet(myScenario, name = "stsim_RunControl")
maxtimestep <- runcontrol$MaximumTimestep
mintimestep <- runcontrol$MinimumTimestep
maxiteration <- runcontrol$MaximumIteration

iterations <- paste0("1-", maxiteration)
timesteps <- paste0(mintimestep, "-", maxtimestep)

## Load external Program Datasheet

ExternalDatasheet <- datasheet(myScenario, name = "corestime_External")

rpath <- normalizePath(R.home("bin"), winslash = "/")
rpath <- str_split(rpath, "x")[[1]]
rpath <- rpath[1]
rpath <- paste0(rpath, "Rscript.exe")

path <- path_home()
burnp3script <- paste0(path, "/SyncroSim/Packages/stsimBurnP3Plus/RunBurnP3.R")

if (nrow(ExternalDatasheet) == 0){
ExternalDatasheet <- addRow(ExternalDatasheet, c(ExecutableName = rpath,
                              ScriptName = burnp3script,
                              CallBeforeIterations = iterations, CallBeforeTimesteps = timesteps))
  }

saveDatasheet(myScenario, data = ExternalDatasheet, name = "corestime_External")


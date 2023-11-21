# ApexRMS November 2022
# stsimBurnP3Plus addon to load external program datasheet that runs BurnP3Plus
# between each stsim timestep

# Setup ------------------------------------------------------------------------

# Load libraries
library(rsyncrosim)
library(terra)
library(tidyverse)
library(fs)
library(filesstrings)

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

## Update BurnP3+ Library if option selected
burnp3Settings <- datasheet(myScenario, name = "stsimBurnP3Plus_Settings")
updateLibrary <- burnp3Settings$UpdateLibrary
if (is.na(updateLibrary)){
  updateLibrary <- FALSE
}

if (updateLibrary){
  burnp3LibraryName <- burnp3Settings$Library
  
  unzip(burnp3LibraryName, exdir = e$TempDirectory, overwrite = TRUE)
  libpathlist <- str_split(burnp3LibraryName, pattern = "\\\\")[[1]]
  libnameback <- libpathlist[length(libpathlist)]
  libnamestring <- str_split(libnameback, pattern = ".backup")[[1]]
  libname <- libnamestring[1]
  
  # Update library
  args <- list(update = NULL, lib = file.path(e$TempDirectory, libname))
  output <- command(args)
  
  # Create new backup
  args <- list(backup = NULL, lib = file.path(e$TempDirectory, libname),
               input = NULL, output = NULL)
  output <- command(args)
  
  # Replace old ssimbak with new ssimbak
  oldBackupFolder <- file.path(e$TempDirectory, paste0(libname, ".backup"))
  backupFiles <- list.files(oldBackupFolder)
  oldBackupFile <- backupFiles[length(backupFiles)]
  oldBackupPath <- file.path(oldBackupFolder, oldBackupFile)
  
  file.move(oldBackupPath, dirname(burnp3LibraryName))
  file.remove(burnp3LibraryName)
  file.rename(file.path(dirname(burnp3LibraryName), oldBackupFile), burnp3LibraryName)
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

burnp3script <- normalizePath(file.path(e$PackageDirectory, "RunBurnP3.R"))

if (nrow(ExternalDatasheet) == 0){
ExternalDatasheet <- addRow(ExternalDatasheet, c(ExecutableName = rpath,
                              ScriptName = burnp3script,
                              CallBeforeIterations = iterations, CallBeforeTimesteps = timesteps))
  }

saveDatasheet(myScenario, data = ExternalDatasheet, name = "corestime_External")


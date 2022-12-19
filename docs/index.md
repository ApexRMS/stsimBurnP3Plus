---
layout: default
title: Home
description: "Landing page for the ST-Sim BurnP3+ package"
permalink: /
---

# **ST-Sim BurnP3+** SyncroSim Package
<img align="right" style="padding: 13px" width="180" src="assets/images/logo/stsimBurnP3Plus_large.png">
[![GitHub release](https://img.shields.io/github/v/release/ApexRMS/stsimBurnP3Plus.svg?style=for-the-badge&color=d68a06)](https://GitHub.com/ApexRMS/stsimBurnP3Plus/releases/)    <a href="https://github.com/ApexRMS/stsimBurnP3Plus"><img align="middle" style="padding: 1px" width="30" src="assets/images/logo/github-trans2.png">
<br>

## **ST-Sim BurnP3+** is an open-source [SyncroSim](https://syncrosim.com/) add-on package incorporating fire simulation modelling to state and transition models ([**ST-Sim**](https://docs.stsim.net/getting_started/overview.html)).

<br>

## Background

**ST-Sim BurnP3+** was designed as an add-on to the [**ST-Sim**](https://docs.stsim.net/getting_started/overview.html) package as a way of incorporating more accurate fire simulations via the [**BurnP3+**](https://burnp3.github.io/BurnP3Plus/) model. The package allows the users to design state-and-transition simulations (**ST-Sim**) and fire models (**BurnP3+**) and link them together such that both operate in tandem. The models function in a pipeline where the output maps of the state-and-transition simulation model is used as the input maps of the fire model. The output maps of this pipeline are reinserted into the state-and-transition simulation model to start the next timestep.

<br>

## Requirements

This package requires SyncroSim [version 2.4.18](https://syncrosim.com/download/) or higher. The following packages are also required to use the **ST-Sim BurnP3+** package:
* [BurnP3+](https://github.com/BurnP3/BurnP3Plus) and at least one fire growth add-on package (e.g. [BurnP3+Cell2Fire](https://github.com/BurnP3/BurnP3PlusCell2Fire) or [BurnP3+Prometheus](https://github.com/BurnP3/BurnP3PlusPrometheus))
* [ST-Sim](https://github.com/ApexRMS/stsim)

This package also requires [R](https://cran.r-project.org/bin/windows/base/) version 4.2.2 or higher. The following libraries are also required to use the **ST-Sim BurnP3+** package:
* [rsyncrosim](https://syncrosim.github.io/rsyncrosim/)
* [tidyverse](https://www.tidyverse.org/)
* [terra](https://rspatial.org/index.html)
* [fs](https://fs.r-lib.org/)


<br>

## Key Links

Browse source code at
[http://github.com/ApexRMS/stsimBurnP3Plus/](http://github.com/ApexRMS/stsimBurnP3Plus/). <br>
Report a bug at
[http://github.com/ApexRMS/stsimBurnP3Plus/issues](http://github.com/ApexRMS/stsimBurnP3Plus/issues). <br>

<br>

## Developers

Gabrielle Ednie (Author) <a href="https://orcid.org/0000-0003-2832-3015"><img align="middle" style="padding: 0.5px" width="17" src="assets/images/ORCID.png"></a>
<br>
Katie Birchard (Author, maintainer)
<br>
Leonardo Frid (Author) <a href="https://orcid.org/0000-0002-5489-2337"><img align="middle" style="padding: 0.5px" width="17" src="assets/images/ORCID.png"></a>

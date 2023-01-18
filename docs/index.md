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

## **ST-Sim BurnP3+** is an open-source <a href="https://syncrosim.com/" target="_blank">SyncroSim</a> add-on package integrating prcess based fire simulations into <a href="https://docs.stsim.net/getting_started/overview.html" target="_blank">ST-Sim</a> state and transition models.

<br>

## Background

**ST-Sim BurnP3+** is an open-source <a href="https://syncrosim.com/" target="_blank">SyncroSim</a> add-on package to <a href="https://docs.stsim.net/getting_started/overview.html" target="_blank">ST-Sim</a> that integrates the <a href="https://burnp3.github.io/BurnP3Plus/" target="_blank">BurnP3+</a> fire modelling package. **ST-Sim BurnP3+** dynamically links ST-Sim state-and-transition simulation models (STSMs) with BurnP3+ ignition, weather and fire growth simulations every timestep. This linkage incorporates more realistic fire perimeters into multi-year simulations of vegetation succession and disturbance.

<br>

## Requirements

This package requires SyncroSim <a href ="https://syncrosim.com/download/" target="_blank">version 2.4.22</a> or higher. The following packages are also required to use the **ST-Sim BurnP3+** package:

- <a href="https://github.com/BurnP3/BurnP3Plus" target="_blank">BurnP3+</a> and at least one fire growth add-on package (e.g. <a href="https://github.com/BurnP3/BurnP3PlusCell2Fire" target="_blank">BurnP3+Cell2Fire</a> or <a href="https://github.com/BurnP3/BurnP3PlusPrometheus" target="_blank">BurnP3+Prometheus</a>)
- <a href="https://github.com/ApexRMS/stsim" target="_blank">ST-Sim</a>

To use the **ST-Sim BurnP3+** package, you are required to follow one of the following two options:
1. Install the R software <a href ="https://cran.r-project.org/bin/windows/base/" target="_blank">version 4.2.2</a> or higher with the following libraries:

>- <a href ="https://syncrosim.github.io/rsyncrosim/" target="_blank">rsyncrosim</a>
>- <a href ="https://www.tidyverse.org/" target="_blank">tidyverse</a>
>- <a href ="https://rspatial.org/index.html" target="_blank">terra</a>
>- <a href ="https://fs.r-lib.org/" target="_blank">fs</a>

2. Follow the SyncroSim prompt to install the <a href ="https://docs.conda.io/en/latest/" target="_blank">conda</a> 
 package manager and create the required conda environments upon installation of the **ST-Sim BurnP3+** add-on package.

<br>

## Getting Started

For a guided tutorial on **ST-Sim BurnP3+**, including installation, set up, model run, and output visualization, see this video tutorial.

<br>

## Key Links

Browse source code at <a href ="http://github.com/ApexRMS/stsimBurnP3Plus/" target="_blank">http://github.com/ApexRMS/stsimBurnP3Plus/</a>. <br>
Report a bug at <a href ="http://github.com/ApexRMS/stsimBurnP3Plus/issues" target="_blank">http://github.com/ApexRMS/stsimBurnP3Plus/issues</a>. <br>
BurnP3+ at <a href ="https://burnp3.github.io/BurnP3Plus/" target="_blank">https://burnp3.github.io/BurnP3Plus/  </a>. <br>
ST-Sim at <a href ="https://docs.stsim.net/ " target="_blank">https://docs.stsim.net/</a>. <br>


<br>

## Developers

Gabrielle Ednie (Author) <a href="https://orcid.org/0000-0003-2832-3015"><img align="middle" style="padding: 0.5px" width="17" src="assets/images/ORCID.png"></a>
<br>
Katie Birchard (Author, maintainer)
<br>
Leonardo Frid (Author) <a href="https://orcid.org/0000-0002-5489-2337"><img align="middle" style="padding: 0.5px" width="17" src="assets/images/ORCID.png"></a>

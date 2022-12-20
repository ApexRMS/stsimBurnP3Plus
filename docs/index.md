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

## **ST-Sim BurnP3+** is an open-source <a href="https://syncrosim.com/" target="_blank">SyncroSim</a> add-on package incorporating fire simulation modelling to state and transition models (<a href="https://docs.stsim.net/getting_started/overview.html" target="_blank">**ST-Sim**</a>).

<br>

## Background

**ST-Sim BurnP3+** is an open-source <a href="https://syncrosim.com/" target="_blank">SyncroSim</a> add-on package to <a href="https://docs.stsim.net/getting_started/overview.html" target="_blank">**ST-Sim**</a> that integrates the SyncroSim fire modelling package <a href="https://burnp3.github.io/BurnP3Plus/" target="_blank">**BurnP3+**</a>. The _ST-Sim BurnP3+_ package allows users to design state-and-transition simulations (**ST-Sim**) that incorporate burn probability models (**BurnP3+**) at each timestep of the simulation. The package takes advantage of the _External Program_ functionality in the SyncroSim User Interface to essentially run two SyncroSim Libraries simultaneously. The below figure demonstrates the workflow of a multi-year simulation that models succession and fire using _ST-Sim BurnP3+_:

<img align="middle" style="padding: 1px" width="800" src="assets/images/multi-year-sim-flowchart.png">

_<center><span style="font-size:8pt">Green steps correspond to ST-Sim Library components, while orange steps correspond to BurnP3+ Library components. Blue boxes represent transitionary steps linking the ST-Sim and BurnP3+ Libraries.</span></center>_

<br>

## Requirements

This package requires SyncroSim <a href ="https://syncrosim.com/download/" target="_blank">version 2.4.18</a> or higher. The following packages are also required to use the **ST-Sim BurnP3+** package:

- <a href="https://github.com/BurnP3/BurnP3Plus" target="_blank">BurnP3+</a> and at least one fire growth add-on package (e.g. <a href="https://github.com/BurnP3/BurnP3PlusCell2Fire" target="_blank">BurnP3+Cell2Fire</a> or <a href="https://github.com/BurnP3/BurnP3PlusPrometheus" target="_blank">BurnP3+Prometheus</a>)
- <a href="https://github.com/ApexRMS/stsim" target="_blank">ST-Sim</a>

This package also requires (<a href ="https://cran.r-project.org/bin/windows/base/" target="_blank">R version 4.2.2</a> or higher. The following libraries are also required to use the **ST-Sim BurnP3+** package:

- <a href ="https://syncrosim.github.io/rsyncrosim/" target="_blank">rsyncrosim</a>
- <a href ="https://www.tidyverse.org/" target="_blank">tidyverse</a>
- <a href ="https://rspatial.org/index.html" target="_blank">terra</a>
- <a href ="https://fs.r-lib.org/" target="_blank">fs</a>

<br>

## Key Links

Browse source code at
<a href ="http://github.com/ApexRMS/stsimBurnP3Plus/" target="_blank">http://github.com/ApexRMS/stsimBurnP3Plus/</a>. <br>
Report a bug at
<a href ="http://github.com/ApexRMS/stsimBurnP3Plus/issues" target="_blank">http://github.com/ApexRMS/stsimBurnP3Plus/issues</a>. <br>

<br>

## Developers

Gabrielle Ednie (Author) <a href="https://orcid.org/0000-0003-2832-3015"><img align="middle" style="padding: 0.5px" width="17" src="assets/images/ORCID.png"></a>
<br>
Katie Birchard (Author, maintainer)
<br>
Leonardo Frid (Author) <a href="https://orcid.org/0000-0002-5489-2337"><img align="middle" style="padding: 0.5px" width="17" src="assets/images/ORCID.png"></a>

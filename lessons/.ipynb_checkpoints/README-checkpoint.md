# QUBES NEON teaching exercises

Focus on NEON AOP lidar and hyperspectral imagery, conducting analyses on cloud and HPC.

**Author**: Tyson Lee Swetnam

**Intent**: I am not teaching this as a course (yet). I’ve got some flexibility in developing the lesson plan and pacing. 

**Teaching Philosophy**: I want to take a reproducible science approach, using pre-written Jupyter notebooks with empty code sections that can be filled in by the student programmers. 

**Learning Objectives**: [NEON’s data science skills](http://www.neonscience.org/opportunities/learning-opportunities/neon-data-skills) provide notebooks and lesson plans for analyzing hyperspectral imagery. I plan to develop complementary notebooks for downloading [AOP lidar data](http://www.neonscience.org/data-collection/airborne-remote-sensing); segmenting individual organisms (herbaceous plants, woody shrubs, and trees) using open-source code, vertically sampling (all bands and time series) hyperspectral signatures for each organism.

The lessons are targeted toward advanced graduate students and researchers. Lessons are expected to take at least one week, e.g. 2-3 lectures, one computer lab session, with online nightly homework.

Students will be allowed to work in small teams (paired programming) to develop their individual notebooks.

## Prerequisites

* Basic understanding of:
  * R 
  * Python 
  * command line interface (CLI)
* Data science lessons from [The Carpentries](https://software-carpentry.org/lessons/) are encouraged. 
* Understanding of [geospatial data analysis](http://www.datacarpentry.org/r-spatial-data-management-intro/) is also encouraged. 

## Lesson 1: Data Science Workbench

**Goals**: Provision virtual machines on [CyVerse Atmosphere](https://atmo.cyverse.org/application) or [XSEDE Jetstream](https://use.jetstream-cloud.org/application), and [Discovery Environment](https://de.cyverse.org/de/), for data analyses.

**Value**: Learn to launch remote metal running on fast Internet2.

* Use [CyVerse Learning Center tutorials](https://cyverse-ez-quickstart.readthedocs-hosted.com/en/latest/) to deploy container software ([Anaconda (Jupyter)](https://anaconda.org/anaconda/jupyter), [Docker](https://www.docker.com/), and [Singularity](http://singularity.lbl.gov/)).

* [Launch virtual machine](https://github.com/tyson-swetnam/SRER_NEON/wiki/Virtual-Machines-QuickStart) and install the necessary software: [Rocker RStudio](https://hub.docker.com/u/rocker/), & [Jupyter](http://jupyter.org/) Notebooks and [Lab](https://github.com/jupyterlab/jupyterlab) for running NEON data analyses.

## Lesson 2: Get NEON AOP data

**Goals**: Learn to download NEON data using the NEON API

**Value**: Get large quantities of data using batch commands.

* [NEON Data API](https://github.com/NEONScience/neon-data-api)
    * Python Jupyter Notebooks for downloading lidar & imagery data 
    * Rmarkdown notebooks for downloading lidar & imagery data
* CyVerse iRODS client 
    * getting data to and from the CyVerse DataStore.
* 3rd Party software
    * CyberDuck

## Lesson 3: Lidar data QAQC and Visualization

**Goals**: Learn basic lidar processing and visualization techniques.

**Value**: Improve classification (bare earth, vegetation, infrastructure) of lidar and visualize data anywhere. 

* Introduce[PDAL](https://www.pdal.io/) (w/ Docker) for lidar classification. 
  * CLI executions.
  * JSON scripting.
  * Colorize lidar data with aerial orthophotography

* Introduce [Potree](http://www.potree.org/), [Entwine](https://entwine.io/) & [Greyhound](https://greyhound.io/) for point cloud visualization.

* Introduce [CloudCompare](http://www.danielgm.net/cc/)

## Lesson 4: Lidar stem segmentation in R ([lidR](https://github.com/Jean-Romain/lidR))

**Goals**: Learn how to segment individual trees/shrubs/herbaceous plants from lidar data in R.

**Value**: Generate ecologically relevant inventory (census) of physical characteristics.

* Run lidR stem segmentation

* Develop an individual object (plant) inventory for various scales.

* [Leaflet](https://rstudio.github.io/leaflet/) mapping in R.

## Lesson 5: NEON Hyperspectral QAQC & simple calibrations

**Goals**: Learn to use NEON hyperspectral imagery.

**Value**: Utilize hyperspectral imagery which will allow species level ID and phenology (health).

* Utilize existing [NEON Data Skills hyperspectral](http://neondataskills.org/hyperspectral-remote-sensing/)

## Lesson 6: Point/polygon sampling of individuals w/ corresponding hyperspectral signatures

**Goals**: Learn to point and polygon sample individual plants in R

**Value**: Ecologically relevant inventory with phenology and species.

* Attribute individual organisms with their corresponding hyperspectral reflectances

## Lesson 7: Statistical Analyses in RStudio

**Goals**: Conduct statistical analyses on your new datasets.

**Value**: Hypothesis testing using data.

* Graphical representations of the data 
  * `ggplot2`
  * `shiny`
  
* Statistical analyses
  * linear modelling, maximum likelihood, generalized additive models (gam), random forests

## Lesson 8: Statistical Analyses in Jupyter

**Goals**: Conduct statistical analsyes on your new datasets

**Value**: Hypothesis testing using data.

* Graphical representations of the data
  * `matplotlib`
  * `pandas`
  
## Lesson 9: Scaling analyses to multiple NEON sites

**Goal**: Develop workflows which utilize data from multiple NEON sites and time series analyses

* Introduce Makeflow and Singularity
* Writing job requests for HPC

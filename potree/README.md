# Potree Converter docker

## Instructions

- On [CyVerse Atmosphere](https://atmo.cyverse.org/) install Docker using the `ezd` function

- Build the Potree docker container `docker build -t tswetnam/potreeconverter:0.1 .`

- Copy a LAS file into `/input` directory

- Customize and launch this command and start the conversion e.g.: `docker run -v /vol_c/SRER/L1/DiscreteLidar/FilteredClassifiedPointCloud/:/input -v /home/tswetnam/potree/pointclouds/:/output potreeconverter PotreeConverter /input/ -p SRER -o /output/SRER`

Project Dockerfile thanks to https://github.com/sverhoeven/PotreeConverter

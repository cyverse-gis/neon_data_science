# Potree Converter docker

## Instructions

- Build the image (only first time) `docker build -t potreeconverter .`

- Copy a LAS file into `/input`

- Customize and launch this command and start the conversion `docker run -v /vol_c/SRER/L1/DiscreteLidar/FilteredClassifiedPointCloud/:/input -v /home/tswetnam/potree/pointclouds/:/output potreeconverter PotreeConverter /input/ -p SRER -o /output/SRER`

Project inspired by https://github.com/sverhoeven/PotreeConverter
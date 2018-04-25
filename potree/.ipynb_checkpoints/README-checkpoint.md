# Potree Converter docker

## Instructions
- Build the image (only first time) `docker build -t potreeconverter .`
- Copy a LAS file into `/input`
- Customize and launch this command and start the conversion `docker run -v /vol_c/white_mountains/:/input -v /vol_c/potree:/output potreeconverter PotreeConverter /input/ -p 4fri -o /output/4fri --title "4FRI Phase 2" --description "2014 Aerial lidar flight over 4FRI project area"`

## Create Potree point index

```
docker run -v /vol_c/white_mountains/:/input -v /home/tswetnam/potree/output/:/output potreeconverter PotreeConverter /input -p 4fri -o /output/4fri --output-format LAZ --overwrite
```

## Launch Potree on localhost

[Potree Github](https://github.com/potree/potree)

```
git clone https://github.com/potree/potree

cd potree

npm install 
npm install -g gulp
```

```
gulp watch
```


Project inspired by https://github.com/sverhoeven/PotreeConverter
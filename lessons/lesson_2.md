# Lesson 2: Get NEON data!

The [NEON Data API](https://github.com/NEONScience/neon-data-api) is currently under development.

The API uses [JSON](https://www.json.org/) and [GeoJSON](http://geojson.org/) syntax for parsing data from the NEON data store.

Here I provide several basic Python3 Notebooks for reading and downloading data from the API.

Similar calls can be written in R, or JavaScript. 

Introduction to the CyVerse DataStore
=====================================

### Managing your data on CyVerse

[Official CyVerse Data Management](http://www.cyverse.org/manage-data)

[Using CyVerse iCommands](https://pods.iplantcollaborative.org/wiki/display/DS/Using+iCommands)

[Official iCommands User](https://docs.irods.org/4.2.2/icommands/user/)

## The NEON Data API in a Notebook

#### Contents (Python)

[NEON_api_python_lidar.ipynb]()

[NEON_api_python_orthophoto.ipynb]()

[NEON_api_python_reflectance.ipnb]()

#### Contents (R)

[NEON_api_get_r_lidar.ipynb]()

[NEON_api_get_r.ipynb]()

Setting up your CyVerse Data Store and iRODS iCommands on a virtual instance
============================================================================

[CyVerse Instructions](https://pods.iplantcollaborative.org/wiki/display/DS/Setting+Up+iCommands)

[Instructions from iRODS](https://packages.irods.org/)

[Download from iRODS](https://irods.org/download/)

```
wget -qO - https://packages.irods.org/irods-signing-key.asc | sudo apt-key add -
echo "deb [arch=amd64] https://packages.irods.org/apt/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/renci-irods.list
sudo apt-get update

sudo apt-get install irods-icommands
```

```
$ iinit
```
You will be queried to set up your `irods_environment.json`

Enter the following:

|statement|input|  
|---------|-----|
| DNS | *data.cyverse.org* |
|port number|*1247*|
|user name| *your user name*|
|zone|*iplant*|

Set up auto-complete for iCommands
[instructions](https://pods.iplantcollaborative.org/wiki/display/DS/Setting+Up+iCommands)

Download [i-commands-auto.bash](https://pods.iplantcollaborative.org/wiki/download/attachments/6720192/i-commands-auto.bash).
In your home directory, rename i-commands-auto.bash to .i-commands-auto.bash
In your .bashrc or .bash_profile, enter the following: 
source .i-commands-auto.bash

#### 3rd Party software

[Using CyVerse and CyberDuck](http://cyberduck-quickstart.readthedocs.io/en/latest/#)

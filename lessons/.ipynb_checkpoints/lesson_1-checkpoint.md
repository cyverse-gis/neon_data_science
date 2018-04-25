# Working on Cloud

While these instructions are written for use on CyVerse Cloud service, called Atmosphere, you can also do the later lessons on a remote cluster, HPC, or localhost running Jupyter.

<<<<<<< HEAD
The following instructions involve the installation of data science software on CyVerse Atmosphere or XSEDE Jetstream instances.

## Step 1: Account Creation

=======
## Step 1: Account Creation

[Create a CyVerse account](https://learning.cyverse.org/projects/cyverse-account-creation-quickstart/en/latest/) 

or

Create a [NSF XSEDE account](https://portal.xsede.org/#/guest) and request an allocation on [Jetstream](https://iujetstream.atlassian.net/wiki/spaces/JWT/pages/29720582/Quick+Start+Guide).

## Step 2: Start a Cloud Instance

I suggest using a featured image with a Graphic User Interface (GUI). 

On Atmosphere, see: [Ubuntu 14.04](https://atmo.cyverse.org/application/images/1135) or [Ubuntu 16.04](https://atmo.cyverse.org/application/images/1453).

On Jetstream, see: [Ubuntu 14.04](https://use.jetstream-cloud.org/application/images/54) or [Ubuntu 16.04](https://use.jetstream-cloud.org/application/images/107).

Allow the instance to reach 'active' status. Instances  typically take 3-7 minutes to boot up the first time.

## Step 3: Access the shell

Log into the Apache Guacamole Web Shell to access a terminal, or use `ssh` on your local machine:

```
ssh CyVerseUserName@<INSTANCE-IP-ADDRESS>
```

Or from the Apache Guacamole Desktop, right click mouse, select Terminal Emulator

### To access Clipboard in Apache Guacamole

- Open Clipboard and virtual keyboard
  - On a standard keyboard: `ctrl` + `alt` + `shift` key
  - On a MAC OS X keyboard: `control` + `command ⌘` + `shift` key

- Select your text or paste text into the clipboard window.

- Close the Clipboard window by selecting `control` + `command ⌘` + `shift` keys again

- Right click with your mouse or double tap fingers on touchpad to paste in the web shell or Desktop

### Web Desktop screen resolution:

type `xrandr` in a Web Desktop terminal to see available resolutions.

an example for 1080HD screen size:

```
xrandr -s 1920x1080
```

## Step 4: Clone this Repository onto the VM

Open the Web Shell or `ssh` into the machine with the public IP address

Change into a directory you're comfortable installing into and have `sudo` privileges.

The next step is to `git clone` this repository onto your VM:

```
git clone https://github.com/tyson-swetnam/QUBES_NEON.git
```

change directory to the new repo with these installation scripts:

```
cd QUBES_NEON
```

## Step 5: EZ Installation

Follow the instructions below, or for more detail visit CyVerse Learning Center's [Data Science Quickstart Tutorial](https://cyverse-ez-quickstart.readthedocs-hosted.com/en/latest/) 

In brief, CyVerse has set up an `ez` installation for Docker, Singularity, and Anaconda (Jupyter Notebooks and Lab).

### Jupyter Notebooks & Lab

Install Anaconda with Python3 (Featured instances on Atmosphere and Jetstream)

```
ezj
```

Once the installation completes, Jupyter Notebook will be running on the VM. Click the link to open a notebook.

---
**NOTE**
I suggest you also use `tmux` or `screen` to start your remote sessions and to detach the screen before exiting.

detach: `ctrl + b` then `ctrl + d`

list sessions: `tmux ls`

re-attach: `tmux attach -t <session id #>`

---

Alternately, you can exit the notebook by pressing `ctrl + c` twice, and then start a [Jupyter Lab (BETA)](https://github.com/jupyterlab/jupyterlab).

To create a secure connection to Jupyter Lab, you will need to start the lab and open an `ssh` tunnel.

```
jupyter lab --no-browser --ip=127.0.0.1 --port=8888
```

Next, open a new terminal tab or window. 

```
ssh -nNT -L 8888:localhost:8888 CyVerseUserName@<IPADDRESS>
```

Enter your password and the terminal should stop responding

Open a new browser tab and open `localhost:8888`

You can launch Jupyter Lab by simply typing `jupyter lab` - but this will allow Lab to only be available on the localhost, with no way to connect from a remote terminal.

A second option to set up a secure connection using Caddyfile

```
echo "$(hostname)
proxy / 127.0.0.1:8888
" > Caddyfile
curl https://getcaddy.com | bash -s personal http.nobots
caddy
```

Caddy will output a secure `https://` url for the Atmosphere VM which you can then connect to.

Advanced installation notes
===========================

To install your own packages you'll need to change ownership of the Anaconda installation:

```
sudo chown $USER:iplant-everyone /opt/anaconda3 -R
```

Install [additional Jupyter kernels](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels)

```
sudo add-apt-repository ppa:chronitis/jupyter
```

```
sudo apt-get update
conda install -c anaconda ipykernel
sudo apt-get install irkernel ijavascript
```

Google Drive Client
===================

Install [Google Drive to Jupyter Lab](https://github.com/jupyterlab/jupyterlab-google-drive)

Note: This was broken recently...

Requires [Node.js 5+](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-16-04)

Google Drive requires port 8888 or 8889 with port forwarding to work

```
jupyter labextension install @jupyterlab/google-drive
```

iRODS iCommands Client
======================

CyVerse has a remote client for Jupyter Lab similar to the Google Drive plugin

[Jupyter Lab iRODS](https://www.npmjs.com/package/@towicode/jupyterlab_irods)
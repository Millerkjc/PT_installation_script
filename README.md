# Automatize Packet Tracer (PT) 7.1.1 for Linux 64bit installation

Installing PT is a boring and "difficult" task, so I've decided to create some scripts to automatize it. <br />
This project take place only for hobby and to enjoy scripting, so what you will see won't be the most beautiful and perfect code you'll ever see.
You are free to modify the code to automate the installation on your own machine (I reccomend it!). <br />

## Folder structure

In this repo there are two different folders:
* **Automate**
  Where I try automatizing the entire process, from the unzipped PT.tar to the libraries
  check and their installations (All for FUN!). Clearly, it's slow and his purpose is only academic.

* **Manually**
  This is the second choice, and the better one if you want to quickly install PT. <br />
  (imho) I prefer installing the libraries from the Debian/Ubuntu repo even if you can export those one that Cisco inserts into the .tar.
  Scripts are functional to install only the libraries I've found as missing (maybe you could need only few of these for the goal).

**RmPT.sh** file can be useful to clear the system, if something went wrong during the installation it can help you to manage a clear install.

**IMPORTANT**
All scripts need root privilege.

## Prerequisites

To run the "Manually" folder scripts you haven't prerequisites. <br />
But, if you wanna try the "Automate" script, you need some programs. <br />
I make some checks and automatically install some of these.

**IMPORTANT**
In this moment, the PT.tar must be under ~/Download directory.

## Getting Started (Automate)

Into "Automate" folder there is only one script.
* **InstallPT.sh** - Unzip, install PT and all the dependencies

```
sudo ./InstallPT.sh
```

## Getting Started (Manually)

Into "Manually" folder there are two scripts.
* **InstallPT_noLibs.sh** - It is useful to automate the unzip procedure
* **Libs.sh**             - Install all libraries you need to run PT

```
sudo ./InstallPT_noLibs.sh
sudo ./Libs.sh
```

## Tests

These scripts are succefully tested on [Xubuntu 16.10](https://xubuntu.org/download/), on a virtual environment


## Next Feature
* Dynamic configuration


## Authors

Written by Alberto Crosta (aka m3jc, millerkjc) - [Millerkjc](https://github.com/Millerkjc) <br />
66m3jc99@gmail.com 

## License

This project is licensed under the [GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html) License

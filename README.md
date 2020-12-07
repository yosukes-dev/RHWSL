# RHWSL (Red hat UBI on WSL)
Red hat redistributable Standard UBI on WSL (Windows 10 Windows 10 FCU or later)
based on [wsldl](https://github.com/yuk7/wsldl)

![screenshot](https://raw.githubusercontent.com/yosukes-dev/RHWSL/master/img/screenshot.png)

[![CircleCI](https://circleci.com/gh/yosukes-dev/RHWSL.svg?style=svg)](https://circleci.com/gh/yosukes-dev/RHWSL)
[![Github All Releases](https://img.shields.io/github/downloads/yosukes-dev/RHWSL/total.svg?style=flat-square)](https://github.com/yosukes-dev/RHWSL/releases)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
![License](https://img.shields.io/github/license/yosukes-dev/RHWSL.svg?style=flat-square)

### [Download](https://github.com/yosukes-dev/RHWSL/releases)


## Requirements
* Windows 10 Fall Creators Update x64 or later.
* Windows Subsystem for Linux feature is enabled.

## Install
#### 1. [Download](https://github.com/yosukes-dev/RHWSL/releases) installer zip

#### 2. Extract all files in zip file to same directory

#### 3.Run RHWSL.exe to Extract rootfs and Register to WSL
Exe filename is using to the instance name to register.
If you rename it you can register with a diffrent name and have multiple installs.

## (Option)
- If you want to use WSL2, convert it with the following command.
```dos
wsl --set-version RHWSL 2
```

## Subscription Manager
- The rootfs included in the release file is the redistributable Standard __"Universal Base Image"__.  
  __However, you can register as usual using subscription-manager and use the RHEL repositories.__
```sh
[root@<yourhost> RHWSL]# subscription-manager register
You are attempting to use a locale that is not installed.
Registering to: subscription.rhsm.redhat.com:443/subscription
Username: <yourusername>
Password: <yourpassword>
The system has been registered with ID: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
The registered system name is: <yourhost>
[root@<yourhost> RHWSL]# subscription-manager attach
You are attempting to use a locale that is not installed.
Installed Product Current Status:
Product Name: Red Hat Enterprise Linux for x86_64
Status:       Subscribed
```

## How-to-Use(for Installed Instance)
#### exe Usage
```dos
Usage :
    <no args>
      - Open a new shell with your default settings.

    run <command line>
      - Run the given command line in that distro. Inherit current directory.

    runp <command line (includes windows path)>
      - Run the path translated command line in that distro.

    config [setting [value]]
      - `--default-user <user>`: Set the default user for this distro to <user>
      - `--default-uid <uid>`: Set the default user uid for this distro to <uid>
      - `--append-path <on|off>`: Switch of Append Windows PATH to $PATH
      - `--mount-drive <on|off>`: Switch of Mount drives
      - `--default-term <default|wt|flute>`: Set default terminal window

    get [setting]
      - `--default-uid`: Get the default user uid in this distro
      - `--append-path`: Get on/off status of Append Windows PATH to $PATH
      - `--mount-drive`: Get on/off status of Mount drives
      - `--wsl-version`: Get WSL Version 1/2 for this distro
      - `--default-term`: Get Default Terminal for this distro launcher
      - `--lxguid`: Get WSL GUID key for this distro

    backup [contents]
      - `--tgz`: Output backup.tar.gz to the current directory using tar command
      - `--reg`: Output settings registry file to the current directory

    clean
      - Uninstall the distro.

    help
      - Print this usage message.
```

#### Just Run exe
```cmd
>RHWSL.exe
[root@PC-NAME user]#
```

#### Run with command line
```cmd
>RHWSL.exe run uname -r
4.4.0-43-Microsoft
```

#### Run with command line with path translation
```cmd
>RHWSL.exe runp echo C:\Windows\System32\cmd.exe
/mnt/c/Windows/System32/cmd.exe
```

#### Change Default User(id command required)
```cmd
>RHWSL.exe config --default-user user

>RHWSL.exe
[user@PC-NAME dir]$
```

#### Set "Windows Terminal" as default terminal
```cmd
>RHWSL.exe config --default-term wt
```

#### How to uninstall instance
```dos
>RHWSL.exe clean

```

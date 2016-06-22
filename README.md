# LSST.git

<!-- TOC depthFrom:2 depthTo:3 withLinks:1 updateOnSave:1 orderedList:0 -->

- [How to run it:](#how-to-run-it)
- [Overview](#overview)
- [Using NovaClient to Connect and instantiate a VM.](#using-novaclient-to-connect-and-instantiate-a-vm)
- [Connecting to VM using `Fabric`, after it has been instantiated.](#connecting-to-vm-using-fabric-after-it-has-been-instantiated)
- [Installing `Docker`](#installing-docker)
- [Resolving IP conflics with illinoisnet](#resolving-ip-conflics-with-illinoisnet)

<!-- /TOC -->

## How to run it:

__Warning:__ Before running this, make sure your environment is set up correctly.

__Warning:__ Make sure your `ssh` key pair is already set up.

__Warning:__ Make sure the floating_ip that is assigned to your new VM is now listed as a known host in ~/.ssh/known_hosts. Otherwise, it'll throw an error.

__Warning:__ Make sure you have the file `StarterScript.sh` in your folder, which contains shell commands to run on the remote VM.

Once all the warnings above are met, all you should need to do is to be in the right folder and run:

    fab setUpMyVM

You will be prompted to enter the name for the VM instance being created.

A little guide to what I've done. This is also where I'll maintain a list of issues I have encountered, or anticipate to encounter.

## Overview
We will be using `NovaClient` to connect to `acx.ncsa.illinois.edu`, and start an instance.

We use `Fabric` to connect and run shell commands on the remote VM.

#### Files:
+ __des_labs-openrc.sh__ This sets the environment variables that are necessary for connecting and authenticating when using `NovaClient`.

+ __OpenStackVirtualMachine.py__ This file implements a class that handles all the operations needed for connecting and instantiating VMs.

+ __fabfile.py__ This is the file that `Fabric` loads when the command `fab` is called. `Fabric` is used for `ssh` connection as well as running shell commands on the remote VM.

+ __StarterScript.sh__ This file contains shell commands to be run on the remote VM.

## Using NovaClient to Connect and instantiate a VM.

[Here is the link to NovaClient](https://pypi.python.org/pypi/python-novaclient).

Before getting down to using this, make sure you obtain __des_labs-openrc.sh__ from acx. Once you have the file, then you need to `source` it so that the environment variables are set.

Also note, you need to create your `ssh` key pair before using any of this.

The file __OpenStackVirtualMachine.py__ implements a class with various methods which are essentially steps taken in the connecting and creating instances of VMs.

#### Issues encountered and resolved:

+ For some reason, when I `source` the __des_labs-openrc.sh__ file from inside this file, the environment variables don't get set up properly.
+ Authentication will fail if you try to use `Nova` straight away. The solution is to use `keystone` for authentication step.   
+ When you create a new instance, and associated it with an existing key-pair, an error is produced when doing `ssh` complaining about the fact that the host has changed. `ssh-keygen -R host` gets rid of the line created in ~/.ssh/known_hosts.
+ When trying to associate a `floating_ip` after and instance (server) has been created, an error is produced. This is because it takes some time for the instance to "spawn". Add a wait period while pinging the host for rediness. In __fabfile.py__  we have `waitForSSH` take care of a similar issue..

## Connecting to VM using `Fabric`, after it has been instantiated.

[Here is the link to Fabric](http://www.fabfile.org/).

Fabric enables us to have access to command-line tools on the remote VM. You simply run `fab *function name*`, where `*function*` is defined in fabfile.py.

1. Create fabfile.
2. set `env.host_string`,`env.user`, and `env.key_filename`
3. use the function `run("shell commands")` to connect and run commands on the remote VM.

__Note:__ Since we are using `ssh` key pairs for authentication, `env.key_filename` is necessary for Fabric to work properly.


## Installing `Docker`

I followed the instructions provided by [docker documentations](https://docs.docker.com/engine/installation/linux/ubuntulinux/){:target="_blank"}.

These are a little bit different than the ones Matias gave me.

At this point, things seem to run fine.

## Resolving IP conflics with illinoisnet

I install bridge-utils and ran the code Matias gave me to resovle the conflict.

#### Issue:
Docker hello-world doesn't run anymore, exiting with error:

    docker: Cannot connect to the Docker daemon. Is the docker daemon running on this host?.

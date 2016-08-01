# Setting up a cluster with Kubernetes

On this page we will go through setting up a cluster on openstack using Kubernetes. [This page](http://kubernetes.io/docs/getting-started-guides/openstack-heat/) is the relevant documentation page. Plase take a look and come back to this document for important information.

First thing to do is to make sure you have all the resources you need. You can follow the [documentation](http://kubernetes.io/docs/getting-started-guides/openstack-heat/) for this:

+ __Getting Started with Openstack__: You are set here. You can skip this.
+ __Pre-requisites__:
  - _Install OpenStack CLI tools_: Make sure you have all these packages
  - _Configure Openstack CLI tools_: You can obtain this file by logging onto [acx/horizon](http://acx.ncsa.illinois.edu/horizon). Click on the **compute** tab and click on **Access and Security**. From there you can download the file by clicking on **Download openStack RC File**. The file will likely be called `des_labs-openrc.sh`. Once you have the file, make sure you change all the URL's appearing in it to include the full path. For example, replace:

          http://acx:5000/v2.0

  with

          http://acx.ncsa.illinois.edu:5000/v2.0.

+ __Set Additional Configuration Values__: I put all of these into a file called `kube-env.sh` so that I can easily `source` it. The values for the fields are:

          export STACK_NAME=kube_sh_test0
          export NUMBER_OF_MINIONS=2
          export MAX_NUMBER_OF_MINIONS=2
          export MASTER_FLAVOR=m1.medium
          export MINION_FLAVOR=m1.medium
          export EXTERNAL_NETWORK=ext-net
          export DNS_SERVER=141.142.2.2
          export IMAGE_URL_PATH=http://cloud.centos.org/centos/7/imags
          export IMAGE_FILE=CentOS-7-x86_64-GenericCloud-1510.qcow2
          export OPENSTACK_IMAGE_NAME='CentOS7'
          #export  IMAGE_URL_PATH=http://storage.apps.openstack.org/imaes /
          export           SWIFT_SERVER_URL=http://acx.ncsa.illinois.edu:8080/v/A UTH_418250         e57afa473591d99187651b561e
          export ENABLE_PROXY=false
          export KUBERNETES_PROVIDER=openstack-heat



## building from source:

+ Log into [kubernetes release](https://github.com/kubernetes/kubernetes/releases) page.
+ Download the source code. In my case I downloaded `Source code (tar.gz)`.
+ Unzip the file and `cd` into the folder.
+ Run the following commands.
      make clean
      make quick-release
  This will take a little while.
+ At this point, you should have a copy of Kubernetes built. If you try and run any `./cluster/kubectl.sh PROPERTY` command, it will complain with the message
        It looks as if you don't have a compiled kubectl binary

        If you are running from a clone of the git repo, please run
        './build/run.sh hack/build-cross.sh'. Note that this requires having
        Docker installed.

        If you are running from a binary release tarball, something is wrong.
        Look at http://kubernetes.io/ for information on how to contact the
        development team for help.
  Run the command `./build/run.sh hack/build-cross.sh` to build a binary version of `kubectl`. This will also take some time.

Now that you have a copy of kubernetes, you can start setting up your cluster.
You can follow the [documentation page](http://kubernetes.io/docs/getting-started-guides/openstack-heat/), but I recommend following this document along side that, since there are some bugs as well as specific configurations that need to be addressed.

## Using a pre-built image.
+ Log into [kubernetes release](https://github.com/kubernetes/kubernetes/releases) page.
+ Download the pre-build image. In this case, `kubernetes.tar.gz`.

Now that you have a copy of kubernetes, you can start setting up your cluster.
You can follow the [documentation page](http://kubernetes.io/docs/getting-started-guides/openstack-heat/), but I recommend following this document along side that, since there are some bugs as well as specific configurations that need to be addressed.

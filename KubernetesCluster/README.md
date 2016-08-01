# Setting up a cluster with Kubernetes


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

## Using a pre-build image.
+ Log into [kubernetes release](https://github.com/kubernetes/kubernetes/releases) page.
+ Download the pre-build image. In this case, `kubernetes.tar.gz`.

Now that you have a copy of kubernetes, you can start setting up your cluster.
You can follow the [documentation page](http://kubernetes.io/docs/getting-started-guides/openstack-heat/), but I recommend following this document along side that, since there are some bugs as well as specific configurations that need to be addressed.

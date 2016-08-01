+ Acquire the `open-rc.sh` file from your openstack administrator and source it.

+ Create a file names `kube-env.sh` and add set additional configurations

      export STACK_NAME=KubernetesStack
      export NUMBER_OF_MINIONS=3
      export MAX_NUMBER_OF_MINIONS=3
      export MASTER_FLAVOR=m1.small
      export MINION_FLAVOR=m1.small
      export EXTERNAL_NETWORK=public
      export DNS_SERVER=8.8.8.8
      export IMAGE_URL_PATH=http://cloud.centos.org/centos/7/images
      export IMAGE_FILE=CentOS-7-x86_64-GenericCloud-1510.qcow2
      export SWIFT_SERVER_URL=http://192.168.123.100:8080
      export ENABLE_PROXY=false

as mentioned by [documentation](http://kubernetes.io/docs/getting-started-guides/openstack-heat/#getting-started-with-openstack).

+ Download and unpack `Kubernetes` from [here](https://github.com/kubernetes/kubernetes/releases).

+ Fix the path to server files in `kubernetes/cluster/openstack-heat/util.sh`. On lines 112 or thereabouts there are two lines that have a path name involving `/_output/release_tars/`. Replace it with `/server/`. Alternatively, you can create folders '_output/relase_tars' in the kubernetes root folder, and inside create symlinks to files in `kubernetes/server`.

cd /var/lib/cloud/instance/scripts/

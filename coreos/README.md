# Deploying Kubernetes cluster on OpenStack using CoreOS


Full and detailed documentation can be found [here](https://coreos.com/kubernetes/docs/latest/getting-started.html). Working through it can take some time. This document is a short guid for launching a kubernetes cluster on openstack.

## Overview

### Variables
Variables that are used through out the tutorial are listed here. Some are static, and some need to be changed depending on your environment.

#### Variables that need to change:
+ `MASTER_HOST`: This is the ip address of the maser node.
+ `ETCD_ENDPOINTS`: This is a comma separated list of all the nodes involved in the `etcd` network, with each item in the form `http://ip:port`.
+ `PUBLIC_IP`: The public ip address of a given node.

### Vairbales that don't need to change:
+ `POD_NETWORK`= 10.2.0.0/16
+ `SERVICE_IP_RANGE`=10.3.0.0/24
+ `K8S_SERVICE_IP`=10.3.0.1
+ `DNS_SERVICE`_IP=10.3.0.10

See the documentation for a description of what each one of these variables is.

The general roadmap for getting the service up and running is to

1. Deploy `etcd` network.
2. Deploy nodes (master and workers).
3. Configure `kubectl`.

## Deploying an `etcd` cluster

## Generating Kubernetes TLS Assets

Authentication process is done using TLS. In order for this to work we need to create some public and private keys. All the following is done on your local machine. You can follow this document or look at the [full documentation](https://coreos.com/kubernetes/docs/latest/openssl.html).

    $ openssl genrsa -out ca-key.pem 2048
    $ openssl req -x509 -new -nodes -key ca-key.pem -days 10000 -out ca.pem -subj "/CN=kube-ca"

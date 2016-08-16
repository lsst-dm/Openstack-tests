# Deploying Kubernetes cluster on OpenStack using CoreOS


Full and detailed documentation can be found [here](https://coreos.com/kubernetes/docs/latest/getting-started.html). Working through it can take some time. This document is a short guid for launching a kubernetes cluster on openstack.

## Overview

### Variables
Variables that are used throughout the tutorial are listed here. Some are static, and some need to be changed depending on your environment.

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

In the root directory of your project (I called mine `~/coreos/`) create a directory named `Auth` and `cd` into it. Then run the following commands.

##### Cluster Root CA
    $ openssl genrsa -out ca-key.pem 2048
    $ openssl req -x509 -new -nodes -key ca-key.pem -days 10000 -out ca.pem -subj "/CN=kube-ca"

##### Kubernetes API Server keys
Create a file `openssl.cnf` with contents

    [req]
    req_extensions = v3_req
    distinguished_name = req_distinguished_name
    [req_distinguished_name]
    [ v3_req ]
    basicConstraints = CA:FALSE
    keyUsage = nonRepudiation, digitalSignature, keyEncipherment
    subjectAltName = @alt_names
    [alt_names]
    DNS.1 = kubernetes
    DNS.2 = kubernetes.default
    DNS.3 = kubernetes.default.svc
    DNS.4 = kubernetes.default.svc.cluster.local
    IP.1 = ${K8S_SERVICE_IP}
    IP.2 = ${MASTER_HOST}

And in here,  replace `${K8S_SERVICE_IP}` and `${MASTER_HOST}`.

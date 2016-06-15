# `Openstack` and `Python NovaClient`

This is where I'll maintain a list of issues I have encountered, or anticipate to encounter.

### How to run it:

__Warning:__ Before running this, make sure your environment is set up correctly.

__Warning:__ Make sure your `ssh` key pair is already set up.

__Warning:__ Make sure the floating_ip that is assigned to your new VM is now listed as a known host in ~/.ssh/known_hosts. Otherwise, it'll throw an error.

Once all the warnings above are met, all you should need to do is to be in the right folder and run:

    fab setUpMyVM

## Overview
We will be using `NovaClient` to connect to `acx.ncsa.illinois.edu`, and start an instance.

We use `Fabric` to connect and run shell commands on the remot VM.

#### Files:
+ __des_labs-openrc.sh__ This sets the environment variables that are necessary for connecting and authenticating when using `NovaClient`.

+ __OpenStackVirtualMachine.py__ This file implements a class that handles all the operations needed for connecting and instantiating VMs.

+ __fabfile.py__ This is the file that `Fabric` loads when the command `fab` is called. `Fabric` is used for `ssh` connection as well as running shell commands on the remote VM.


## Using NovaClient to Connect and instantiate a VM.

[Here is the link to NovaClient](https://pypi.python.org/pypi/python-novaclient).

Before getting down to using this, make sure you obtain __des_labs-openrc.sh__ from acx. Once you have the file, then you need to `source` it so that the environment variables are set.

Also note, you need to create your `ssh` key pair before using any of this.

The file __OpenStackVirtualMachine.py__ implements a class with various methods which are essentially steps taken in the connecting and creating instances of VMs.

##### Issues encountered and resolved:

+ For some reason, when I `source` the __des_labs-openrc.sh__ file from inside this file, the environment variables don't get set up properly.
+ Authentication will fail if you try to use `Nova` straight away. The solution is to use `keystone` for authentication step.   

##### Issues with non-ideal workarounds:
+ When you create a new instance, and associated it with an existing key-pair, an error is produced when doing `ssh` complaining about the fact that the host has changed. __Workaround__: Get rid of the line created in ~/.ssh/known_hosts.
+ When trying to associate a `floating_ip` after and instance (server) has been created, an error is produced. This is because it takes some time for the instance to "spawn". __Workaround__: Add a 5 second delay in your code before making the association. This is really a hack. The best way to deal with this is to ping the VM in a loop and wait for a "ready" signal before assigning the floating_ip, similar to `waitForSSH` function in __fabfiles.py__.

## Connecting to VM using `Fabric`, after it has been instantiated.

[Here is the link to Fabric](http://www.fabfile.org/).

Fabric enables us to have access to command-line tools on the remote VM. You simply run `fab *function name*`, where `*function*` is defined in fabfile.py.

1. Create fabfile.
2. set `env.host_string`,`env.user`, and `env.key_filename`
3. use the function `run("shell commands")` to connect and run commands on the remote VM.

__Note:__ Since we are using `ssh` key pairs for authentication, `env.key_filename` is necessary for Fabric to work properly.

##### Unresolved issues:
+

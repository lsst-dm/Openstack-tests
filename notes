# NovaClient

This is where I'll maintain a list of issues I have encountered, or anticipate to encounter.



__Potential problem:__ When you create a new instance, and associated it with an existing key-pair, an error is produced when doing `ssh` complaining about the fact that the host has changed.

## Connecting to VM using `Fabric`, after it has been instantiated.

1. Create fabfile.
2. set `env.host_string`,`env.user`, and `env.key_filename`
3. use the function `run("shell commands")` to connect and run commands on the remot VM.

__Issue:__ Error produced: `fabric.exceptions.NetworkError: Low level socket error connecting to host 141.142.236.177 on port 22: Unable to connect to port 22 on 141.142.236.177 (tried 1 time)`

###### Things I've tried:
1. Tried changing the port to 5000. Did not work.
2. Tried connecting to `localhost`. This worked fine.

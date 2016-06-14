from novaclient import client
from credentials import get_nova_creds
from keystoneclient.auth.identity import v2
from keystoneclient import session
import time
'''
Here we...
    1. Create a connection to acx.ncsa.illinois.edu.
    2. Create an image.
    3. Install softwares on the image.
    4. Delete the image.

+ Some environment variables need to be set. This is done by sourcing the file
  des_labs-openrc.sh. This file can be obtained by logging into acx.ncsa.illinois.edu,
  Access & Security >> API Acess >> Download OpenStack RC file.
+ The function get_nova_creds() in credentials.py is used to collect all the credentials
  into a dictionary in order to pass it to the nova client.
+ We use keystone client for authentication using the novaclient. For some reason,
  we get authentication failure message without it.

For detailed documntation of all the steps, see:
    http://docs.openstack.org/developer/python-novaclient/api.html

Written by: Sahand
06/14/2016

Using the webapp to create a new image, these are the steps:
    1. Click Launch instance.
    2. Give the instance a name.
    3. Choose a flavor.
    4. Choose boot soruce (boot from image).
    5. Choose Ubuntu 14.10
    6. Tab over to key pair.
    7. create key pair if one doesn't exist.
    8. Once launched, associate a floating_ip.

We now recreate these steps using novaclient.
'''


creds   = get_nova_creds()
auth    = v2.Password(**creds)
VERSION = "2"

sess    = session.Session(auth=auth)
nova    = client.Client(VERSION,session=sess)

fl      = nova.flavors.find(name="m1.medium")
im      = nova.images.find(name="Ubuntu 14.04.2 LTS")
key     = nova.keypairs.list()[0]

try:
    fip = nova.floating_ips.findall(instance_id=None)[0]
except: # if none found, create a new ip.
    fip = nova.floating_ips.create(nova.floating_ip_pools.list()[0].name)

server = nova.servers.create(
                            name="sahand_test",
                            image=im.id,
                            flavor=fl.id,
                            key_name=key.name,
                            min_count=1
                            )




# This is to allow time for the instance to spaw before other actions
# There has to be a better way to wait for the instance to be created.
# TODO
time.sleep(5)

server.add_floating_ip(fip)

# Once everything is done and I want to quit
print "Sleep for 10 seconds starting now. Then delete."
time.sleep(10)
server.delete()

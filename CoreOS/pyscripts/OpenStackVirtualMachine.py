from novaclient import client
from keystoneclient.auth.identity import v2
from keystoneclient import session
import time
import os

'''
======================================================================
The following is the list of tasks in this file:
    1. Create a connection to acx.ncsa.illinois.edu.
    2. Create an image.
    3. Install softwares on the image.
    4. Delete the image.

+ Some environment variables need to be set. This is done by sourcing the file
  des_labs-openrc.sh. This file can be obtained by logging into acx.ncsa.illinois.edu,
  Access & Security >> API Acess >> Download OpenStack RC file.
+ The function get_nova_creds() in credentials.py is used to collect all the credentials into a dictionary in order to pass it to the nova client.
+ We use keystone client for authentication using the novaclient. For some reason,we get authentication failure message without it.
+ Note that you have to have an ssh keypair already.

For detailed documntation of all the steps, see:
    http://docs.openstack.org/developer/python-novaclient/api.html

Written by: Sahand
Initial release: 06/14/2016
Update 1: 06/17/2016
======================================================================
'''

class OSVM:

    def __init__(self,InstanceName):
        self._InstanceName = InstanceName
        self._Credentials  = {}

    def getNovaCreds(self):
        print "Gathering credentials..."
        self._Credentials['username']  = os.environ['OS_USERNAME']
        self._Credentials['password']  = os.environ['OS_PASSWORD']
        self._Credentials['auth_url']  = os.environ['OS_AUTH_URL']
        self._Credentials['tenant_id'] = os.environ['OS_TENANT_ID']

    def setNova(self):
        print "Setting up authentication session..."
        try:
            self.getNovaCreds()
            print "Credentials are set! :). \n"
        except Exception,e:
            print "==> error: You need to source the des_labs-openrc file in order to set up your environment.\n Please do that and run your fab command again."
            exit()

        auth    = v2.Password(**self._Credentials)
        VERSION = "2"
        sess    = session.Session(auth=auth)

        self._Nova    = client.Client(VERSION,session=sess)
        print "Choosing flavor, image and ssh key..."
        self._Flavor = self._Nova.flavors.find(name="m1.medium")
        self._Image  = self._Nova.images.find(name="CoreOS723")
        self._Key    = self._Nova.keypairs.find(name="acx")

    def setHost(self):
        print "Getting a floating IP address..."
        try:
            self._Host = self._Nova.floating_ips.findall(instance_id=None)[0]
        except: # if none found, create a new ip.
            print "No more available IP addresse. Creating a new one..."
            self._Host = self._Nova.floating_ips.create(nova.floating_ip_pools.list()[0].name)

    def startInstance(self):
        print "\n==>>Starting the instance<<==\n"
        self._Instance = self._Nova.servers.create(
                                name=self._InstanceName,
                                image=self._Image.id,
                                flavor=self._Flavor.id,
                                key_name=self._Key.name,
                                min_count=1,
                                user_data="../files/master.yaml"
                                )

    def assignFLoatingIP(self):
        print "Assigning floating ip to instance..."
        print "Waiting for VM to start up..."
        while True:
            time.sleep(0.5)
            try:
                self._Instance.add_floating_ip(self._Host)
                print "IP assigned! :). \n"
                return
            except Exception,e:
                print "Failed to to assign IP. VM not up yet..."
                pass

    def deleteInstance(self):
        print "Deleting the instance. Bye :)!"
        # Once everything is done and I want to quit
        time.sleep(10)
        self._Instance.delete()

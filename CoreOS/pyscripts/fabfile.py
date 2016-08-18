from fabric.api import *
from OpenStackVirtualMachine import OSVM
import time
import socket


def startInstance(vmname):
    print "\n+++ Set Up and Instantiate the VM +++"
    #vmname = raw_input("Enter VM name: ")
    vm = OSVM(vmname)
    vm.setNova()
    vm.setHost()
    vm.startInstance()
    vm.assignFLoatingIP()
    print "++++++ Done with Setting Up :) +++++++\n"
    return vm

def setFabCreds(vm):
    print "Set Fabric env values for authentication."
    env.user = 'core'
    env.host_string = (vm._Host).ip
    env.key_filename = '~/.ssh/acx.key'

def setUpMyVM():
    cluster_name = raw_input("Enter base name for your cluster: ")
    cluster_size = input("Enter the number of worker nodes: ")

    startInstance(cluster_name+"-master")
    '''
    local('nova boot --image CoreOS723 \
    --key-name acx \
    --flavor m1.medium \
    --security-group kubernetes \
    --user-data ../files/master.yaml %s'%(cluster_name+"-master"))
    '''

    for ii in range(cluster_size):
        print "setting up minions..."
        startInstance(cluster_name+"-minion"+str(ii+1))
        '''
        local('nova boot --image CoreOS723 \
        --key-name acx \
        --flavor m1.medium \
        --security-group kubernetes \
        --user-data ../files/node.yaml %s'%(cluster_name+"-minion"+str(ii+1)))
        '''

def waitForSSH():
    print "Pinging the remote VM for readiness..."
    address=env.host_string
    port=22
    while True:
        time.sleep(2)
        try:
            s=socket.socket()
            s.connect((address,port))
            print "Connected :). \n"
            return
        except Exception,e:
            print "Failed to connect to %s:%s. VM not up yet..." %(address,port)
            pass

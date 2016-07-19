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
    env.user = 'ubuntu'
    env.host_string = (vm._Host).ip
    env.key_filename = '../acx.key'

def setUpMyVM():
    vm=startInstance("sahand")
    setFabCreds(vm)
    local('ssh-keygen -R %s'%env.host_string)
    waitForSSH()

    print "Communicating with the remote VM..."
    put('./scripts/StarterScript.sh')
    put('./scripts/Dockerfile')
    put('~/.vim')
    put('~/.vimrc')
    run('source ./StarterScript.sh')

def buildDockerImage():
    vm=startInstance("ImageBuilder")
    setFabCreds(vm)
    local('ssh-keygen -R %s'%env.host_string)
    waitForSSH()
    print "Communicating with the remote VM..."
    put('./scripts/BuildDockerImage.sh')
    put('./scripts/Dockerfile')
    put('~/.vim')
    put('~/.vimrc')
    run('source ./BuildDockerImage.sh')

def setUpClusterWithDocker():
    mvm = raw_input("What is the name of the master node? ")
    svm = raw_input("What is the name of this slave node? ")
    setUpMasterNodeWithDocker(mvm)
    setUpSlaveNodeWithDocker(svm)

def setUpMasterNodeWithDocker(vmname):
    print "Setting up the master node..."
    vm=startInstance(vmname)
    setFabCreds(vm)
    local('ssh-keygen -R %s'%env.host_string)
    waitForSSH()

    run("ssh-keygen -f .ssh/sshkey.rsa -t rsa -N ''")
    get('.ssh/sshkey.rsa.pub','./')

    print "Communicating with the remote VM..."
    put('~/.vim')
    put('~/.vimrc')
    put('./scripts/SetUpDocker.sh')
    run('source ./SetUpDocker.sh')

def setUpSlaveNodeWithDocker(vmname):
    print "setting up a slave node..."
    vm=startInstance(vmname)
    setFabCreds(vm)
    local('ssh-keygen -R %s'%env.host_string)
    waitForSSH()

    put('./sshkey.rsa.pub','.ssh/')
    local('rm sshkey.rsa.pub')
    run('cat .ssh/sshkey.rsa.pub >> .ssh/authorized_keys')

    print "Communicating with the remote VM..."
    put('~/.vim')
    put('~/.vimrc')
    put('./scripts/SetUpDocker.sh')
    run('source ./SetUpDocker.sh')

# This needs work.
def setUpDockerImageMaintainer():
    print "setting up an image maintainer VM..."
    vm=startInstance(vmname)
    setFabCreds(vm)
    local('ssh-keygen -R %s'%env.host_string)
    waitForSSH()

    print "Communicating with the remote VM..."
    put('~/.vim')
    put('~/.vimrc')
    run('docker pull sahandha/ubuntu')
    put('./scripts/DockerFile.sh')
    # put('./scripts/SetUpDocker.sh')
    # run('source ./SetUpDocker.sh')

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

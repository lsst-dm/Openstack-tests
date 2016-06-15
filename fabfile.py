from fabric.api import *
from OpenStackVirtualMachine import OSVM
import time
import socket

#vm = OSVM("sahand_test")

env.user = 'ubuntu'
env.hosts = ['141.142.236.177']
env.key_filename = './acx.key'

def StartInstance():
    #vm = OSVM("sahand_test")
    vm.setNova()
    vm.setHost()
    vm.startInstance()
    vm.assignFLoatingIP()

def StartInstanceFinish():
    #vm = OSVM("sahand_test")
    vm.setNova()
    vm.setHost()
    vm.startInstance()
    vm.assignFLoatingIP()
    vm.deleteInstance() # This is the differnce

def SetUpMyVM():
    #vm = OSVM("sahand_test")
    vm.setNova()
    vm.setHost()
    vm.startInstance()
    vm.assignFLoatingIP()

    env.user = 'ubuntu'
    env.host_string = (vm._Host).ip
    env.key_filename = './acx.key'
    n = 20
    print "wait %d seconds" %n
    time.sleep(n)
    run('touch myTestFile')

def TestConnectionOnly():
    run('sudo apt-get install wget')

def ConnectToMe():
    env.host_string = '127.0.0.1'
    env.user = 'sahand'
    run('ls')
    run('touch myTestFile')

from fabric.api import *
from OpenStackVirtualMachine import OSVM
import time

def StartInstance():
    vm = OSVM("sahand_test")
    vm.setNova()
    vm.setHost()
    vm.startInstance()
    vm.assignFLoatingIP()

def StartInstanceFinish():
    vm = OSVM("sahand_test")
    vm.setNova()
    vm.setHost()
    vm.startInstance()
    vm.assignFLoatingIP()
    vm.deleteInstance() # This is the differnce

def SetUpMyVM():
    vm = OSVM("sahand_test")
    vm.setNova()
    vm.setHost()
    vm.startInstance()
    vm.assignFLoatingIP()

    #env.skip_bad_hosts = True
    env.user = 'ubuntu'
    env.host_string = (vm._Host).ip
    #env.port = 5000
    env.key_filename = './acx.key'

    run('touch myTestFile')

def ConnectToMe():
    env.host_string = '127.0.0.1'
    env.user = 'sahand'
    run('ls')
    run('touch myTestFile')

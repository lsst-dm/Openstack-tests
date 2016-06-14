from fabric.api import *
from OpenStackVirtualMachine import OSVM

def StartInstance():
    vm = OSVM("sahand_test")
    vm.get_nova_creds()
    vm.setNova()
    vm.setHost()
    vm.startInstance()
    vm.assignFLoatingIP()
    vm.deleteInstance()

#!/usr/bin/env python
import os

def get_nova_creds():
    d = {}
    d['username']  = os.environ['OS_USERNAME']
    d['password']  = os.environ['OS_PASSWORD']
    d['auth_url']  = os.environ['OS_AUTH_URL']
    d['tenant_id'] = os.environ['OS_TENANT_ID']
    return d

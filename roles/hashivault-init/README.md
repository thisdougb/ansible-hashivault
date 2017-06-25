# hashivault-init
Initialises (resets!) a HashiCorp Vault via http API calls, and stores the keys within the roles dir on the Ansible host.   If you have a vault with existing data this role will wipe it.    If you just want to unseal an existing vault then use the hashivault-unseal role.

This role was built for dev and test purposes, and is partnered with the hashivault-unseal role.

*WARNING* This role removes any existing Vault data, fully resets the Vault.

## Requirements
None

## Role Variables
None


## Dependencies
None

## Example Playbook
```
---
# vault.yml
- hosts: vault
  roles:
         - { role: hashivault-init, tags: ['hashivault-init'] }
```
To initialise Vault on a node:
```
ansible-playbook -i hosts vault.yml
```
Check the keys were stored locally:
```
ansible $ cat ~/.hashicorp_vault_keys.json 
{"keys": ["18d17378da71502e352125af618e14948af3245ae5d91438d5b3e5682776a59a01", "3fca30358dfb06fc295abf0fcea8f902df9a17e7bc5fd114393d041d10f3cdf302"], "keys_base64": ["GNFzeNpxUC41ISWvYY4UlIrzJFrl2RQ41bPlaCd2pZoB", "P8owNY37BvwpWr8Pzqj5At+aF+e8X9EUOT0EHRDzzfMC"], "root_token": "8c1ccc6c-0042-f77b-785d-7a1d7bf6fa53"}
```

## License
BSD

## Author Information
[thisdougb](https://github.com/thisdougb)

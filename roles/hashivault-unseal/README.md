# hashivault-unseal
Unseals an existing HashiCorp Vault via http API calls.  This role was built for dev and test purposes, and is partnered with the hashivault-init role.

*WARNING* This role removes any existing Vault data, fully resets the Vault.

## Requirements
The keys to unseal the vault must exist in the roles dir, and are created with the hashivault-init role.

## Role Variables
No standard format Ansible variables, however this role use vault key data.

```
- name: retrieve keys locally
  set_fact:
    vault_keys: "{{ lookup('file','~/.hashicorp_vault_keys.json') | from_json }}"
  delegate_to: localhost
```

## Dependencies
None

## Example Playbook
```
---
# vault.yml
- hosts: vault
  roles:
         - { role: hashivault-unseal, tags: ['hashivault-unseal'] }
```
To initialise Vault on a node:
```
ansible-playbook -i hosts vault.yml
```

## License
BSD

## Author Information
[thisdougb](https://github.com/thisdougb)

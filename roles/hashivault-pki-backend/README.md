hashivault-pki-backend
=========

Mounts the PKI backend, setting up the vault instance as a root CA capable of issuing certificates.   Also starts a vault listener using TLS on port 8021, adding its root CA key to the calling ansible node allowing subsequent vault API calls using https.

The role adds both the short hostname and the fqdn to the certificate.

Requirements
------------
We use the domain name from the vault instance in the certificate generation, so we need gather_facts set in the playbook.

      common_name:
        "{{ ansible_fqdn }}"

Adding a new listener requires a restart of the vault service (to re-read the vault.cfg), so the vault will have to be unsealed after this role runs.

Role Variables
--------------


Dependencies
------------
The role authenticates against vault using the root_token, which the vault-init role saves locally on the ansible node.

```
- name: retrieve keys locally
  set_fact:
    vault_keys: "{{ lookup('file','~/.hashicorp_vault_keys.json') | from_json }}"
  delegate_to: localhost
  become: no
```


Example Playbook
----------------

```
---
- hosts: vault
  gather_facts: yes
  roles:
    - role: hashivault
    - role: hashivault-init
    - role: hashivault-unseal
    - role: hashivault-pki-backend
    - { role: hashivault-unseal, do_it: 'again' }
```
And to check all is working:
```
ansible $ wget -qO- https://vault.example.com:8201/v1/sys/health
{"initialized":true,"sealed":false,"standby":false,"server_time_utc":1498389349,"version":"0.6.2","cluster_name":"vault-cluster-f2e181a0","cluster_id":"966a0f1d-dc6d-860c-b62c-bbb8afddf835"}
```

License
-------

BSD

Author Information
------------------
@thisdougb

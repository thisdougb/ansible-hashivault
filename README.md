# ansible-hashivault
Vagrant and Ansible code to build a HashiCorp Vault instance for testing.   Built for Centos/RHEL.

### Create Vault Instance
Create an instance to run the vault, if using Vagrant see the sub-dir ~/vagrant from this repo.   The ansible inventory file uses the hostname 'vault'.

### Ansible Bootstrap
Bootstrap the new vault instance with the Ansible ssh key, which defaults to the key in ~/.ssh/id_rsa.pub.   We also install the host systems /etc/hosts, which should contain your vault instance.   Installing net-tools is useful for testing.
```
ansible $ ansible-playbook bootstrap_hosts.yml -k -K
SSH password: 
SUDO password[defaults to SSH password]: 

PLAY [all] *********************************************************

TASK [install Ansible ssh key] *************************************
changed: [vault]

TASK [copy /etc/hosts to remote] ***********************************
changed: [vault]

TASK [install net-tools] *******************************************
changed: [vault]

PLAY RECAP *********************************************************
vault                      : ok=3    changed=3    unreachable=0    failed=0
```

### Install HashiCorp Vault
Now you can go ahead and install your vault instance.
```
ansible $ ansible-playbook vault.yml
```

### Quick Status Check
Sudo to root on the vault instance and check that vault is up and running:
```
laptop $ vagrant ssh 
[vagrant@vault ~]$ sudo su -
[root@vault ~]# systemctl status vault
● vault.service - Hashi Corp Vault
   Loaded: loaded (/etc/systemd/system/vault.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2017-06-23 16:00:22 BST; 10min ago
 Main PID: 6873 (vault)
   CGroup: /system.slice/vault.service
           └─6873 /usr/local/bin//vault server -config /etc/vault.cfg
```
Use the vault cli to check the status:
```
[root@vault ~]# vault status
Sealed: false
Key Shares: 2
Key Threshold: 2
Unseal Progress: 0
Version: 0.6.2
Cluster Name: vault-cluster-bbdec3aa
Cluster ID: 4ac16b0f-39d2-5e8b-6030-2621184ee023

High-Availability Enabled: false
```

We can also check what backends vault has currently mounted:
```
[root@vault ~]# vault mounts
Path        Type       Default TTL  Max TTL  Description
cubbyhole/  cubbyhole  n/a          n/a      per-token private secret storage
pki/        pki        system       system   Certificate delivery for Ansible
secret/     generic    system       system   generic secret storage
sys/        system     n/a          n/a      system endpoints used for control, policy and debugging
```

# Vagrant setup files

I use Vagrant to run all the demo's.  The Vagrantfile reads servers.yml and builds each listed server.   It also writes out an /etc/hosts style file to etc_hosts, we will use this in the Ansible bootstrap play.

An example of setting up your Vagrant env:

```
laptop $ mkdir vault-testing
laptop $ cd vault-testing/
laptop $ curl -sO https://raw.githubusercontent.com/thisdougb/ansible-hashivault/master/vagrant/Vagrantfile
laptop $ curl -sO https://raw.githubusercontent.com/thisdougb/ansible-hashivault/master/vagrant/servers.yml
```

Our instances are defined in servers.yml:
```
laptop $ cat servers.yml 
---
domain: example.com
hosts:
  - name: vault
    ip: 172.28.128.16
  
```

Now we can bring up our Vagrant instances:
```
laptop $ vagrant up
Bringing machine 'vault' up with 'virtualbox' provider...
==> vault: Importing base box 'centos7'...
==> vault: Matching MAC address for NAT networking...
==> vault: Setting the name of the VM: vault-testing_vault_1498226557504_11860
==> vault: Fixed port collision for 22 => 2222. Now on port 2200.
==> vault: Clearing any previously set network interfaces...
==> vault: Preparing network interfaces based on configuration...
    vault: Adapter 1: nat
    vault: Adapter 2: hostonly
==> vault: Forwarding ports...
    vault: 22 (guest) => 2200 (host) (adapter 1)
==> vault: Booting VM...
==> vault: Waiting for machine to boot. This may take a few minutes...
    vault: SSH address: 127.0.0.1:2200
    vault: SSH username: vagrant
    vault: SSH auth method: private key
    vault: Warning: Remote connection disconnect. Retrying...
    vault: 
    vault: Vagrant insecure key detected. Vagrant will automatically replace
    vault: this with a newly generated keypair for better security.
    vault: 
    vault: Inserting generated public key within guest...
    vault: Removing insecure key from the guest if it's present...
    vault: Key inserted! Disconnecting and reconnecting using new SSH key...
==> vault: Machine booted and ready!
==> vault: Checking for guest additions in VM...
==> vault: Setting hostname...
==> vault: Configuring and enabling network interfaces...
==> vault: Mounting shared folders...
    vault: /vagrant => /Users/doug/dev/vault-testing
```
The Vagrantfile script writes out the etc_hosts file, which is accessible on the target host through the shared mounted folder.   Our Ansible bootstrap_hosts.yml moves etc_hosts to /etc/hosts.
```
laptop $ cat etc_hosts 
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

172.28.128.16   vault   vault.example.com
```

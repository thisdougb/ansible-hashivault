# Vagrant setup files

I use Vagrant to run all the demo's.  The Vagrantfile reads servers.yml and builds each listed server.   It also writes out an /etc/hosts style file to ~/etc_hosts, so you can easily use this in the Ansible bootstrap play.

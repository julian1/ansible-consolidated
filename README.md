
### Examples

```
ansible-playbook dell-home.yml

ansible-playbook nodes/geonetwork2.yml -v

ansible-playbook nodes/apu.yml -i 192.168.42.1, -v

ansible-playbook nodes/aatams.yml -v

ansible-playbook nodes/julian-test-instance.yml  -v -u debian --private-key ~/.ssh/julian3.pem -s

# etc

``` 


### Prepare
```
ansible-galaxy install yaegashi.blockinfile -p ./roles/common

# or
sudo ansible-galaxy install yaegashi.blockinfile

```

### Useful flags
```
-s force use of sudo for all plays even if not marked as such
--private-key ~/.ssh/id_rsa
--ask-sudo-pass
-k ask pass
-u specify username 
-v verbose
# don't use ssh
-c local

# Use ping module
ansible all -i nc2, -c local -m ping
```

### Resources

https://raymii.org/s/tutorials/Ansible_-_Only-do-something-if-another-action-changed.html

http://stackoverflow.com/questions/30192490/include-tasks-from-another-role-in-ansible-playbook

https://github.com/phred/5minbootstrap/blob/master/bootstrap.yml

http://www.mechanicalfish.net/start-learning-ansible-with-one-line-and-no-files/

http://docs.ansible.com/ansible/playbooks_best_practices.html

### TODO

IMPORTANT - copy module can take a content argument, which makes it nicer 
            than blockinfile for general deployment   
            - it also supports template arg expansion

zfs build to use fixed release instead of master

email, tftp, anon ftp  

reverse-proxy kind of belongs on same node as the dns and dhcp
  
http authentication on reverse proxy

containerise dns and dhcp services? issue of dhcp relay / dhcp multicast?

smb with only port 445

vpn

node definition for catalyst switch

add a routing entry for container subnet in the apu to route to the laptop that hosts container. 
  - then other devices on lan can interact with container.
  - perhaps also make apu dns delegate to container dns.

  - if we can add a static routing entry on any client, then we should be able to access container subnet
  - probably point at the subnet dns as well


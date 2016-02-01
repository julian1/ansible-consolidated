
### Examples

```
ansible-playbook nodes/dell-home.yml
ansible-playbook nodes/aatams.yml -v
ansible-playbook nodes/apu.yml -i 192.168.42.1, -v
ansible-playbook nodes/julian-test-instance.yml  -v -u debian --private-key ~/.ssh/julian3.pem -s
ansible-playbook playbook/zfs.yml
ansible --list-hosts all
ansible -i inventory/imos --list-hosts all
```

### Mirrors
```
http://ftp.us.debian.org/debian
http://mirror.internode.on.net/pub/debian
http://mirror.aarnet.edu.au/debian
```

### Prepare
```
# local
ansible-galaxy install yaegashi.blockinfile -p ./roles/common

# or global
sudo ansible-galaxy install yaegashi.blockinfile
```

### Useful flags
```


--list-tasks    # show tasks that will be run
--check         # report what would have been done only
-s              # force use of sudo for all plays even if not marked as such
--private-key ~/.ssh/id_rsa
--ask-sudo-pass
-k ask pass     # useful before keys installed
-u specify username
-v verbose
-c local        # no ssh, spawn local shell

# Use ping module
ansible all -i nc2, -c local -m ping
```

### Resources

http://codeheaven.io/15-things-you-should-know-about-ansible/

https://raymii.org/s/tutorials/Ansible_-_Only-do-something-if-another-action-changed.html

http://stackoverflow.com/questions/30192490/include-tasks-from-another-role-in-ansible-playbook

https://github.com/phred/5minbootstrap/blob/master/bootstrap.yml

http://www.mechanicalfish.net/start-learning-ansible-with-one-line-and-no-files/

http://docs.ansible.com/ansible/playbooks_best_practices.html

### TODO


email, tftp, anon ftp

reverse-proxy kind of belongs on same node as the dns and dhcp

http authentication on reverse proxy

containerise dns and dhcp services? issue of dhcp relay / dhcp multicast?

smb using only port 445

vpn

node definition for catalyst switch

perhaps make router dns delegate to container dns.

done  - get rid of double-NAT
  - use a routing entry for container subnet in the apu to route to the container host.
  - permits other devices on lan to also interact with container

done - copy module can take a content argument, which makes it a lot nicer
            than blockinfile for general deployment
            - it also supports template arg expansion

done - zfs build to use fixed release instead of master



####
For use with systemd-nspawn containers, kvm, docker or virtual box.
  

#### Prepare
```
# local
ansible-galaxy install yaegashi.blockinfile -p ./roles

# or global
sudo ansible-galaxy install yaegashi.blockinfile
```


#### Examples

```
ansible-playbook nodes/dell-home.yml
ansible-playbook nodes/aatams.yml -v
ansible-playbook nodes/apu.yml -i 192.168.42.1, -v
ansible-playbook nodes/julian-test-instance.yml  -v -u debian --private-key ~/.ssh/julian3.pem -s

ansible --list-hosts all
ansible -i inventory/imos --list-hosts all

nsible-playbook ./roles/aatams/redeploy.yml
ansible-playbook -i localhost, roles/common/devenv-lite.yml
ansible-playbook -i localhost, roles/zfs/main.yml
```

#### Mirrors
```
http://ftp.us.debian.org/debian
http://mirror.internode.on.net/pub/debian
http://mirror.aarnet.edu.au/debian
```

#### Useful flags
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

#### Resources

https://www.stavros.io/posts/example-provisioning-and-deployment-ansible/

http://codeheaven.io/15-things-you-should-know-about-ansible/

https://raymii.org/s/tutorials/Ansible_-_Only-do-something-if-another-action-changed.html

http://stackoverflow.com/questions/30192490/include-tasks-from-another-role-in-ansible-playbook

https://github.com/phred/5minbootstrap/blob/master/bootstrap.yml

http://www.mechanicalfish.net/start-learning-ansible-with-one-line-and-no-files/

http://docs.ansible.com/ansible/playbooks_best_practices.html

#### TODO

Maybe directory partition imos from other nodes in the /nodes directory, similar to inventory/dev
email, tftp, anon ftp
git server
snmp
reverse-proxy kind of belongs on same node as the dns and dhcp
http authentication on reverse proxy
routing to aws box

containerise dns and dhcp services
  - issue of dhcp relay / dhcp broadcast? - no because all on same subnet
  - gateway (host bridge) at 10.0.0.1, but dns and dhcp at 10.0.0.2
  - upstream dns can just be set manually.

smb using only port 445

vpn

node definition for catalyst switch

perhaps make router dns delegate to container dns.
done - apu - vlans and qos
done - expose locale in the sameway as timezone
done - tftp on apu
done  - get rid of double-NAT
  - use a routing entry for container subnet in the apu to route to the container host.
  - permits other devices on lan to also interact with container
done - copy module can take a content argument, which makes it a lot nicer
            than blockinfile for general deployment
            - it also supports template arg expansion
done - zfs build to use fixed release instead of master

#### Notes

If we move the tasks in common/tasks/*.*  up to common/*.*, then they
  can probably be invoked as roles. which would make them easier
  to invoke...

It may be that the indirection between node, and role for the node is a bit useless
  with a one-to-one mapping. for nodes like apu
  but is that really be an issue. the benefit is the much cleaner lookup paths


  - It has to be a task to use the include statement
  - and a play with full dir structure to use in a role
  - and a play to call directly from ansible-playbook (which is very useful)
  - but there doesn't seem to be a way to use  

  - BUT - it's easy to have a play and a task 
      just make the play delegate to the task. see devenv-lite.yml for example


  - Good practice to have a generalized play that can be run against all hosts...
  versus specific plays
  ansible-playbook -i geoserver, roles/zfs/main.yml
  ansible-playbook -i geoserver, roles/debian/main.yml

  we had this in resources before...

#### Tags
  http://docs.ansible.com/ansible/playbooks_tags.html
  If you wanted to just run the “configuration” and “packages” part of a very long playbook, you could do this:
  ansible-playbook example.yml --tags "configuration,packages"



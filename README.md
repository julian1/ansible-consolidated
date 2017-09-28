
#### Ansible CM

Set of ansible definitions and plays for use with systemd-nspawn containers, kvm, cloud instances, VBox etc.


#### Examples

```
# nodes
ansible-playbook nodes/other/apu.yml -v
ansible-playbook nodes/other/apu.yml --tags bind,dhcp
ansible-playbook nodes/other/apu.yml -t iptables

ansible-playbook nodes/pglogical.yml -i pglogical.localnet,
ansible-playbook nodes/bind.yml -u root
ansible-playbook nodes/other/dell-home.yml  -c local
ansible-playbook nodes/aatams.yml -v
ansible-playbook nodes/archiva.yml   -i archiva, -u debian --private-key ~/.ssh/julian3.pem -s
ansible-playbook nodes/aatams-dev.yml -i aatams-test-instance, -u debian --private-key ~/.ssh/julian3.pem -s
ansible-playbook nodes/geoserver.yml -i geoserver-test, -u debian --private-key ~/.ssh/julian3.pem -s
ansible-playbook nodes/geoserver.yml -i geoserver-test,
ansible-playbook nodes/14-nec-hob.yml  -u ubuntu --private-key ~/.ssh/julian3.pem -s

# plays
ansible-playbook plays/misc/chefdk.yml -i dell-work,
ansible-playbook plays/meteo.yml -i parity, -u admin -s
ansible-playbook plays/devenv-lite.yml -i localhost,
ansible-playbook plays/work-localnet.yml -i localhost,
ansible-playbook plays/restart-tomcat.yml -i n.n.n.n,
ansible-playbook plays/admin/postfix.yml -i do-01,

ansible-playbook plays/admin/deploy-war.yml -i geoserver.localnet, --extra-vars "warpath=~/imos/may-18-geoserver/geoserver-1.0.0-imos.war warname=geoserver.war"
ansible-playbook plays/admin/deploy-war.yml -i geowebcache.localnet, --extra-vars "warpath=~/imos/geowebcache/geowebcache/web/target/geowebcache.war warname=geowebcache.war"

ansible-playbook ./plays/admin/deploy-war.yml -i geonetwork2.localnet, --extra-vars "warpath=~/imos/core-geonetwork/web/target/geonetwork.war warname=geonetwork.war"

# useful
ansible --list-hosts all
ansible -i inventory/imos --list-hosts all

# specify interpreter
ansible-playbook -e 'ansible_python_interpreter=/usr/bin/python2.7

# aws instances
ansible-playbook nodes/publications.yml -i n.n.n.n.n, -u admin --private-key ~/.ssh/julian-aws-bsd.pem  -s

# list and run tagged roles only
ansible-playbook nodes/dell-home.yml --list-tags
ansible-playbook nodes/dell-home.yml -t dotfiles

```

#### Useful flags
```

--list-tags         # list tagged roles
--list-tasks        # list tasks that will be run
--check             # report what would have been done only
-s                  # force use of sudo for all plays even if not marked as such
--private-key ~/.ssh/id_rsa
--ask-sudo-pass
-k ask pass         # useful before keys installed
-u specify username
-v verbose
-c local            # no ssh, spawn local shell

# Use ping module
ansible all -i nc2, -c local -m ping
```

#### Important

- rather than use register varaibles to flag the need for service restart, should write a file, and read again at the end.  this will handle the case, when provision needs to be done again. eg. for network port forwarding etc.

-  Requires Ansible version >= 2

- ansible expects either passwordless sudo or root ssh - issue with passwordless sudo on ordinary account means processes potentially can sudo without password so it's reasonable to have password on root

- can use apt package python-minimal to get /usr/bin/python instead of /usr/bin/python2.7

- How to use command item and with_items together with chdir https://stackoverflow.com/questions/24851575/ansible-how-to-pass-multiple-commands



#### Resources

https://www.stavros.io/posts/example-provisioning-and-deployment-ansible/

http://codeheaven.io/15-things-you-should-know-about-ansible/

https://raymii.org/s/tutorials/Ansible_-_Only-do-something-if-another-action-changed.html

http://stackoverflow.com/questions/30192490/include-tasks-from-another-role-in-ansible-playbook

https://github.com/phred/5minbootstrap/blob/master/bootstrap.yml

http://www.mechanicalfish.net/start-learning-ansible-with-one-line-and-no-files/

http://docs.ansible.com/ansible/playbooks_best_practices.html


#### Notes



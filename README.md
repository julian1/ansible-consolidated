

#### TODO  
  - remove root login from sshd, use su.
  - apu, needs apt/sources.list

#### Ansible CM

Use with systemd-nspawn containers, kvm, cloud instances, VBox etc.

Requires Ansible version >= 2

#### Examples

```
# nodes
ansible-playbook nodes/pglogical.yml -i pglogical.localnet,
ansible-playbook nodes/bind.yml -u root
ansible-playbook nodes/dell-home.yml
ansible-playbook nodes/aatams.yml -v
ansible-playbook nodes/archiva.yml   -i archiva, -u debian --private-key ~/.ssh/julian3.pem -s
ansible-playbook nodes/aatams-dev.yml -i aatams-test-instance, -u debian --private-key ~/.ssh/julian3.pem -s
ansible-playbook nodes/geoserver.yml -i geoserver-test, -u debian --private-key ~/.ssh/julian3.pem -s
ansible-playbook nodes/geoserver.yml -i geoserver-test,
ansible-playbook nodes/14-nec-hob.yml  -u ubuntu --private-key ~/.ssh/julian3.pem -s
ansible-playbook nodes/other/apu.yml -v
ansible-playbook nodes/other/apu.yml -t iptables


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

# aws instances
ansible-playbook nodes/publications.yml -i n.n.n.n.n, -u admin --private-key ~/.ssh/julian-aws-bsd.pem  -s

# list and run tagged roles only
ansible-playbook nodes/dell-home.yml --list-tags
ansible-playbook nodes/dell-home.yml -t dotfiles

```

#### Using tags,

    # for role
    roles:
      - locale
      - common
      - { role: dotfiles, tags: [ 'dotfiles' ] }

    # for task
    - copy:
        dest: /ansible/provider.sql
        content: |
          ...
      register: last_result
      tags: whoot


#### Local actions


#### register variables


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

- rather than use register varaibles to flag the need for service restart, should write a file, and read again at the end.
this will handle the case, when provision needs to be done again. eg. for network port forwarding etc.


#### Resources

https://www.stavros.io/posts/example-provisioning-and-deployment-ansible/

http://codeheaven.io/15-things-you-should-know-about-ansible/

https://raymii.org/s/tutorials/Ansible_-_Only-do-something-if-another-action-changed.html

http://stackoverflow.com/questions/30192490/include-tasks-from-another-role-in-ansible-playbook

https://github.com/phred/5minbootstrap/blob/master/bootstrap.yml

http://www.mechanicalfish.net/start-learning-ansible-with-one-line-and-no-files/

http://docs.ansible.com/ansible/playbooks_best_practices.html

#### TODO

- should set generic user... so can install root.


IMPORTANT
  - sshd and dnsmasq should only listen internal interfaces - eg. 192.168.100.0/24 not 0.0.0.0

  - ip iptables should only forward 192.168.0.0/16 not 0.0.0.0

  - likewise dnsmasq and other services

make single vlan 200 for ordinary machines - and trunk vlan to cisco2.


limit iptables forwarding for non 80,443,dns,dhcp between vlans. 22 only only on vlan 100

do similar for dnsmasq, and use internal network interface only.
  eg. 192.168.0.0

fix dhcpd and ntpd which are listening on 0.0.0.1

chmod 700 on home directories

Strategy for IOS, md5sum the cisco config file and compare. if different then upload, and reboot.

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



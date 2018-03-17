
#### Ansible CM

Set of ansible definitions and plays for use with systemd-nspawn containers, kvm, cloud instances, vbox etc.


#### Examples

```
# nodes
ansible-playbook plays/nodes/other/apu.yml --tags bind,dhcp,iptables
ansible-playbook plays/nodes/other/dell-home.yml -c local -i localhost,   # run as root
ansible-playbook plays/nodes/other/pglogical.yml -i pglogical.localnet,

# plays
ansible-playbook plays/personal/dotfiles.yml -i localhost, -c local
ansible-playbook plays/personal/scripts.yml -i localhost, -c local
ansible-playbook plays/admin/openvpn.yml -i vpn,
ansible-playbook plays/admin/devenv-lite.yml -i localhost, -c local
ansible-playbook plays/admin/postfix.yml -i mail.n.n,

ansible-playbook plays/admin/deploy-war.yml -i geoserver.localnet, --extra-vars "warpath=~/imos/may-18-geoserver/geoserver-1.0.0-imos.war warname=geoserver.war"

# overriding play vars
ansible-playbook ./plays/personal/dotfiles.yml -i localhost, -c local --extra-vars "path=/root user=root"
ansible-playbook ./plays/personal/dotfiles.yml -i apu2,  --extra-vars "path=/home/parity user=parity"


# initial
apt-get install python-minimal
export myhost=n.n.n.n

ansible-playbook plays/admin/hostname.yml -i $myhost, --extra-vars "hostname=$myhost"
ansible-playbook plays/admin/sshd.yml -i $myhost,
ansible-playbook plays/personal/meteo.yml -i $myhost,
ansible-playbook plays/personal/meteo-sudo.yml -i $myhost,

# or specific,
ansible-playbook plays/admin/devenv-lite.yml -i $myhost,
ansible-playbook plays/admin/timezone.yml -i $myhost,
ansible-playbook plays/admin/locale.yml -i $myhost,
ansible-playbook plays/personal/dotfiles.yml -i $myhost,


# flags
ansible --list-hosts all
ansible -i inventory/imos --list-hosts all
ansible-playbook nodes/other/dell-home.yml --list-tags
ansible-playbook nodes/aodn/aatams.yml -v

```

TODO
  - for complicated sequences, a deployable template/script that gets deployed and called, may be simpler.

  - to keep code composible, where it can be used in different contexts, it must be in a role, rather than
    a play. the play is just the thing that co-ordinates the plays.
      - therefore we want to factor stuff out of the play - especially the pre_tasks user creation
      - actually that doesn't even matter too much...



force a handler to run immediately.
- meta: flush_handlers

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

# predefined vars of target
ansible -m setup localhost
```

#### Notes

-  Requires Ansible version >= 2

- it seems eaiser to not to manage /etc/apt/sources.list

- rather than use register varaibles to flag the need for handlers such service restart, can touch/write a file, and read again at the end. this avoids the case of notified handlers not being called, due to some other mistake in the provision.

- ansible needs either passwordless sudo or root for apt-get etc. the issue with passwordless sudo on ordinary account is that processes under that account can theoretically sudo without password. so better to use dedicated privileged ansible account or root account.

- packages like npm, rust etc should *never* be installed with root privileges - due to large surface area of dependent packages.

- can use apt package python-minimal to get /usr/bin/python binary instead of /usr/bin/python2.7

- How to use `command {{item}}` and with_items together with chdir https://stackoverflow.com/questions/24851575/ansible-how-to-pass-multiple-commands

- provisioning local machine should run -c local, rather than exposing a ssh service

- there is no actual mechanical difference between a node and a play


#### Resources

http://codeheaven.io/15-things-you-should-know-about-ansible/

https://www.stavros.io/posts/example-provisioning-and-deployment-ansible/

https://raymii.org/s/tutorials/Ansible_-_Only-do-something-if-another-action-changed.html

http://stackoverflow.com/questions/30192490/include-tasks-from-another-role-in-ansible-playbook

https://github.com/phred/5minbootstrap/blob/master/bootstrap.yml

http://www.mechanicalfish.net/start-learning-ansible-with-one-line-and-no-files/

http://docs.ansible.com/ansible/playbooks_best_practices.html






#### Ansible CM

Ansible plays for use with dev, systemd-nspawn containers, kvm, cloud instances, vbox etc.


#### Examples

```
# nodes
ansible-playbook plays/nodes/apu.yml            --tags bind,dhcp,iptables
ansible-playbook plays/nodes/dell5520.yml       -i localhost, -c local
ansible-playbook plays/nodes/localnet2.yml      -i localhost, -c local

# playsn
ansible-playbook plays/admin/timezone.yml       -i localhost, -c local
ansible-playbook plays/admin/timezone.yml       -i localhost, -c local --extra-vars "timezone=Australia/Hobart"
ansible-playbook plays/admin/timezone.yml       -i devel07,  --extra-vars "timezone=Asia/Ho_Chi_Minh"

ansible-playbook plays/personal/dotfiles.yml    -i localhost, -c local
ansible-playbook plays/personal/scripts.yml     -i localhost, -c local
ansible-playbook plays/admin/devenv-lite.yml    -i localhost, -c local
ansible-playbook plays/admin/stretch-ftp-au.yml -i $host,
ansible-playbook plays/admin/openvpn.yml        -i $host,
ansible-playbook plays/admin/postgres.yml       -i $host,
ansible-playbook plays/nodes/postfix.yml        -i $host,

ansible-playbook plays/admin/deploy-war.yml     -i geoserver.localnet, --extra-vars "warpath=~/imos/may-18-geoserver/geoserver-1.0.0-imos.war warname=geoserver.war"

# setting and overriding vars
ansible-playbook plays/admin/user.yml         -i $host,   --extra-vars "username=parity"
ansible-playbook plays/personal/dotfiles.yml  -i localhost, -c local --extra-vars "path=/root user=root"
ansible-playbook plays/personal/dotfiles.yml  -i $host,   --extra-vars "path=/home/parity user=parity"
ansible-playbook plays/personal/dotfiles.yml  -i $host,   --extra-vars "path=/root user=root"
ansible-playbook plays/personal/dotfiles.yml  -i 10.3.0.10, --extra-vars "path=/root user=root ansible_python_interpreter=/run/current-system/sw/bin/python"

# nixos temporary examples,
ansible-playbook plays/personal/dotfiles.yml  -i nixos02, --extra-vars "ansible_python_interpreter=/root/.nix-profile/bin/python"
ansible-playbook plays/personal/pathogen.yml  -i nixos02, --extra-vars "ansible_python_interpreter=/root/.nix-profile/bin/python"
ansible-playbook plays/personal/dotfiles.yml  -i nixos02, --extra-vars "path=/root user=root ansible_python_interpreter=/root/.nix-profile/bin/python"
ansible-playbook plays/personal/pathogen.yml  -i nixos02, --extra-vars "path=/root user=root"


# bootstrap
apt-get install python-minimal
export host=n.n.n.n
ansible-playbook plays/admin/hostname.yml       -i $host, --extra-vars "hostname=$host"
ansible-playbook plays/personal/bootstrap.yml   -i $host,
ansible-playbook plays/personal/user-root.yml   -i $host,
ansible-playbook plays/personal/user-me.yml     -i $host,

# or bootstrap specific,
ansible-playbook plays/admin/hostname.yml       -i $host, --extra-vars "hostname=$host"
ansible-playbook plays/admin/timezone.yml       -i $host, --extra-vars "timezone=Asia/Ho_Chi_Minh"
ansible-playbook plays/admin/locale.yml         -i $host, --extra-vars "locale=en_AU.UTF-8"
ansible-playbook plays/admin/sshd.yml           -i $host,
ansible-playbook plays/admin/fail2ban-sshd.yml  -i $host,
ansible-playbook plays/admin/devenv-lite.yml    -i $host,
ansible-playbook plays/personal/user-root.yml   -i $host,
ansible-playbook plays/personal/user-me.yml     -i $host,



# flags
ansible --list-hosts all
ansible -i inventory/imos --list-hosts all
ansible-playbook nodes/dell-home.yml --list-tags
ansible-playbook nodes/aodn/aatams.yml -v
```


#### Useful flags
```

--list-tags         # list tagged roles
--list-tasks        # list tasks that will be run
--check             # report what would have been done only
-s                  # force use of sudo for all plays even if not marked as such
--private-key ~/.ssh/id_rsa
--ask-sudo-pass
-k ask pass         # useful before have keys deployed. needs apt-get install sshpass locally
-u specify username
-v verbose
-c local            # no ssh, spawn local shell

# Use ping module
ansible all -i nc2, -c local -m ping

# predefined vars of target
ansible -m setup localhost
```

#### Notes


- advantage over docker - composible, reusable. and we squash unneeded layers.
    https://alex.dzyoba.com/blog/packer-for-docker/

- think about only doing service restarts - when have init or systemd. not for docker like containers  ... eg. when

- is it possible to use -c local - directly on a chroot?

- role paths
  - https://stackoverflow.com/questions/30787273/variable-that-has-the-path-to-the-current-ansible-playbook-that-is-executing
  - https://stackoverflow.com/questions/22201306/ansible-galaxy-roles-install-in-to-a-specific-directory


- force_handlers, http://docs.ansible.com/ansible/latest/user_guide/playbooks_error_handling.html

- Include roles in tasks, ver 2.2  http://docs.ansible.com/ansible/latest/modules/include_role_module.html

- for complicated sequences of actions, deploying a template/script and running it as a command server side, may be simpler

- to keep code composible, and generalizable in different contexts, code must be in a role, rather than a play.  implications :-
    - must factor stuff out of the play - especially node-specific stuff like pre_tasks user creation
    - it's ok to have node-specific roles. no need to to use a play, just becacuse plays allow constraints on node inventory

- use the following to force a handler to run immediately.
    - meta: flush_handlers

- it seems eaiser to not to manage /etc/apt/sources.list. similar to disk partitioning

- rather than use register varaibles to flag handlers that need to be calle for service restarts, can touch/write a file, and read again at the end of the role. communicating restart information is then persisted across ansible-playbook invocations - and avoids handlers not being called, due to other errors in the playbook/provision.

- ansible needs either passwordless sudo or root for apt-get etc. the issue with passwordless sudo on ordinary account is that processes under that account can theoretically sudo without password. so better to use dedicated privileged ansible account or else just use root.

- packages like npm, rust, bundler, python etc should *never* be installed using globally/ or using root privileges - due to large surface area of install code and dependent packages.

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





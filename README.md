
### Prepare
```
ansible-galaxy install yaegashi.blockinfile -p ./roles/common




# or
sudo ansible-galaxy install yaegashi.blockinfile

ansible-galaxy install https://github.com/William-Yeh/ansible-oracle-java


Using root to provision is pretty convenient
- sshd and rsync must be installed, and copy authorized_key into /roo/.ssh 
  and edit /etc/ssh/sshd_config to permit root login

ansible-playbook roles/common/wily.yml  -i laptop, -v -u root




```

### Useful flags
```
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

https://github.com/phred/5minbootstrap/blob/master/bootstrap.yml

http://www.mechanicalfish.net/start-learning-ansible-with-one-line-and-no-files/

http://docs.ansible.com/ansible/playbooks_best_practices.html



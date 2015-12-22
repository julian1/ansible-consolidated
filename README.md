
### Examples

```
ansible-playbook imos.yml -i ./inventory/dev -l geonetwork2 -v -u root

ansible-playbook nodes/geonetwork.yml -i ./inventory/dev -v -u root

ansible-playbook nodes/aatams.yml -i ./inventory/dev -v -u root

ansible-playbook nodes/julian-test-instance.yml -i ./inventory/dev -v -u debian --private-key ~/.ssh/julian3.pem

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

http://stackoverflow.com/questions/30192490/include-tasks-from-another-role-in-ansible-playbook



https://github.com/phred/5minbootstrap/blob/master/bootstrap.yml

http://www.mechanicalfish.net/start-learning-ansible-with-one-line-and-no-files/

http://docs.ansible.com/ansible/playbooks_best_practices.html



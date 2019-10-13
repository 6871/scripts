Install docker and optionally docker-compose on an Ubuntu target machine.

Example use:

```shell script
git clone https://github.com/6871/scripts.git
cd scripts

host_ip_or_name=""
ssh_user=""

ansible-playbook \
  --inventory ${host_ip_or_name}, \
  --user ${ssh_user} \
  --ask-become-pass \
  --extra-vars docker_compose_version=1.24.1 \
  --extra-vars apt_upgrade=safe \
  ansible/ubuntu/docker_install/install.yml
```

```--ask-become-pass``` is only required if sudo password must be entered.

```--extra-vars "docker_compose_version=1.24.1"``` is optional but required to
install docker-compose.

```--extra-vars apt_upgrade=safe``` is optional, it performs a safe package
upgrade.

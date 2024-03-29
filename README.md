- [ansible](./ansible)
  - [ubuntu](./ansible/ubuntu)
    - [docker_install](./ansible/ubuntu/docker_install)
      - [README.md](./ansible/ubuntu/docker_install/README.md)
      - [install.yml](./ansible/ubuntu/docker_install/install.yml)
      - [roles](./ansible/ubuntu/docker_install/roles)
        - [check_is_ubuntu](./ansible/ubuntu/docker_install/roles/check_is_ubuntu)
          - [tasks](./ansible/ubuntu/docker_install/roles/check_is_ubuntu/tasks)
            - [main.yml](./ansible/ubuntu/docker_install/roles/check_is_ubuntu/tasks/main.yml)
        - [install_docker](./ansible/ubuntu/docker_install/roles/install_docker)
          - [defaults](./ansible/ubuntu/docker_install/roles/install_docker/defaults)
            - [main.yml](./ansible/ubuntu/docker_install/roles/install_docker/defaults/main.yml)
          - [tasks](./ansible/ubuntu/docker_install/roles/install_docker/tasks)
            - [main.yml](./ansible/ubuntu/docker_install/roles/install_docker/tasks/main.yml)
        - [install_docker_compose](./ansible/ubuntu/docker_install/roles/install_docker_compose)
          - [tasks](./ansible/ubuntu/docker_install/roles/install_docker_compose/tasks)
            - [main.yml](./ansible/ubuntu/docker_install/roles/install_docker_compose/tasks/main.yml)
        - [post_docker_install](./ansible/ubuntu/docker_install/roles/post_docker_install)
          - [defaults](./ansible/ubuntu/docker_install/roles/post_docker_install/defaults)
            - [main.yml](./ansible/ubuntu/docker_install/roles/post_docker_install/defaults/main.yml)
          - [tasks](./ansible/ubuntu/docker_install/roles/post_docker_install/tasks)
            - [main.yml](./ansible/ubuntu/docker_install/roles/post_docker_install/tasks/main.yml)
        - [remove_legacy](./ansible/ubuntu/docker_install/roles/remove_legacy)
          - [tasks](./ansible/ubuntu/docker_install/roles/remove_legacy/tasks)
            - [main.yml](./ansible/ubuntu/docker_install/roles/remove_legacy/tasks/main.yml)
    - [gitlab](./ansible/ubuntu/gitlab)
      - [install.yml](./ansible/ubuntu/gitlab/install.yml)
      - [roles](./ansible/ubuntu/gitlab/roles)
        - [install](./ansible/ubuntu/gitlab/roles/install)
          - [tasks](./ansible/ubuntu/gitlab/roles/install/tasks)
            - [main.yml](./ansible/ubuntu/gitlab/roles/install/tasks/main.yml)
    - [host_setup](./ansible/ubuntu/host_setup)
      - [install_all.yml](./ansible/ubuntu/host_setup/install_all.yml)
      - [install_sudo_no_pass.yml](./ansible/ubuntu/host_setup/install_sudo_no_pass.yml)
      - [roles](./ansible/ubuntu/host_setup/roles)
        - [hostname_to_etc_hosts](./ansible/ubuntu/host_setup/roles/hostname_to_etc_hosts)
          - [README.md](./ansible/ubuntu/host_setup/roles/hostname_to_etc_hosts/README.md)
          - [tasks](./ansible/ubuntu/host_setup/roles/hostname_to_etc_hosts/tasks)
            - [main.yml](./ansible/ubuntu/host_setup/roles/hostname_to_etc_hosts/tasks/main.yml)
        - [user_sudo_no_pass](./ansible/ubuntu/host_setup/roles/user_sudo_no_pass)
          - [README.md](./ansible/ubuntu/host_setup/roles/user_sudo_no_pass/README.md)
          - [tasks](./ansible/ubuntu/host_setup/roles/user_sudo_no_pass/tasks)
            - [main.yml](./ansible/ubuntu/host_setup/roles/user_sudo_no_pass/tasks/main.yml)
          - [vars](./ansible/ubuntu/host_setup/roles/user_sudo_no_pass/vars)
            - [main.yml](./ansible/ubuntu/host_setup/roles/user_sudo_no_pass/vars/main.yml)
- [bash](./bash)
  - [ip_utils.sh](./bash/ip_utils.sh)
  - [java_utils.sh](./bash/java_utils.sh)
  - [md_utils.sh](./bash/md_utils.sh)
  - [terraform_utils.sh](./bash/terraform_utils.sh)
  - [time_utils.sh](./bash/time_utils.sh)
- [macOS](./macOS)
  - [bash](./macOS/bash)
    - [disk_utils.sh](./macOS/bash/disk_utils.sh)
    - [file_utils.sh](./macOS/bash/file_utils.sh)
- [python](./python)
  - [md_toc.py](./python/md_toc.py)

<sub>Regenerate with: ```. <(curl -Ls https://raw.githubusercontent.com/6871/scripts/master/bash/md_utils.sh) && print_md_index``` or ```./bash/md_utils.sh .```</sub>

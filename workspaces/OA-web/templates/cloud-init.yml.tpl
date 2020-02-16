#cloud-config

users:
- name: oa-web
  uid: 2000
  groups: docker

write_files:
- path: /home/oa-web/docker-compose.yml
  permissions: 0755
  owner: oa-web
  content: |
    version: '3'
    services:
      oa-web:
        container_name: oa-web
        image: "gcr.io/${gcr_project}/${gcr_image}:${gcr_tag}"
        expose:
          - 90
        environment:
          - "VIRTUAL_HOST=orderofaxis.org"
      nginx:
        container_name: nginx-proxy
        image: jwilder/nginx-proxy
        ports:
          - "80:80"
        volumes:
          - /var/run/docker.sock:/tmp/docker.sock:ro

- path: /etc/systemd/system/oa-compose.service
  permissions: 0645
  owner: root
  content: |
    [Unit]
    Description=Runs docker-compose in oa-web user home directory.
    Requires=docker.service network-online.target
    After=docker.service network-online.target

    [Service]
    User=oa-web
    Environment="HOME=/home/oa-web"
    WorkingDirectory=/home/oa-web
    ExecStartPre=/usr/bin/docker-credential-gcr configure-docker
    ExecStart=/usr/bin/docker run \
      --rm \
      -v "/var/run/docker.sock:/var/run/docker.sock:ro" \
      -v "/home/oa-web/:/home/oa-web/" \
      -w="/home/oa-web/" \
      docker/compose:1.24.0 up
    ExecStop=/usr/bin/docker stop oa-compose
    Restart=on-failure
    RestartSec=10
    [Install]
    WantedBy=multi-user.target

runcmd:
- iptables -A INPUT -p tcp -j ACCEPT
- systemctl daemon-reload
#- systemctl enable --now --no-block oa-web.service

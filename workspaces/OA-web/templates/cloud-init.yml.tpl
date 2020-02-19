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
    version: '2'
    services:
      oa-web:
        container_name: oa-web
        image: "gcr.io/${gcr_project}/${gcr_image}:${gcr_tag}"
        expose:
          - 90
        environment:
          - "VIRTUAL_HOST=${subdomain}orderofaxis.org"
          - "VIRTUAL_PORT=90"
          - "LETSENCRYPT_HOST=${subdomain}orderofaxis.org"
          - "LETSENCRYPT_EMAIL=orderofaxis@gmail.com"

      nginx-proxy:
        container_name: nginx-proxy
        image: jwilder/nginx-proxy
        ports:
          - "80:80"
          - "443:443"
        environment:
          - "VIRTUAL_HOST=${subdomain}orderofaxis.org"
          - "LETSENCRYPT_HOST=${subdomain}orderofaxis.org"
        volumes:
          - /var/run/docker.sock:/tmp/docker.sock:ro
          - certs:/etc/nginx/certs:ro
          - vhost:/etc/nginx/vhost.d
          - html:/usr/share/nginx/html
          - dhparam:/etc/nginx/dhparam
          - conf:/etc/nginx/conf.d

      letsencrypt-nginx-proxy:
        container_name: letsencrypt
        image: jrcs/letsencrypt-nginx-proxy-companion
        volumes_from:
          - nginx-proxy
        environment:
          - "DEFAULT_EMAIL=orderofaxis@gmail.com"
        volumes:
          - certs:/etc/nginx/certs:rw
          - /var/run/docker.sock:/var/run/docker.sock:ro

    volumes:
      conf:
      vhost:
      html:
      dhparam:
      certs:


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
    ExecStartPre=/usr/bin/docker pull gcr.io/${gcr_project}/${gcr_image}:${gcr_tag}
    ExecStart=/usr/bin/docker run \
      --rm \
      -v "/var/run/docker.sock:/var/run/docker.sock:ro" \
      -v "/home/oa-web/:/home/oa-web/" \
      -v "/home/oa-web/.docker:/root/.docker:ro" \
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
- systemctl enable --now --no-block oa-compose.service

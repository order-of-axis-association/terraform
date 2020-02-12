#cloud-config

users:
- name: aquabot
  uid: 2000
  groups: docker

write_files:
- path: /etc/systemd/system/aquabot.service
  permissions: 0644
  owner: root
  content: |
    [Unit]
    Description=Runs the order-of-axis-association/AquaBot docker image on GCR.
    Requires=docker.service network-online.target
    After=docker.service network-online.target

    [Service]
    Environment="HOME=/home/aquabot"
    ExecStartPre=/usr/bin/docker-credential-gcr configure-docker # use this if your are using Googles docker repository
    ExecStartPre=/usr/bin/docker pull gcr.io/${gcr_project}/${gcr_image}:${gcr_tag}
    ExecStart=/usr/bin/docker run \
        --rm \
        -u 2000 \
        -p 25100:25100 \
        --name=aquabot \
        gcr.io/${gcr_project}/${gcr_image}:${gcr_tag}
    ExecStop=/usr/bin/docker stop aquabot
    Restart=on-failure
    RestartSec=10
    [Install]
    WantedBy=multi-user.target

runcmd:
- iptables -A INPUT -p tcp -j ACCEPT
- systemctl daemon-reload
- systemctl start aquabot
#- systemctl enable --now --no-block oa-web.service

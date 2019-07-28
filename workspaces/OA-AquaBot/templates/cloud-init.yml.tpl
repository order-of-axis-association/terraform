#cloud-config

users:
- name: oa-aquabot
  uid: 2000

write_files:
- path: /etc/systemd/system/oa-aquabot.service
  permissions: 0644
  owner: root
  content: |
    [Unit]
    Description=Runs the order-of-axis-association/AquaBot docker image on GCR.
    Requires=docker.service network-online.target
    After=docker.service network-online.target

    [Service]
    Environment="HOME=/home/oa-aquabot"
    ExecStartPre=/usr/bin/docker-credential-gcr configure-docker # use this if your are using Google's docker repository
    ExecStart=/usr/bin/docker run \
 		--rm \
		--name=oa-aquabot \
		gcr.io/${gcr_project}/${gcr_image}:${gcr_tag}
    ExecStop=/usr/bin/docker stop oa-aquabot
    Restart=on-failure
    RestartSec=10
    [Install]
    WantedBy=multi-user.target

runcmd:
- iptables -A INPUT -p tcp -j ACCEPT
- systemctl daemon-reload
#- systemctl enable --now --no-block oa-web.service

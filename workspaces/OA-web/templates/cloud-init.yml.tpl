#cloud-config

users:
- name: oa-web
  uid: 2000

write_files:
- path: /etc/systemd/system/oa-web.service
  permissions: 0644
  owner: root
  content: |
    [Unit]
    Description=Runs the order-of-axis-association/docker-OA-web docker image on GCR.
    Requires=docker.service network-online.target
    After=docker.service network-online.target

    [Service]
    Environment="HOME=/home/oa-web"
    ExecStartPre=/usr/bin/docker-credential-gcr configure-docker # use this if your are using Google's docker repository
    #ExecStartPre=/usr/bin/docker pull gcr.io/${gcr_project}/${gcr_image}:${gcr_tag}
    ExecStart=/usr/bin/docker run \
		--network=host \
 		--rm \
		--name=oa-web \
		gcr.io/${gcr_project}/${gcr_image}:${gcr_tag}
    ExecStop=/usr/bin/docker stop oa-web
    Restart=on-failure
    RestartSec=10
    [Install]
    WantedBy=multi-user.target

runcmd:
- iptables -A INPUT -p tcp -j ACCEPT
- systemctl daemon-reload
#- systemctl enable --now --no-block oa-web.service

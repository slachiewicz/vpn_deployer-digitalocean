VPN Deployer
===

Deploys a Docker-based VPN server one-click solution on DigitalOcean. The package this deploys is <a href="https://github.com/jmarhee/dockvpn">jmarhee/dockvpn</a>.

**Visit my Deployer instance: <a href="https://vpn-deploy.arcology.io/">https://vpn-deploy.arcology.io/<a/>**

**You can read more about this project <a href="https://medium.com/@jmarhee/automating-deploying-a-personal-vpn-server-on-digitalocean-f585aca396cf#.oo5tuvo9b">on Medium</a>.**

This will allow you to provide a one-click solution to DigitalOcean users for a VPN service, through your application. Running a private instance of this can be for your own use (it will work when run in development mode locally!), or to provide more availability for helping others run their own VPN servers and begin being more mindful about how they browse the Internet. 

Running your own instance of the deployer
---

*Note* This repo _only_ runs the deployer. **To run the VPN server itself, check out <a href="https://github.com/jmarhee/dockvpn">jmarhee/dockvpn</a>**. 

Copy `environment.rb.example` to `environment.rb`, populate with your DigitalOcean Application key and secret, and build:

```
docker build -t vpn_deployer-app .
```

and run:

```
docker run -d --restart=always -p 80:4567 --name vpn-deployer-app vpn_deployer-app
```

Running standalone VPN
---

If you are planning to run the VPN service by itself, and don't particularly want to run an instance of the deployer itself (totally not necessary!), it will run on _any_ Docker host running a recent Debian (7+)/Ubuntu (14.04+) release, and you can jump ahead to running this script (if your provider supports cloud-init/provisioning scripts, or just run manually):

```bash
#!/bin/bash

function install_pkgs() {
    apt-get update && \
    apt-get install -y git-core curl
}

function install_compose() {
    curl -L "https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose
}

function deploy_vpn() {
    git clone https://github.com/jmarhee/dockvpn.git && \
    cd dockvpn && \
    docker-compose up -d
}

install_pkgs && install_compose && deploy_vpn
```

Details on this project can be found in the <a href="https://github.com/jmarhee/dockvpn">jmarhee/dockvpn</a> project. 
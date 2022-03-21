#!/bin/sh

install_nodejs_ubuntu() {
    # install nodejs && yarn
    curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    sudo apt-get install -y nodejs
    sudo apt-get install -y npm
    npm install -g yarn
    apt-get -y install curl git
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
    apt-get update && apt-get install -y yarn
    yarn --version 
}

download_grafana_render () {
    # download grafana-render
    cd ~
    git clone https://github.com/grafana/grafana-image-renderer.git
    cp -r grafana-image-renderer /usr/local/bin/
    chmod +x /usr/local/bin/grafana-image-renderer
    cd /usr/local/bin/grafana-image-renderer
    yarn install --pure-lockfile 
    yarn run build

}

create_service () {
    # create service
    echo  "[Unit]"  > /etc/systemd/system/grafana-render.service
    echo "Description=Grafana Render" >> /etc/systemd/system/grafana-render.service
    echo "[Service]" >> /etc/systemd/system/grafana-render.service
    echo "WorkingDirectory=/usr/local/bin/grafana-image-renderer" >> /etc/systemd/system/grafana-render.service
    echo "ExecStart=node build/app.js server --port=8081 --port=0.0.0.0" >> /etc/systemd/system/grafana-render.service
    echo "Restart=always" >> /etc/systemd/system/grafana-render.service
    echo "[Install]" >> /etc/systemd/system/grafana-render.service
    echo "WantedBy=multi-user.target" >> /etc/systemd/system/grafana-render.service
    
    # create service start
    systemctl daemon-reload
    systemctl enable grafana-render.service
    systemctl start grafana-render.service
    systemctl status grafana-render.service

}


main () {
    
   read -p "Do you want to install nodejs and yarn? (y/n) " -n 1 -r
   if [[ $REPLY =~ ^[Yy]$ ]]
   then
       install_nodejs_ubuntu
   fi

    read -p "Do you want to download grafana-render? (y/n) " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        download_grafana_render
    fi

    read -p "Do you want to create service? (y/n) " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        create_service
    fi

}

main




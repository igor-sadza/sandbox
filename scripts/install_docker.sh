#!/bin/bash

function_prerequisites() {
  apt-get -o Dpkg::Use-Pty=0 update -qq
  apt-get -o Dpkg::Use-Pty=0 install -qq  \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common
};

function_main() {
  #Add Docker’s official GPG key
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg

  #Use the following command to set up the repository
  echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  apt-get -o Dpkg::Use-Pty=0 update -qq
  apt-get -o Dpkg::Use-Pty=0 install -qq \ 
    docker-ce \ 
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin
};

function_main

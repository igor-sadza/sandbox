#!/bin/bash

function_blacklist_nouveau() {
  echo -e "blacklist nouveau\noptions nouveau modeset=0" >> /etc/modprobe.d/blacklist.conf
  sudo update-initramfs -u
};

function_requirements() {
  sudo dpkg --add-architecture i386
  sudo apt-get update -qq;
  sudo apt-get install -y -qq \
   linux-headers-$(uname -r) \
   make \
   gcc-multilib \
   dkms 
};

function_get_latest_driver() {

  local v_baseUrl="https://download.nvidia.com/XFree86/Linux-x86_64"

  local v_latestDriver="$(
    curl --silent \
      "${v_baseUrl}/latest.txt" | sed 's/.* //g'
  )";

  curl --silent "${v_baseUrl}/${v_latestDriver}" -o nvidia.run

  chmod 0775 nvidia.run

};

function_execute_runfile() {
  ./nvidia.run                \
    --ui=none --no-questions  \
    --accept-license          \
    --disable-nouveau         \
    --no-cc-version-check     \
    --install-libglvnd  2>&1
};

## Install NVIDIA Driver
modinfo nvidia && which nvidia-smi
has_gpu_driver=$?

if [ $has_gpu_driver -ne 0 ]; then

function_blacklist_nouveau
function_requirements
function_get_latest_driver
function_execute_runfile

else
  echo "Nvidia drivers installed on machine already. Skipping install of drivers."
fi

systemctl is-active nvidia-persistenced || systemctl enable nvidia-persistenced


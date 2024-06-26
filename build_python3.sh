#!/bin/bash
# Build Python3.12 for Ubuntu 18.04 - JetPack 4.X
# Copyright (c) JetsonHacks 2023

# Set the version
version="3.12"

help_message="Usage: $0 [-h|--help]
Options:
  -h, --help     Show this help message."

# Parse command-line options
OPTIONS=$(getopt -o h --longoptions help -- "$@")
eval set -- "$OPTIONS"

while true; do
    case "$1" in
        -h|--help)
            echo "$help_message"
            exit 0
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Incorrect options provided"
            echo "$help_message"
            exit 1
            ;;
    esac
done

echo "Building Python version: $version"

sudo apt update
sudo apt-get build-dep python3
sudo apt install -y pkg-config
# Install main dependencies
sudo apt install -y build-essential gdb lcov pkg-config \
      libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
      libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
      lzma lzma-dev tk-dev uuid-dev zlib1g-dev  
      
sudo apt install -y libncursesw5-dev libmpdec-dev

# Install Python 3 extra dependencies
sudo apt install -y quilt sharutils libdb-dev blt-dev libbluetooth-dev \
      time xvfb python3-sphinx texinfo
sudo apt install -y devscripts git git-buildpackage
mkdir -p ~/Python-Builds
cd ~/Python-Builds
mkdir Python$version-Dist
cd Python$version-Dist
git clone https://github.com/syslogine/python$version.git
cd python$version

git checkout ubuntu/bionic
gbp buildpackage --git-ignore-branch -uc -us
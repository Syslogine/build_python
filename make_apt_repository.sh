#!/bin/bash
# Build a local apt repository for Python 3.12 .debs
# Add to the apt sources
# Copyright (c) JetsonHacks 2023

# Set the version
version="3.12"

# Check to see if this version has been built
dir_path="$HOME/Python-Builds/Python$version-Dist"

if [ -d "$dir_path" ]
then
    deb_files=$(find "$dir_path" -name "*.deb" | wc -l)

    if [ "$deb_files" != "0" ]
    then
        echo "Creating local apt repository from $dir_path .deb files."
    else
        echo "Python version $version has not been built yet."
        exit 1
    fi
else
    echo "Python version $version has not been created yet."
    exit 1
fi

# Copy the .deb files over to /opt/debs/python<version>
# For example, /opt/debs/python3.12
destination="/opt/debs/python$version"
sudo mkdir -p $destination
cd $dir_path
sudo cp *.deb "$destination"

# Create the package file
cd /opt/debs/python$version
sudo sh -c 'dpkg-scanpackages ./ /dev/null | gzip -9c > Packages.gz'

# Create a list file for apt
echo 'deb [trusted=yes] file://'$PWD ' ./' | sudo tee /etc/apt/sources.list.d/python$version-local.list
sudo apt update
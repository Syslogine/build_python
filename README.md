# build_python
Create .deb files for Python 3.12 for Jetson Linux - Ubuntu 18.04 - bionic

The JetsonHacksNano repository holds the Python 3.12 source code forked from the Deadsnakes account: https://github.com/deadsnakes Deadsnakes creates a repository to hold both new and old versions of Python for Ubuntu.

When Ubuntu 18.04 (Bionic) reached EOL, the repository removed Python builds for that version. Because the Jetsons using JetPack 4.X still use Ubuntu 18.04, we keep the Python 3.12 source code in the JetsonHacksNano account, which includes the Deadsnakes debian packaging scripts.

```bash
git clone https://github.com/Syslogine/build_python.git
```

```bash
cd build_python
```

To build the .deb files for Python 3.12:
```bash
bash ./build_python3.sh
```

The resulting .deb files will be in ~/Python-Builds/Python3.12-Dist.

You can add the .deb files individually. There is a convenience script to build an apt repository on a local file:
```bash
bash ./make_apt_repository.sh
```
This script will copy the .deb files from Python 3.12 to /opt/debs/python3.12. It also places a .list file in /etc/apt/sources.list.d
After the script is complete, you can use apt as normal. For example:
```bash
sudo apt install python3.12-full
```
Will install the full Python 3.12 environment, with the exception of things like full dev and debug files. For example, it does not install python3.12-dev

## Notes
### June 2023, Initial Release
- Tested on Jetson Nano 4GB, Python 3.12
- After building, make a backup of the .deb files at least. You will need to modify the apt_repository file to install the .deb files if you want to do a standalone install on another machine.


### Changes:

1. Removed references to Python 3.9, 3.10, and 3.11 as the README is now specific to Python 3.12.
2. Updated the description to mention that the repository holds the Python 3.12 source code.
3. Removed the `--version` flag from the `build_python3.sh` and `make_apt_repository.sh` scripts since they are now specific to Python 3.12.
4. Updated the output directory to `~/Python-Builds/Python3.12-Dist`.
5. Updated the apt repository destination to `/opt/debs/python3.12`.
6. Updated the `apt install` example to use `python3.12-full`.

This README.md now focuses solely on building and creating a local apt repository for Python 3.12 on Jetson Linux (Ubuntu 18.04).
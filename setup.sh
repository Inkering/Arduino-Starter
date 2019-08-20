#!/bin/bash

# somewhat experimental setup script
# ... here be dragons

# make conda available to the script
source ~/anaconda3/etc/profile.d/conda.sh

# setup python environment, checking if env
# already exists
if conda info --envs | grep --quiet "arduino "; then
		echo "found arduino conda environment"
		conda activate arduino
else
		echo "arduino environment not found, creating..."
		conda create -n arduino python=2.7 pip
		echo "environment created, activating"
		conda activate arduino
fi

# check if env is correct version
if python -c 'import sys; print(".".join(map(str, sys.version_info[:3])))' | grep --quiet "2.7"; then
		echo "confirmed correct python version"
else
		echo "not correct python version, check manually :)"
fi

# installing pip packages
pip install -r requirements.txt

# setup udev
while true; do
    read -p "Do you wish to change udev rules to work with pio?" yn
    case $yn in
        [Yy]* )
						echo "ok doing it"
						# not really sure if needed
						#wget https://raw.githubusercontent.com/platformio/platformio-core/develop/scripts/99-platformio-udev.rules
						#sudo cp 99-platformio-udev.rules /etc/udev/rules.d/99-platformio-udev.rules
						#sudo service udev restart
						break
						;;
        [Nn]* )
						echo "ok, skipping"
						break
						;;
        * ) echo "Please answer yes or no.";;
    esac
done

# init platformio core
platformio init

# setup uno
while true; do
    read -p "Do you wish to setup pio for use with arduino?" yn
    case $yn in
        [Yy]* )
						echo "ok doing it"
						platformio init --board uno
						break
						;;
        [Nn]* )
						echo "ok, skipping"
						break
						;;
        * ) echo "Please answer yes or no.";;
    esac
done

# setup emacs editor
while true; do
    read -p "Do you wish to setup pio for use with emacs?" yn
    case $yn in
        [Yy]* )
						echo "ok doing it"
						platformio init --board uno --ide emacs
						sh ./ccls-reg.sh
						break
						;;
        [Nn]* )
						echo "ok, skipping"
						break
						;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "all done!, look at the run script to handle run operations"

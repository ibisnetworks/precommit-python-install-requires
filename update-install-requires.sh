#!/bin/bash

set -e

# Silently move on if there is no setup.py
if [[ ! -f setup.py ]]
then
    exit 0 
fi 


# Move on if the setup.py in this project is not using the install_requires hook

grep -q 'install_requires=INSTALL_REQUIRES' setup.py
output=$?

if [ $output = 1 ]
then 
    echo "This project does not use the install_requires hook...moving on"
    exit 0 
fi

grep -q 'setup_install_requirements.py' setup.py
output=$?

if [ $output = 1 ]
then 
    echo "This project does not use the install_requires hook...moving on"
    exit 0
fi

# If we get here, it's safe to proceed
python setup.py requirements 
output=$?

if [ $output = 0]
then 
    exit 0
else
    exit 1
fi






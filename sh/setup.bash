#!/bin/bash

# set -ex
# source /home/mrokk/.bashrc

ENV_NAME=$(yq r environment.yml name.) # legge da yaml "dolly"

install_pip_reqs(){
    if [ -f ./requirements.txt ]; then
        pip install -r requirements.txt || echo "pip install failed"
    else
        printf "no requirements.txt found"
    fi
}

check_cuda(){
    echo Cuda is available: $(python3 -c "import torch; print(torch.cuda.is_available())")
}

# check if a conda env with the env name exists already and if not create one
if conda env list | grep -q "^$ENV_NAME\s"; then
    echo "conda env already exists"
    mamba activate $ENV_NAME
    install_pip_reqs
    check_cuda

else
    echo "creating conda env"
    mamba env create -f environment.yml || conda env create -f environment.yml || (printf "conda env create failed" && printf "exiting")

    install_pip_reqs
    check_cuda
    
fi

echo ready!!
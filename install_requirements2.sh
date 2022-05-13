#!/bin/bash
export HAS_CONDA=0
hash conda >/dev/null 2>&1 && export HAS_CONDA=1
if [ ${HAS_CONDA} = '0' ]; then
    echo pls install conda first.
    exit 1
fi
sudo apt-get install libaio1 libaio-dev


wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
sudo apt-get update
sudo apt-get -y install cuda=11.3.0-1



conda create -n gptj python=3.7
conda activate gptj
conda install conda-forge::mamba
mamba install pytorch torchvision torchaudio cudatoolkit=11.3 -c pytorch -y


pip install datasets && \
pip install transformers


pip install jax jaxlib

pip install triton

#need to drastically lower requirements
export DS_BUILD_SPARSE_ATTN=0
export DS_BUILD_OPS=1
git clone https://github.com/microsoft/DeepSpeed -b v0.6.4
cd DeepSpeed
pip install . --global-option="build_ext" --global-option="-j`nproc`"
cd ..
ds_report

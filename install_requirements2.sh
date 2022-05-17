#!/bin/bash
sudo apt update
sudo apt-get install libaio1 libaio-dev gnupg -y
sudo curl https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc | gpg --dearmor > conda.gpg
sudo install -o root -g root -m 644 conda.gpg /usr/share/keyrings/conda-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/conda-archive-keyring.gpg] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" > conda.list
sudo mv conda.list /etc/apt/sources.list.d/conda.list
sudo apt update
sudo apt install conda
source /opt/conda/etc/profile.d/conda.sh
echo 'source /opt/conda/etc/profile.d/conda.sh' >> ~/.bashrc

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
sudo apt-get update
sudo apt-get -y install cuda=11.3.0-1
echo 'export PATH="$PATH:/usr/local/cuda-11.3/bin"' >> ~/.bashrc
sudo apt-get -y install cmake



conda create -n gptj python=3.7 -y
conda activate gptj
conda install conda-forge::mamba -y
mamba install -c nvidia/label/cuda-11.3.0 cuda
mamba install pytorch=1.10.2 torchvision torchaudio cudatoolkit=11.3 -c pytorch -y


pip install datasets && \
pip install transformers


pip install jax jaxlib

pip install triton

#need to drastically lower requirements
export DS_BUILD_OPS=1
git clone https://github.com/microsoft/DeepSpeed -b v0.5.8
cd DeepSpeed
# gcc <= 10
pip install .
cd ..
ds_report

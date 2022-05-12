#!/bin/bash
export HAS_CONDA=0
hash conda >/dev/null 2>&1 && export HAS_CONDA=1
if [ ${HAS_CONDA} = '0' ]; then
    echo pls install conda first.
    exit 1
fi
#general requirements
conda install pytorch torchvision torchaudio cudatoolkit=11.1 -c pytorch -c nvidia -y
pip install datasets
#needed to convert model
git clone https://github.com/kingoflolz/mesh-transformer-jax.git
pip install -r mesh-transformer-jax/requirements.txt
pip install mesh-transformer-jax/ jax==0.2.12 jaxlib -f https://storage.googleapis.com/jax-releases/jax_releases.html
#correct version is required for understandable output
pip install git+https://github.com/finetuneanon/transformers@gpt-j
#need to drastically lower requirements
git clone https://github.com/microsoft/DeepSpeed -b v0.4.4
cd DeepSpeed
if [ ${CUDA} = '1' ]; then
    DS_BUILD_OPS=1 pip install .
else
    pip install .
fi
ds_report

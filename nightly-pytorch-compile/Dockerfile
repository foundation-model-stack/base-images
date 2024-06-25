FROM condaforge/miniforge3

ENV HOME=/homedir \
    AIM_UI_TELEMETRY_ENABLED=0 \
    MOFED_VER=23.04-1.1.3.0 \
    OS_VER=ubuntu20.04 \
    PLATFORM=x86_64 \
    DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC

# tools
RUN apt-get -y -o Acquire::Max-FutureTime=86400 update && \
    apt-get install -y gnupg vim nmon gcc software-properties-common make git git-lfs wget curl unzip libaio-dev && \
    apt-key del 7fa2af80 && \
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.1-1_all.deb && \
    dpkg -i cuda-keyring_1.1-1_all.deb && \
    apt-get -y -o Acquire::Max-FutureTime=86400 update && \
    apt-get install -y cuda-compiler-12-1 cuda-nsight-12-1 cuda-libraries-12-1 cuda-libraries-dev-12-1 libnvidia-compute-525 && \
    apt-get -y clean

RUN wget --quiet http://content.mellanox.com/ofed/MLNX_OFED-${MOFED_VER}/MLNX_OFED_LINUX-${MOFED_VER}-${OS_VER}-${PLATFORM}.tgz && \
    tar -xvzf MLNX_OFED_LINUX-23.04-1.1.3.0-ubuntu20.04-x86_64.tgz && \
    ./MLNX_OFED_LINUX-23.04-1.1.3.0-ubuntu20.04-x86_64/mlnxofedinstall --user-space-only --without-fw-update --all --force && \
    rm -rf MLNX_OFED_LINUX-23.04-1.1.3.0-ubuntu20.04-x86_64 MLNX_OFED_LINUX-23.04-1.1.3.0-ubuntu20.04-x86_64.tgz

RUN chgrp -R 0 /opt/conda && \
    chmod -R a+w /opt/conda && \
    chmod -R g=u /opt/conda

# This is important for certain pytorch deps
RUN pip install --upgrade setuptools && \
    chmod -R g+w /opt/conda && \
    chmod -R g=u /opt/conda

# Pytorch nightly install
RUN pip install --pre --upgrade torch torchvision --extra-index-url https://download.pytorch.org/whl/nightly/cu121 --no-cache-dir && \
    chmod -R g+w /opt/conda && \
    chmod -R g=u /opt/conda

# permanent dependencies, we put them after torch so we don't end up installing torch twice and wasting a lot of space
# (each install of torch is about 2GB!!!)
# decision has been made to have them as the latest version always, as this is a nightly image after all
RUN pip install \
    transformers \
    sentencepiece \
    aim \
    datasets \
    accelerate \
    optimum \
    tqdm \
    protobuf \
    colorama \
    scikit-learn \
    ninja \
    --no-cache-dir && \
    chmod -R g+w /opt/conda && \
    chmod -R g=u /opt/conda

# xformers install (built from source)
# deactivated until we get better workers as there isn't enough ram, cpu, or disk space to compile them anymore
# ENV CUDA_HOME=/usr/local/cuda
# ENV MAX_JOBS=2
# ENV TORCH_CUDA_ARCH_LIST="7.0;7.5;8.0;8.6"
# RUN apt-get install -y libcublas-11-8 libcublas-dev-11-8 libcusparse-11-8 libcusparse-dev-11-8 libcusolver-11-8 libcusolver-dev-11-8 libcurand-11-8 libcurand-dev-11-8 && \
#     pip install -v -U git+https://github.com/facebookresearch/xformers.git@main#egg=xformers --no-cache-dir && \
#     chmod -R g+w /opt/conda && \
#     chmod -R g=u /opt/conda && \
#     apt-get remove -y libcublas-11-8 libcublas-dev-11-8 libcusparse-11-8 libcusparse-dev-11-8 libcusolver-11-8 libcusolver-dev-11-8 libcurand-11-8 libcurand-dev-11-8 && \
#     apt-get -y clean

# setup .aim_profile (needed to get aim running)
RUN mkdir -p ${HOME} && \
    touch ~/.aim_profile && \
    chmod g+w ~/.aim_profile

WORKDIR /workspace

RUN chgrp -R 0 . && \
    chmod -R g=u .

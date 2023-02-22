# switch to miniconda3 base as pytorch base uses python3.7
FROM continuumio/miniconda3:latest

ENV HOME=/homedir \
    AIM_UI_TELEMETRY_ENABLED=0

# tools
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb && \
    dpkg -i cuda-keyring_1.0-1_all.deb && \
    apt-get -y -o Acquire::Max-FutureTime=86400 update && \
    apt-get install -y vim nmon gcc cuda && \
    apt-get -y clean

# permanent dependencies, put on top to avoid re-build
RUN pip install \
    transformers==4.26.1 \
    aim==3.16.0 \
    datasets \
    tqdm \
    protobuf \
    colorama \
    scikit-learn \
    --no-cache-dir

# setup .aim_profile (needed to get aim running)
RUN mkdir -p ${HOME} && \
    touch ~/.aim_profile && \
    chmod g+w ~/.aim_profile

WORKDIR /workspace

RUN chgrp -R 0 . && \
    chmod -R g=u .

RUN chgrp -R 0 /opt/conda && \
    chmod -R g=u /opt/conda

# put this at the end as we change this often, we add dummy steps to force rebuild the following lines when needed
# RUN pwd && pwd && pwd && pwd
# RUN pip install --pre torch==1.14.0.dev20221013+cu117 torchvision --extra-index-url https://download.pytorch.org/whl/nightly/cu117
RUN pip install --pre torch torchvision --extra-index-url https://download.pytorch.org/whl/nightly/cu117 --no-cache-dir

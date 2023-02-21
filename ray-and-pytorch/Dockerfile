ARG RAY_VERSION
FROM rayproject/ray:${RAY_VERSION}

RUN sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub

ENV HOME=/homedir \
    AIM_UI_TELEMETRY_ENABLED=0

# dev and debug
RUN sudo apt-get -y update && \
    sudo apt-get install -y build-essential vim libc6-dbg gdb valgrind && \
    sudo rm -rf /var/lib/apt/lists/* && \
    sudo apt-get -y clean

#install torch
ARG TORCH_VERSION
RUN pip install torch=="${TORCH_VERSION}" -f https://download.pytorch.org/whl/torch_stable.html \
    aim==3.16.0 \
    --no-cache-dir

# setup .aim_profile (needed to get aim running)
RUN mkdir -p ${HOME} && \
    touch ~/.aim_profile && \
    chmod g+w ~/.aim_profile

RUN mkdir /home/ray/workspace
WORKDIR /home/ray/workspace

ENV PYTHONPATH "/home/ray/workspace:${PYTHONPATH}"
ENV RAY_USAGE_STATS_ENABLED=0

# change group permissions for running in OCP
RUN sudo chgrp -R 0 /home/ray/workspace
RUN sudo chmod -R g+w /home/ray/workspace


ARG RAY_VERSION
FROM rayproject/ray:${RAY_VERSION}

RUN sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub

# dev and debug
RUN sudo apt-get update && sudo apt-get install -y \
    build-essential vim libc6-dbg gdb valgrind \
    && sudo rm -rf /var/lib/apt/lists/* \
    && sudo apt-get clean

#install torch
ARG TORCH_VERSION
RUN pip install --no-cache-dir torch=="${TORCH_VERSION}" -f https://download.pytorch.org/whl/torch_stable.html

RUN mkdir /home/ray/workspace
WORKDIR /home/ray/workspace

ENV PYTHONPATH "/home/ray/workspace:${PYTHONPATH}"
ENV RAY_USAGE_STATS_ENABLED=0

# change group permissions for running in OCP
RUN sudo chgrp -R 0 /home/ray/workspace
RUN sudo chmod -R g+w /home/ray/workspace

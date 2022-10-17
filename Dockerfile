ARG BASE_IMAGE=nvcr.io/nvidia/pytorch:22.05-py3
FROM $BASE_IMAGE

WORKDIR /workspace

# Install Python and pip, and build-essentials if some requirements need to be compiled
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    python3-dev \
    python3-distutils \
    python3-venv \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/* \
    && cd /tmp \
    && curl -O https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py

#Get the FSDP workshop GitHub repo
RUN git clone https://github.com/pytorch/workshops.git && \
    pip install -r ./workshops/FSDP_Workshop/requirements.txt && \
    pip uninstall torch torchaudio torchvision -y && \
    pip3 install --pre torch torchvision --extra-index-url https://download.pytorch.org/whl/nightly/cu113

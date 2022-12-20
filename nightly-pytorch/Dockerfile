# switch to miniconda3 base as pytorch base uses python3.7
FROM continuumio/miniconda3:latest

# permanent dependencies, put on top to avoid re-build
RUN pip install transformers==4.21.2 datasets tqdm protobuf colorama scikit-learn && \
	pip uninstall torch torchaudio torchvision -y

WORKDIR /workspace

RUN chgrp -R 0 . && \
    chmod -R g=u .

RUN chgrp -R 0 /opt/conda && \
    chmod -R g=u /opt/conda

# tools
RUN apt-get update && apt-get install -y \
	vim \
	nmon

# put this at the end as we change this often, we add dummy steps to force rebuild the following lines when needed
# RUN pwd && pwd && pwd && pwd
# RUN pip install --pre torch==1.14.0.dev20221013+cu117 torchvision --extra-index-url https://download.pytorch.org/whl/nightly/cu117
RUN pip install --pre torch torchvision --extra-index-url https://download.pytorch.org/whl/nightly/cu117

FROM nvidia/cuda:10.0-cudnn7-runtime-ubuntu18.04
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
RUN apt-get update

RUN apt-get install -y \
    wget \
    make \
    python3 \
    python3-pip \
    libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh \
    && conda init bash \
    && . /root/.bashrc \
    && conda create --name speech_enhance python=3.6 \
    && conda activate speech_enhance\
    && conda install pytorch=1.7.1 torchvision torchaudio=0.7 cudatoolkit=10.2 -c pytorch \
    && conda install tensorboard joblib matplotlib \
    && pip install Cython \
    && pip install librosa pesq pypesq pystoi tqdm toml colorful mir_eval torch_complex \
    && conda list --explicit spec-list.txt

# SHELL ["conda", "run", "-n", "speech_enhance", "/bin/bash", "-c"]

RUN mkdir fullsubnet/
COPY . fullsubnet/
WORKDIR fullsubnet

ENTRYPOINT ["conda", "run", "-n", "speech_enhance", "python", "-m", "speech_enhance.tools.inference"]
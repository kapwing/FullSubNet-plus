FROM ubuntu:18.04
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
RUN apt-get update

RUN apt-get install -y \
    wget \
    make \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh \
    && conda init bash \
    && . /root/.bashrc \
    && conda create --name speech_enhance python=3.6 \
    && conda activate \
    && conda install pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch \
    && conda install tensorboard joblib matplotlib \
    && pip install Cython \
    && pip install librosa pesq pypesq pystoi tqdm toml colorful mir_eval torch_complex


# # Create conda environment
# RUN conda create --name speech_enhance python=3.6 && \
#     conda init bash && \
#     conda activate speech_enhance

# # Install conda packages
# # Check python=3.8, cudatoolkit=10.2, pytorch=1.7.1, torchaudio=0.7
# RUN conda install pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch
# RUN conda install tensorboard joblib matplotlib

# # Install pip packages
# # Check librosa=0.8
# RUN pip install Cython
# RUN pip install librosa pesq pypesq pystoi tqdm toml colorful mir_eval torch_complex

RUN mkdir fullsubnet/
COPY . fullsubnet/
WORKDIR fullsubnet
# RUN make clean
# RUN make
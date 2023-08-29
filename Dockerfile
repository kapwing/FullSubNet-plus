FROM ubuntu:20.04
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
    && conda create --name speech_enhance python=3.9 \
    && conda update -n base -c defaults conda \
    && conda activate speech_enhance \
    && conda install pytorch=2.0.0 torchvision=0.15.0 torchaudio=2.0.0 cudatoolkit=10.2 -c pytorch \
    && conda install tensorboard=2.11.0 matplotlib=3.7.1 \
    && conda install joblib=1.2.0 -c conda-forge \
    && pip install Cython==0.29.34 librosa==0.10.0.post2 pesq==0.0.4 pypesq==1.2.4 pystoi==0.3.3 tqdm==4.64.0 toml==0.10.2 colorful==0.5.5 mir_eval==0.7 torch_complex==0.4.3

RUN mkdir fullsubnet/
COPY . fullsubnet/
WORKDIR fullsubnet

# ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "speech_enhance", "python", "-m", "speech_enhance.tools.inference"]

# conda run --no-capture-output -n speech_enhance python -m speech_enhance.tools.inference -C "./config/inference.toml" -M "./best_model.tar" -I "./input_files" -O "./output_files"
FROM nvidia/cuda:12.2.2-cudnn8-devel-ubuntu22.04
MAINTAINER Hiroshi Kajino <hiroshi.kajino.1989@gmail.com>

RUN apt-get -qq update
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Asia/Tokyo apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get -qq update
RUN apt-get install -y gcc g++ git
RUN apt-get install -y aria2 curl wget bzip2
RUN apt-get install -y make unzip zlib1g-dev
RUN apt-get install -y sqlite3 openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev
RUN apt-get install -y tk-dev
RUN apt-get install -y emacs
RUN apt-get install -y liblzma-dev
RUN apt-get install -y liblapack-dev libblas-dev gfortran
RUN apt-get install -y libffi-dev
RUN apt-get update \
    && apt-get install -y locales \
    && locale-gen ja_JP.UTF-8 \
    && echo "export LANG=ja_JP.UTF-8" >> ~/.bashrc
RUN apt-get install -y language-pack-ja
RUN update-locale LANG=ja_JP.UTF-8
RUN apt-get install -y magit

# change user
ENV USER_NAME root
ENV HOME /home/$USER_NAME
#RUN groupadd -g 1001 -r $USER_NAME && useradd -r -g $USER_NAME -u 1001 $USER_NAME
#USER $USER_NAME
WORKDIR $HOME

RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.profile
RUN echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile
RUN pyenv install 3.11.0
RUN pyenv global 3.11.0
RUN pyenv init - >> ~/.profile
RUN pyenv init - >> ~/.bash_profile

# setup default python libraries
RUN pip install pip --upgrade
RUN pip install virtualenv flake8
RUN pip install smart_open s3fs s3path awswrangler
RUN pip install torch dgl dgllife torch_geometric lightning tensorboard
RUN pip install deepchem[torch] rdkit selfies

ENV LANG=ja_JP.UTF-8
ENV OMP_NUM_THREADS 1
ENV CACHE_DIR $HOME/.cache

WORKDIR $HOME

RUN git clone https://github.com/kanojikajino/luigine.git
WORKDIR $HOME/luigine
RUN git pull origin master
RUN pip install -e .
WORKDIR $HOME

RUN git clone https://github.com/kanojikajino/emacs-config.git
WORKDIR $HOME/.emacs.d
RUN cp $HOME/emacs-config/init.el $HOME/.emacs.d/init.el

WORKDIR $HOME
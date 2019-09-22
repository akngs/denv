FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive

# locale
RUN apt-get update && apt-get install -y locales && locale-gen en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8

# common packages
RUN apt-get update && apt-get install -y \
      build-essential \
      curl \
      editorconfig \
      git  \
      iputils-ping \
      libbz2-dev \
      libffi-dev \
      liblzma-dev \
      libncurses5-dev \
      libncursesw5-dev \
      libreadline-dev \
      libssl-dev \
      libsqlite3-dev \
      llvm \
      net-tools \
      netcat-openbsd \
      python-openssl \
      silversearcher-ag \
      socat \
      software-properties-common \
      tk-dev \
      tmux \
      tmuxinator \
      vim \
      wget \
      xz-utils \
      yadm \
      zlib1g-dev

# python
## pyenv
RUN curl https://pyenv.run | bash && \
      /root/.pyenv/bin/pyenv install 3.7.4 && \
      /root/.pyenv/bin/pyenv global 3.7.4

## poetry
RUN curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python && rm /root/.profile

## global packages
RUN /root/.pyenv/shims/pip install --upgrade pip && /root/.pyenv/shims/pip install \
      autopep8 \
      flake8 \
      isort \
      pylint \
      yapf

# nodejs
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
      apt-get install -y nodejs

# global nodejs packages
RUN npm install -g \
      eslint \
      stylelint \
      typescript \
      @vue/cli

# fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
      ~/.fzf/install --all && \
      ln -s ~/.fzf/bin/fzf /usr/local/bin/fzf

# vim-plug
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Done
COPY .profile /root/.profile
COPY .bash_profile /root/.bash_profile
COPY .bashrc /root/.bashrc
COPY .tmux.conf /root/.tmux.conf
COPY yadm.git.config /root/.config/yadm.git.config

WORKDIR /root

CMD ["bash"]


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
      wget \
      xz-utils \
      zlib1g-dev

# pyenv
RUN curl https://pyenv.run | bash && \
      /root/.pyenv/bin/pyenv install 3.7.4 && \
      /root/.pyenv/bin/pyenv global 3.7.4

# poetry
RUN curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python && rm /root/.profile

# nodejs
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
      apt-get install -y nodejs

# global nodejs packages
RUN npm install -g \
      typescript \
      @vue/cli

# neovim
RUN add-apt-repository ppa:neovim-ppa/stable && apt-get update && apt-get install -y neovim && \
      curl -fLo /root/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
COPY init.vim /root/.config/nvim/init.vim
RUN vim '+PlugInstall --sync' +qall &> /dev/null

# Done
COPY .bashrc /root/.bashrc
WORKDIR /root

CMD ["bash"]


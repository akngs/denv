FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive

# locale
RUN apt-get update && apt-get install -y locales && locale-gen en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8

# common packages
RUN apt-get update && apt-get install -y \
      autotools-dev \
      automake \
      bison \
      build-essential \
      curl \
      editorconfig \
      flex \
      gettext \
      git  \
      iputils-ping \
      libbz2-dev \
      libevent-dev \
      libffi-dev \
      liblzma-dev \
      libncurses5-dev \
      libncursesw5-dev \
      libreadline-dev \
      libssl-dev \
      libsqlite3-dev \
      llvm \
      mosh \
      net-tools \
      netcat-openbsd \
      pkg-config \
      python-openssl \
      rsync \
      ruby \
      ruby-dev \
      silversearcher-ag \
      socat \
      software-properties-common \
      tidy \
      tk-dev \
      tmux \
      tmuxinator \
      tree \
      vim \
      wget \
      xz-utils \
      yadm \
      zlib1g-dev \
      zsh

# tmux
RUN git clone https://github.com/tmux/tmux.git && \
      cd tmux && \
      sh autogen.sh && \
      ./configure && \
      make && \
      make install && \
      cp /usr/local/bin/tmux /usr/bin/tmux && \
      cd .. && \
      rm -rf tmux
 
# zsh
RUN chsh -s $(which zsh) && \
      rm ~/.bashrc && \
      sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# nodejs
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
      apt-get install -y nodejs

# python
## pyenv
RUN curl https://pyenv.run | bash && \
      /root/.pyenv/bin/pyenv install 3.7.4 && \
      /root/.pyenv/bin/pyenv install 3.8.0 && \
      /root/.pyenv/bin/pyenv global 3.7.4

# ruby
RUN gem install \
      bundler \
      jekyll

# fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
      ~/.fzf/install --all && \
      ln -s ~/.fzf/bin/fzf /usr/local/bin/fzf

# vim-plug
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# npm global packages
RUN npm install -g \
      eslint \
      stylelint \
      typescript \
      @vue/cli

# poetry
RUN curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python && \
      rm /root/.profile && \
      mkdir -p ~/.oh-my-zsh/plugins/poetry && \
      ~/.poetry/bin/poetry completions zsh > ~/.oh-my-zsh/plugins/poetry/_poetry

# python global packages
RUN /root/.pyenv/shims/pip install --upgrade pip && /root/.pyenv/shims/pip install \
      autopep8 \
      cookiecutter \
      flake8 \
      isort \
      pylint \
      yapf

# Done
COPY entrypoint.sh /root/.config/entrypoint.sh
COPY yadm.git.config /root/.config/yadm.git.config

WORKDIR /root

CMD ["/root/.config/entrypoint.sh"]


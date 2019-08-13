FROM debian:stretch

## Standard stuff ##
RUN apt-get update && apt-get install -yq \
        bash-completion \
        build-essential \
        less \
        sudo \
        vim \
        curl \
        ruby-full

## Create and run as gitpod user ###
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod \
    # passwordless sudo for users in the 'sudo' group
    && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers
ENV HOME=/home/gitpod
WORKDIR $HOME
USER gitpod

## Install brew
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
ENV PATH=/home/linuxbrew/.linuxbrew/bin:$PATH

## Install branchout
RUN brew install branchout/branchout/branchout hub shellcheck

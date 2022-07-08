FROM ubuntu:latest
WORKDIR /root

# Install basic tools
RUN apt update \
    && apt install -y curl \
    && apt install -y wget \
    && apt install -y git \
    && apt install -y vim

# Install fish shell
RUN apt-get install -y software-properties-common \
    && apt-add-repository ppa:fish-shell/release-3 \
    && apt update \
    && apt install -y fish \
    && chsh -s /usr/bin/fish \
    && curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | sed '$iset -g NONINTERACTIVE' | fish \
    && fish -c 'omf install pure'
SHELL ["fish", "-c"]

# Install latest Golang
RUN wget -c https://go.dev/dl/go1.18.3.linux-amd64.tar.gz -O - | tar -xz \
    && mv go /usr/local/go/
ENV PATH="/usr/local/go/bin:${PATH}"

# # Install Miniconda
ENV PATH="/usr/local/miniconda/bin:${PATH}"
RUN wget -c --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O conda_installer \
    && bash conda_installer -b -p /usr/local/miniconda \
    && conda init fish \
    && rm -f conda_installer \

# Configure git
RUN git config --global color.ui auto \
    && git config --global core.quotepath off \
    && git config --global core.editor "vim" \
    && git config --global alias.lg1-specific "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'" \
    && git config --global alias.lg2-specific "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'" \
    && git config --global alias.lg3-specific "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'" \
    && git config --global alias.lg "lg1" \
    && git config --global alias.lg1 "lg1-specific --all" \
    && git config --global alias.lg2 "lg2-specific --all" \
    && git config --global alias.lg3 "lg3-specific --all"

# Configure fish
RUN alias -s g="git" \
    && alias -s ga="git add" \
    && alias -s gm="git commit" \
    && alias -s gs="git status" \
    && alias -s gl="git lg" \
    && alias -s gck="git checkout"

# sleep forever
ENTRYPOINT ["sleep", "infinity"]
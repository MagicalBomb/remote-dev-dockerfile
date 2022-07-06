FROM ubuntu:latest
WORKDIR /root

# Install basic tools
RUN apt update \
    && apt install curl \


# Install fish shell
RUN apt-get install -y software-properties-common \
    && apt-add-repository ppa:fish-shell/release-3 \
    && apt update \
    && apt install -y fish \
    && chsh -s /usr/bin/fish \
    && curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish \
    && omf install batman \
    && omf theme batman


# Install latest Golang
# RUN wget -c https://go.dev/dl/go1.18.3.linux-amd64.tar.gz -O - | tar -xz \
#     && mv ./go/ /usr/local/go/ \
#     && echo "export PATH=$PATH:/usr/local/go/bin"

# # Install Miniconda
# ENV PATH="/root/miniconda3/bin:${PATH}"
# RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
#     && mkdir ./.conda \
#     && bash Miniconda3-latest-Linux-x86_64.sh -b \
#     && rm -f Miniconda3-latest-Linux-x86_64.sh 

# sleep forever
ENTRYPOINT ["sleep", "infinity"]
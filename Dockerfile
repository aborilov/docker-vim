from jare/alpine-vim
# Used to configure YouCompleteMe
ENV UHOME=/home/developer
ENV GOROOT="/usr/lib/go"
ENV GOBIN="$GOROOT/bin"
ENV GOPATH="$UHOME/go"
ENV PATH="$PATH:$GOBIN:$GOPATH/bin"
RUN cd /root/ \
&& apk add --update git \
bash \
rsync \
ctags \
python \
python-dev \
cmake \
build-base \
go \
&& git clone https://github.com/aborilov/dotfiles.git \
&& cd dotfiles && ./bootstrap.sh -f && cd ~ \
&& git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim \
&& vim +PluginInstall +qall \
&& .vim/bundle/YouCompleteMe/install.py --gocode-completer
ENV TERM=xterm-256color
WORKDIR $UHOME/workspace

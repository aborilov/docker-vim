# from alpine
from jare/alpine-vim
ENV GOPATH="/go"
ENV PATH="$PATH:$GOPATH/bin"
RUN apk add --update git \
bash \
rsync \
vim \
tmux \
zsh \
python \
python-dev \
build-base \
ctags \
cmake \
go
RUN bash -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

RUN git clone https://github.com/aborilov/dotfiles.git \
&& cd /dotfiles && ./bootstrap.sh -f && rm -rf /dotfiles

RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim \
&& vim +PluginInstall +qall

RUN mkdir /go \
&& vim +'silent :GoInstallBinaries' +qall

RUN ~/.vim/bundle/YouCompleteMe/install.py --gocode-completer

ENTRYPOINT ["zsh", "-c", "GOPATH=/go tmux"]

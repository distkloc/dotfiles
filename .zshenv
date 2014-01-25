
# homebrew
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# go
go_path=$HOME/go
function() {
    if [[ ! -d "${go_path}" ]]; then
        mkdir ${go_path}
    fi
}

export GOPATH=${go_path}
export PATH=$PATH:$GOPATH/bin


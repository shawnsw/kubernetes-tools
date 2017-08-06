# Kubernetes Tools

Kubernetes tools is a set of programs that help you operate your Kubernetes clusters more efficiently.


## Installation

### Install using brew
```sh
brew tap shawnxlw/tap
brew install kubernetes-tools
ktools init
```

### Manual installation
```sh
cd ~
git clone https://github.com/shawnxlw/kubernetes-tools
# add the follow to your .bash_profile or .zshrc
PATH=$HOME/kubernetes-tools/bin:$PATH
# set up tab completion
ktools init
```

##### BASH completion
Add the following into your `.bash_profile`:  
```sh
source $HOME/kubernetes-tools/completion/__completion`
```

##### ZSH completion
Add the following into your `.zshrc`:  
```sh
autoload -U compaudit compinit bashcompinit
compaudit && compinit && bashcompinit
source $HOME/kubernetes-tools/completion/__completion`
```

## Usage

#### Available tools
```
===Operation===
kcontext: Get current context, set new context
kns: Get all namespaces, search namespace by keyword
kpod: Get pod in all namespaces or specified namespace
kelb: Get ELBs of all namespaces or specified namespace
kall: Get all resources of specified namespace
kds: Descirbe pod or specified resource in specified namespace

===Debug===
klogs: Get logs of a selected container, or all containers in all pods of a namespace
ksick: Get all unhealthy pods in all namespaces
kexec: Get a shell of a selected container of specified namespace
kssh: tmux into all nodes, or ssh into a specified node

===Maintenance===
kbak: Backup and restore namespace/cluster
```

#### How to use
To list all the available tools, run ```ktools```

For usage of each tool, run ```[tool_name] -h```

## License
This software is licensed under the [MIT License](https://opensource.org/licenses/MIT).

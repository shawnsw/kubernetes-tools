# Kubernetes Tools

Kubernetes tools is a set of programs that help you operate your Kubernetes clusters more efficiently.


## Installation

#### Mac
```sh
brew tap shawnxlw/tap
brew install kubernetes-tools
```

#### Linux
```sh
cd ~
git clone https://github.com/shawnxlw/kubernetes-tools
# add the follow to your .bash_profile or .zshrc or whatever
PATH=$HOME/kubernetes-tools/bin:$PATH
```

#### BASH completion
Add the following into your `.bash_profile`:  
```sh
# load tab completion script for kubernetes tools
source /usr/local/Cellar/kubernetes-tools/<version>/completion/__completion`
```

#### ZSH completion
Add the following into your `.zshrc`:  
```sh
# load tab completion script for kubernetes tools
autoload -U compaudit compinit bashcompinit
compaudit && compinit && bashcompinit
source /usr/local/Cellar/kubernetes-tools/<version>/completion/__completion`
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

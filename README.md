# Kubernetes Tools

Kubernetes Tools is a set of scripts that simplifies daily Kubernetes operations.

Context and Namespace can be overridden per-terminal instance via KCTX and KNS environment variables:

```sh
export KCTX=my_context
export KNS=my_namespace
kns
...
```

## Requirements

* `jq`
* `kubectl`
* `helm` (OPTIONAL only if you need Helm)
* `docker` (OPTIONAL needed to run `k9s` as a container)

### Supported shell types

* `bash`
* `zsh`

if you're using non-supported shell you can still use the tools but you'd have to manually setup your shell as well as no autocompletion integration

## Available tools

**k**/**h** shotrhand wrapper around `kubectl`/`helm` that makes use of `KCTX` and `KNS` env vars

**kctx**: List contexts, switch context

![](gif/kctx.gif)

**kns**: List namespaces, select default namespace

![](gif/kns.gif)

**kpod**: List pods in current namespace, describe pod

![](gif/kpod.gif)

**kexec**: Get a shell of a selected container

![](gif/kexec.gif)

**kcopy**: Copy common cli tools to selected container

![](gif/kcopy.gif)

#### How to use
To list all the available tools, run ```ktools```

For usage of each tool, run ```[tool_name] -h```

![](gif/ktools.gif)

## Installation

### Generic Installation
```sh
cd ~/some/dir
git clone https://github.com/shawnxlw/kubernetes-tools
cd kubernetes-tools
./setup.sh
```

#### setup.sh

* if you run `setup.sh` from within directory *other* than `kubernetes-tools` location, pass path to the `kubernetes-tools`

```sh
cd ~/some/dir
git clone https://github.com/shawnxlw/kubernetes-tools
./setup.sh kubernetes-tools
```
* **INSTALL_MODE** copy vs link: you can either copy shell-specific files into your home directory or merely link to your `kubernetes-tools` directory (default is `link`):

```sh
INSTALL_MODE=copy ./setup.sh 
```

* **SHELL_TYPE** - identify your shell type (default is `bash`)

```sh
SHELL_TYPE=zsh ./setup.sh 
```

* or override all at once:

```sh
cd ~/some/dir
git clone https://github.com/shawnxlw/kubernetes-tools
INSTALL_MODE=copy SHELL_TYPE=zsh ./setup.sh kubernetes-tools
```


##### BASH completion
Add the following into your `.bash_profile`:  
```sh
source $HOME/kubernetes-tools/completion/__completion
```

##### ZSH completion
Add the following into your `.zshrc`:  
```sh
autoload -U compaudit compinit bashcompinit
compaudit && compinit && bashcompinit
source $HOME/kubernetes-tools/completion/__completion
source <(kubectl completion zsh)
source <(helm completion zsh)
compdef k=kubectl
compdef h=helm
```

###### Powerlevel10k

Autoprompt for zsh's `powerlevel10k`:

```sh
  function prompt_ktools() {
    # source ${HOME}/.kube_helper
    [[ -z "${KCTX}" ]] && KCTX=$(kubectl config current-context)
    [[ -z "${KNS}" ]] && KNS="$(kubectl config view -o=jsonpath="{.contexts[?(@.name==\"${KCTX}\")].context.namespace}")"
    KNS=${KNS:-"default"}
    p10k segment -f 208 -t "${KCTX}/${KNS}"
  }

  function instant_prompt_ktools() {
    prompt_ktools
  }

  typeset -g POWERLEVEL9K_KTOOLS_SHOW_ON_COMMAND='k|h|kns|kctx|klogs|k9s|kcopy|kexec|kpod'

```

then add `ktools` to either `POWERLEVEL9K_(RIGHT|LEFT)_PROMPT_ELEMENTS`

## License
This software is licensed under the [MIT License](https://opensource.org/licenses/MIT).

## Release Note
v2.1.0 - 26/10/2018
- Added klogs
- Added fish-shell completions (PR by @nesl247)

v2.0.1 - 23/10/2018
- Updated kcp from binary copy to download
- Fixed pod name auto completion

v2.0.0 - 15/10/2018
- Changed to developer workflow
- Updated kctx, kns, kpod, kcopy, kctx
- Removed kbak, kds, klogs

v1.2.0 - 08/08/2018
- Updated kexec, kns, kpod, kctx, kds
- Added kcp

v1.0.0 - 07/08/2017
- Initial release

#!/bin/sh

# To override default values for setup use:
## 1. setup.sh /my/path for pointing to location of kubernetes-tools
## 2. env var INSTALL_MODE : (link|copy)
## 3. env var SHELL_TYPE : (bash|zsh)

INSTALL_MODE="link"

KTOOLS_DIR=${1:-$(pwd)}

KTOOLS_PATH=$(realpath ${KTOOLS_DIR})

case "${INSTALL_MODE}" in
    link)
        INSTALL_CMD='ln -sf'
        ;;
    copy)
        INSTALL_CMD='cp'
        ;;
esac

${INSTALL_CMD} ${KTOOLS_PATH}/dot.colors ${HOME}/.colors
${INSTALL_CMD} ${KTOOLS_PATH}/dot.kube_helper ${HOME}/.kube_helper

SHELL_TYPE=${SHELL_TYPE:-"bash"}
case "${SHELL_TYPE}" in
    bash|zsh)
        echo "Generating startup for ${SHELL_TYPE}"
        ;;
    *)
        echo "unknown SHELL_TYPE... bailing"
        exit 1
esac

SHELL_RC_FILE="${HOME}/.${SHELL_TYPE}rc"

if sed 's/#.*$//' ${SHELL_RC_FILE} | grep -qF "${KTOOLS_PATH}/bin" "${SHELL_RC_FILE}" 
then
    echo "${KTOOLS_PATH}/bin is already in your PATH in ${SHELL_RC_FILE}"
else
    echo "Added ${KTOOLS_PATH}/bin to your path:"
    echo "export PATH=\${PATH}:${KTOOLS_PATH}/bin" >> ${SHELL_RC_FILE}
fi

if [ "${SHELL_TYPE}" = "zsh" ]
then
cat >> ${SHELL_RC_FILE} << EOF
source <(kubectl completion zsh)
source <(helm completion zsh)
compdef k=kubectl
compdef h=helm
EOF
fi
export PATH=${PATH}:${KTOOLS_PATH}/bin
ktools --init
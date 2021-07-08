function __ktools_my_current_context
  if test -z "${KCTX}" 
  then
    kubectl config current-context
  else
    echo "${KCTX}"
  end
}

function __ktools_my_current_namespace
  if test -z "${KNS}" 
  then
    namespace="$(kubectl config view -o=jsonpath="{.contexts[?(@.name==\"$(current_context)\")].context.namespace}")"
  else
    namespace=${KNS}
  end
  if test -z "${namespace}" ; then
    echo "default"
  else
    echo "${namespace}"
  end
}

function __ktools_current_namespace
    set -l current_context (__ktools_my_current_context)
    set -l namespace (__ktools_my_current_namespace)

    if test -z "$namespace"
        echo default
    else
        echo $namespace
    end
end

function __ktools_pods
    set -l pods (kubectl get pods --context=(__ktools_my_current_context) -n (__ktools_current_namespace) --ignore-not-found | sed '1d' | awk '{print $1}')

    if set -q pods[1]
        printf "%s\tPod\n" $pods
    end
end

function __ktools_namespaces
    printf "%s\tNamespace\n" (kubectl get ns --context=(__ktools_my_current_context) | sed '1d'| awk '{print $1}')
end

function __ktools_contexts
    printf "%s\tContext\n" (kubectl config get-contexts | sed -e "s/\*//"| sed '1d'| awk '{print $1}')
end

function __ktools_nodes
    printf "%s\tNode\n" (kubectl get nodes --context=(__ktools_my_current_context) -o json | jq -r '.items[].status.addresses[].address' | paste - - - | cut -f 1)
end

complete -c klogs -f -a '(__ktools_pods)'
complete -c kcopy -f -a '(__ktools_pods)'
complete -c kexec -f -a '(__ktools_pods)'
complete -c kpod -f -a '(__ktools_pods)'
complete -c kns -f -a '(__ktools_namespaces)'
complete -c kctx -f -a '(__ktools_contexts)'

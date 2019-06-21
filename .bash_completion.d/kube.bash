# file: ~/.bash_completion.d/kube.bash

if has kubectl; then
    source <(kubectl completion bash)
fi

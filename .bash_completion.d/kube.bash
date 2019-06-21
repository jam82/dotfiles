# file: ~/.bash_completion.d/kube.bash

if hash kubectl 2>/dev/null; then
    source <(kubectl completion bash)
fi

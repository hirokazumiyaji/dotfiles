which direnv > /dev/null && eval "$(direnv hook bash)"

ASDF_ROOT="${HOME}/.asdf"
if [ ! -f ${ASDF_ROOT}/completions ]; then
  mkdir -p "${ASDF_ROOT}/completions"
fi

asdf completion zsh > "${ASDF_ROOT}/completions/_asdf"
fpath=(${ASDF_ROOT}/completions $fpath)
autoload -Uz compinit && compinit

plugins=("golang" "nodejs" "python" "flutter" "terraform" "java" "ruby" "rust")
for plugin in ${plugins}; do
  asdf plugin add ${plugin} > /dev/null 2>&1
done

export PATH="${ASDF_ROOT}/shims:$PATH"

if [ -f ${ASDF_ROOT}/plugins/java/set-java-home.zsh ]; then
  source ${ASDF_ROOT}/plugins/java/set-java-home.zsh
fi

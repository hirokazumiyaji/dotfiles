sudo apt update -y

sudo apt install -y direnv

sudo apt install -y golang ca-certificates

if ! command -v asdf &> /dev/null; then
  sudo apt install -y git bash
  go install github.com/asdf-vm/asdf/cmd/asdf@v0.18.0
fi

ASDF_ROOT="${HOME}/.asdf"
if [ ! -f ${ASDF_ROOT}/completions ]; then
  mkdir -p "${ASDF_ROOT}/completions"
fi

asdf completion bash > "${ASDF_ROOT}/completions/_asdf"
fpath=(${ASDF_ROOT}/completions $fpath)
autoload -Uz compinit && compinit

plugins=("golang" "nodejs" "python" "flutter" "terraform" "java" "ruby" "rust")
for plugin in ${plugins}; do
  asdf plugin add ${plugin} > /dev/null 2>&1
done

cp -p .bashrc ${HOME}/.bashrc
cp -p .gitconfig ${HOME}/.gitconfig
cp -p .gitignore ${HOME}/.gitignore
cp -p .tool-versions ${HOME}/.tool-versions

cd $HOME && asdf install
asdf reshim
npm install -g @anthropic-ai/claude-code

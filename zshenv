typeset -U path PATH

path=(
  "$HOME/.local/share/mise/shims"
  /opt/homebrew/bin
  /opt/homebrew/sbin
  "$HOME/src/google-cloud-sdk/bin"
  "$HOME/.pub-cache/bin"
  "$HOME/.local/bin"
  $path
)

export HOMEBREW_FORBIDDEN_FORMULAE="node python python3 pip npm pnpm yarn ruby"

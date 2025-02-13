# make Shift+q make shell cd to dir opened in ranger while quitting ranger
function ranger {
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    command ranger --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    rm -f -- "$tempfile" > /dev/null
}

CARGO_HOME=${CARGO_HOME:-$HOME/.cargo}
[ -d "$CARGO_HOME" ] && export PATH="$PATH:$CARGO_HOME/bin"

command -v zoxide > /dev/null && eval "$(zoxide init zsh --cmd cd)"

# make conda work
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
    . "/opt/miniconda3/etc/profile.d/conda.sh"
elif [ -d "/opt/miniconda3/bin" ]; then
    export PATH="/opt/miniconda3/bin:$PATH"
fi


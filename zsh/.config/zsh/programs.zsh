# make Shift+q make shell cd to dir opened in ranger while quitting ranger
function ranger {
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    command ranger --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    rm -f -- "$tempfile" > /dev/null
}


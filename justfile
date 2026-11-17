set positional-arguments

install target="all":
    #!/usr/bin/env bash
    set -euo pipefail

    target=$1
    bin_dir="$HOME/.local/bin"
    data_dir="${XDG_DATA_HOME:-$HOME/.local/share}/toolbox/blueprints"

    case "$target" in
        boot|worktree|build|all) ;;
        *) echo "Usage: just install [boot|worktree|build|all]" >&2; exit 2 ;;
    esac

    install -d "$bin_dir"

    if [[ "$target" == "boot" || "$target" == "all" ]]; then
        install -m 755 scripts/boot scripts/boot-iso scripts/boot-pxe "$bin_dir/"
    fi

    if [[ "$target" == "worktree" || "$target" == "all" ]]; then
        install -m 755 scripts/worktree "$bin_dir/wt"
    fi

    if [[ "$target" == "build" || "$target" == "all" ]]; then
        install -m 755 scripts/build "$bin_dir/build"
        install -d "$data_dir"
        cp -R blueprints/. "$data_dir/"
    fi

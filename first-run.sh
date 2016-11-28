#!/bin/sh

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT_PATH=$(readlink -f "$0")

# Absolute path this script is in, thus /home/user/bin
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

# Distro name
read -p "Distro: ubuntu/arch (default=ubuntu) " DISTRO
DISTRO=${DISTRO:-ubuntu}

# Distro directory
DISTRO_DIR=$SCRIPT_DIR/$DISTRO

# ---------------------------------------------------------------------

log_wait() {
  echo -ne "$1... (please wait)"\\r
  global_last_log_wait=$1
}

log_done() {
  echo -ne "$global_last_log_wait... OK!\033[K\n"
}

run_script() {
  log_wait $1
  bash $2 1> /dev/null
  log_done
}

run_dir() {
  for file in $2
  do
    if [[ -f $file ]]; then
        run_script "$1 ($file)" $2
    fi
  done
}

upgrade_dist() {
  update_pkgs
  run_script "updating distribution" $DISTRO_DIR/upgrade-distro.sh
}

update_pkgs() {
  run_script "updating packages" $DISTRO_DIR/update-packages.sh
}

install_essentials() {
  run_script "installing essential packages" $DISTRO_DIR/install-essentials.sh
}

add_repositories() {
  run_dir "adding repository" $DISTRO_DIR/repositories
}

install_pkgs() {
  run_dir "installing package" $DISTRO_DIR/install
}

run_config() {
  run_dir "running configuration" $DISTRO_DIR/configs
}

main() {
  upgrade_dist
  install_essentials
  add_repositories
  update_pkgs
  install_pkgs
  run_config
}
main

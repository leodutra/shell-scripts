#!/bin/sh

UNKNOWN_REPOSITORIES=(
  "i386"
  "java-oracle"
  "docker"
  "node-js"
  "atom-editor"
  "google-chrome"
  "partners"
)

KNOWN_REPOSITORIES=(
  "ruby" 
  "git" 
  "build-essential" 
  "tts-mscorefonts"
  "gimp"
)

APPS_TO_INSTALL=( ${KNOWN_REPOSITORIES[@]} ${UNKNOWN_REPOSITORIES[@]} )

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

log_wait() {
  echo -ne "$1... (please wait)"\\r
  global_last_log_wait=$1
}

log_done() {
  echo -ne "$global_last_log_wait... OK!\033[K\n"
}

add_repo() {
  log_wait "add repository $1"
  bash $SCRIPTPATH/repository-setup/$1.sh 1> /dev/null
  log_done
}

install() {
  log_wait "install $1"
  bash $SCRIPTPATH/install-scripts/$1.sh 1> /dev/null
  log_done
}

for i in "${UNKNOWN_REPOSITORIES[@]}"
do
	add_repo $i
done

log_wait "apt-get update"
apt-get update  -y -qq
log_done

log_wait "apt-get upgrade"
apt-get upgrade -y -f -qq
log_done

log_wait "apt-get install-f"
apt-get install -y -f -qq
log_done


for i in "${APPS_TO_INSTALL[@]}"
do
	install $i
done

log_wait "apt autoclean"
apt-get autoremove -y 1> /dev/null
log_done

log_wait "apt clean"
apt-get clean -y 1> /dev/null
log_done

#!/bin/sh

missing_repositories=(
  "ia32"
  "java-oracle"
  "docker"
  "node-js"
  "atom-editor"
  "google-chrome"
)

repositories=(
  "ruby" "git" "build-essential"
)

to_install=( ${repositories[@]} ${missing_repositories[@]} )

#MY_PATH="`dirname \"$0\"`"   

log_wait() {
  echo -ne "$1... (please wait)"\\r
  global_last_log_wait=$1
}

log_done() {
  echo -ne "$global_last_log_wait... OK!\033[K\n"
}

add_repo() {
  log_wait "add repository $1"
  bash ./repository-setup/$1.sh 1> /dev/null
  log_done
}

install() {
  log_wait "install $1"
  bash ./install-script/$1.sh 1> /dev/null
  log_done
}

for i in "${missing_repositories[@]}"
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


for i in "${to_install[@]}"
do
	install $i
done


log_wait "apt clean"
apt-get clean -y 1> /dev/null
log_done

log_wait "apt autoclean"
apt-get autoclean -y 1> /dev/null
log_done

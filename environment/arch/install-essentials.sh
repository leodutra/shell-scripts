#!/bin/sh
echo installing pacaur
mkdir pacaur
pacman -S binutils make gcc fakeroot expac yajl git --noconfirm
gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
curl -o pacaur/PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower
makepkg -i pacaur/PKGBUILD --noconfirm
curl -o pacaur/PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur
makepkg -i pacaur/PKGBUILD --noconfirm
rm -rf pacaur/

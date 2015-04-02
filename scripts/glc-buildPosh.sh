#!/bin/posh
#
# Note to self, remove this line and do chmod -x on both glc-build scripts
# glc-build -- glc build and install script
# Copyright (c) 2007-2008 Pyry Haulos
#

info()
{
	echo  "\033[32minfo\033[0m  : $1"
}

ask()
{
	echo  "        $1"
}

askprompt()
{
	echo "      \033[34m>\033[0m "
}

error()
{
	echo  "\033[31merror\033[0m : $1"
}

die()
{
	error "$1"
	exit 1
}

download()
{
	[ -f "$1.tar.gz" ] && rm -f "$1.tar.gz"
	wget -q "http://nullkey.ath.cx/$1/$1.tar.gz" || die "Can't fetch $1"
}

unpack()
{
	[ -d "$1" ] && rm -rdf "$1"
	tar -xzf "$1.tar.gz" || die "Can't unpack $1.tar.gz"
}

gitfetch()
{
	GIT="`which git 2> /dev/null`"

	if [ -d "$1" ]; then
		cd "$1"
		$GIT pull origin || die "Can't update $1"
		cd ..
	else
		$GIT clone "git://github.com/nullkey/$1.git" \
			|| die "Can't clone $1"
	fi
}


echo "Welcome to the glc install script!"

BUILD64=0
uname -m | grep X86_64 > /dev/null && BUILD64=1

echo "#include <stdio.h>
	int main(int argc, char arg[]){printf(\"test\");return 0;} " | \
	gcc -x c - -o /dev/null 2> /dev/null \
	|| die "Can't compile (Ubuntu users: sudo apt-get install build-essential)"
[ -e "/usr/include/X11/X.h" -a -e "/usr/include/X11/Xlib.h" ] \
	|| die "Missing X11 headers (Ubuntu users: sudo apt-get install libx11-dev)"
[ -e "/usr/include/GL/gl.h" -a -e "/usr/include/GL/glx.h" ] \
	|| die "Missing OpenGl headers (Ubuntu users: sudo apt-get install libgl1-mesa-dev)"
[ -e "/usr/include/alsa/asoundlib.h" ] \
	|| die "Missing ALSA headers (Ubuntu users: sudo apt-get install libasound2-dev)"
[ -e "/usr/include/png.h" ] \
	|| die "Missing libpng headers (Ubuntu users: sudo apt-get install libpng12-dev)"
[ -x "/usr/bin/cmake" ] \
	|| die "CMake not installed (Ubuntu users: sudo apt-get install cmake)"

if [ $BUILD64 -eq  1 ]; then
	echo "#include <stdio.h>
		int main(int argc, char argv[]){printf(\"test\");return 0;}" | \
		gcc -m32 -x c - -o /dev/null 2> /dev/null \
		|| die "Can't compile 32-bit code (Ubuntu users: sudo apt-get install gcc-multilib)"
fi

DEFAULT_CFLAGS="-O2 -msse -mmmx -fomit-frame-pointer"
[ $BUILD64 -eq 0 ] && DEFAULT_CFLAGS="${DEFAULT_CFLAGS} -mtune=pentium3"

ask "Enter path where glc will be installed."
ask "  (leave blank to install to root directory)"
askprompt
read DESTDIR
[ "${DESTDIR:${#DESTDIR}-1}" = "/" ] && DESTDIR="${DESTDIR:0:${#DESTDIR}-1}"
if [ "${DESTDIR}" != "" ]; then
	if [ -e "${DESTDIR}" ]; then
		[ -f "${DESTDIR}" ] && die "Invalid install directory"
	else
		mkdir -p "${DESTDIR}" 2> /dev/null \
			|| sudo mkdir -p "${DESTDIR}" 2> /dev/null \
			|| die "Can't create install directory"
	fi
fi

























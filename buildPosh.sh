#!/bin/posh
#
# Takes one optional param.
#
# PREFIX: Specify where the project is installed. default is /
#

usage()
{
	echo "usage: $0 destdir [libdir]"
	exit 1
}

building()
{
	mod=$1
	echo "Building $mod"
	[ -d $mod/build ] || mkdir $mod/build
	cd $mod/build
	
	cmake .. \
		-DCMAKE_INSTALL_PREFIX:PATH="${DESTDIR}"\
		-DCMAKE_BUILD_TYPE:STRING="Release" \
		-DCMAKE_C_FLAGS_RELEASE:STRING="${CFLAGS}" \
		-DMLIBDIR:PATH=${MLIBDIR} \
		|| exit 1
	make || exit 1
	cd ../..
}
if ! ( [ $# -eq 1 ] || [ $# -eq 2 ] ); then
	usage
fi

modElf="elfhacks"
modPak="packetstream"
modGLS="../glcs"

DESTDIR=$1
MLIBDIR=${2:-"lib"}
GLCSDIR=$PWD

export CMAKE_INCLUDE_PATH="$GLCSDIR/elfhacks/src:$GLCSDIR/packetstream/src" 
export CMAKE_LIBRARY_PATH="$GLCSDIR/elfhacks/build/src:$GLCSDIR/packetstream/build/src"

building $modElf
building $modPak
building $modGLS

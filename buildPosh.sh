#!/bin/posh
#
# Takes one optional param.
#
# PREFIX: Specify where the project is installed. default is /
#

# This is simply an easy for us to refer to when the user fails to enter enough, or too many, parameters
usage()
{
	echo "usage: $0 destdir [libdir]"
	exit 1
}

# This is simply the replacement of the for loop and the arrays
#building() takes one parameter which is the mod that it needs to build.
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

# If the user fails to enter in enough parameters, or too little, it will go back to the usage function
if ! ( [ $# -eq 1 ] || [ $# -eq 2 ] ); then
	usage
fi

#This is a simple way to refer to each mod that was in the array. The convention I've used is mod[three letters] generally the first three letters of the object. The exclusion is GLS, which would be glc other wise. 
modElf="elfhacks"
modPac="packetstream"
modGLS="../glcs"

#These variables are merely the directories that will be used.
DESTDIR=$1
MLIBDIR=${2:-"lib"}
GLCSDIR=$PWD

#This merely exports two variables and makes them global.
export CMAKE_INCLUDE_PATH="$GLCSDIR/elfhacks/src:$GLCSDIR/packetstream/src" 
export CMAKE_LIBRARY_PATH="$GLCSDIR/elfhacks/build/src:$GLCSDIR/packetstream/build/src"

#This is the other part of the for loop replacement, essentially I just refer to variables as the one parameter, as building() needs
building $modElf
building $modPac
building $modGLS

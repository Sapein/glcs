#!/bin/bash
#/bin/posh
#
# Takes one optional param.
#
# PREFIX: Specify where the project is installed. default is /
#

#This is used to print out an error message
usage()
{
	echo "usage: $0 destdir"
	exit 1
}

#This creates the array, $mods, which is the location/name for all of the 'mods' for glcs
mods=("elfhacks" "packetstream" "../glcs")

#Prints out an error message if you forget to add the peramter
if ! (( $# == 1 )); then
	usage
fi

#These get the variables needed, specifically the directory to direct this to and the directory this is currently in.
#DESTDIR is the directory it's currently in and GLCSDIR is the directory of this script
DESTDIR=$1
GLCSDIR=$PWD

#This simply goes through all of the values in $mods (where @ all of the elements), and creates the variable $mod which holds one of the values
for mod in ${mods[@]}; do
	echo "Installing $mod to $DESTDIR ..." #informs the user of wtf is going on...
	cd $GLCSDIR/$mod/build #change directory to the location of this bash script, and the location of the mod, and build...
	make install || exit 1 #if it fails the make install, then exit...
done

#This acts like cp, but creates the directory's for them, and sets the permissions for them
install -d -m755 $DESTDIR/share/glcs/scripts
install -m755 $GLCSDIR/scripts/capture.sh $DESTDIR/share/glcs/scripts/capture.sh   
install -m755 $GLCSDIR/scripts/pipe_ffmpeg.sh $DESTDIR/share/glcs/scripts/pipe_ffmpeg.sh   
install -m755 $GLCSDIR/scripts/pipe_ffmpeg.sh $DESTDIR/share/glcs/scripts/webcam_overlay_mix_audio.sh   
install -d -m755 $DESTDIR/share/licenses/glcs
install -m644 $GLCSDIR/COPYING $DESTDIR/share/licenses/glcs/COPYING #Note that this is the license of this, which is apparently GPL v2.


#!/bin/posh
#
# Takes one optional param.
# 
# PREFIX: Specify where the project is installed. default is /
#

#This is simply a function to allow the user to know the parameters of this script, if they add too many or not enough.
usage()
{
	echo "usage is $0 destdir"
	exit 1
}

#This is simply how get use usage() and check to make sure the parameters are correct.
if ! [  $# -eq 1 ]; then
	usage
fi

#This is how I replace the array. I use the same naming scheme as I defined in build(Posh).sh
modElf="elfhacks"
modPac="packetstream"
modGLS="../glcs"

#Two variables that decide how things are done. DESTDIR is value of the location that the user specified upon running the script. GLCSDIR is the working directory.
DESTDIR=$1
GLCSDIR=$PWD

#This is how I did the for loop in backaging, I found it easier, and a bit more effiecent, to just retype it than to use a function for this(unlike in build(Posh).sh
echo "Installing elfhacks to $DESTDIR"
cd $GLCSDIR/$modElf/build
make install || exit 1

echo "Installing packetstream to $DESTDIR"
cd $GLCSDIR/$modPac/build
make install || exit 1

echo "Installing ../glcs to $DESTDIR"
cd $GLCSDIR/$modGLS/build
make install || exit 1

#This essentially copies the scripts to the Destination Directory, creates their parents if they don't exist, and sets the permissions for the files. 
install -d -m775 $DESTDIR/share/glcs/scripts
install -m755 $GLCSDIR/scripts/capture.sh $DESTDIR/share/glcs/scripts/capture.sh
install -m775 $GLCSDIr/scripts/pipe_ffmeg.sh $DESTDIR/share/glcs/scripts/pipe_ffmpeg.sh
install -m755 $GLCSDIR/scripts/webcam_overlay_mix_audio.sh $DESTDIR/share/glcs/scripts/webcam_ovoerlay_mis_audio.sh
install -d -m755 $DESTDIR/share/licenses/glcs
install -m644 $GLCSDIR/COPYING $DESTDIR/share/licenses/glcs/COPYING 

#!/bin/posh
#
# Takes one optional param.
# 
# PREFIX: Specify where the project is installed. default is /
#

usage()
{
	echo "usage is $0 destdir"
	exit 1
}

if ! [  $# -eq 1 ]; then
	usage
fi

mods=3 
modElf="elfhacks"
modPac="packetstream"
modGLS="../glcs"

DESTDIR=$1
GLCSDIR=$PWD

echo "Installing elfhacks to $DESTDIR"
cd $GLCSDIR/$modElf/build
make install || exit 1

echo "Installing packetstream to $DESTDIR"
cd $GLCSDIR/$modPac/build
make install || exit 1

echo "Installing ../glcs to $DESTDIR"
cd $GLCSDIR/$modGLS/build
make install || exit 1

install -d -m775 $DESTDIR/share/glcs/scripts
install -m755 $GLCSDIR/scripts/capture.sh $DESTDIR/share/glcs/scripts/capture.sh
install -m775 $GLCSDIr/scripts/pipe_ffmeg.sh $DESTDIR/share/glcs/scripts/pipe_ffmpeg.sh
install -m755 $GLCSDIR/scripts/webcam_overlay_mix_audio.sh $DESTDIR/share/glcs/scripts/webcam_ovoerlay_mis_audio.sh
install -d -m755 $DESTDIR/share/licenses/glcs
install -m644 $GLCSDIR/COPYING $DESTDIR/share/licenses/glcs/COPYING 

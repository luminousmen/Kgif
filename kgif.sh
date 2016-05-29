#!/bin/sh

# capturing delay
SCROT_DELAY=0.5
# delay in gif
GIF_DELAY=10
# clean tmp directory
noclean=true

ctrlc() {
	echo "\nStop capturing"

	echo "Converting to gif..."
	convert -quiet -delay $GIF_DELAY -loop 0 *.png ../terminal.gif
	cd ..

	if [ "$noclean" = true ] ; then
		echo "Cleaning..."
		clean
	fi

	echo "Done!"
	exit 2
}

clean() {
	rm -rf $NOW
}

capturing() {
	echo "Capturing..."
	cd ./$NOW
	while true
	do
		scrot -u -d $SCROT_DELAY
	done
}


# main()
trap "ctrlc" 2

NOW=$(date +"%m-%d-%Y_%H:%M:%S")
if [ ! -d ./$NOW ]; then
	mkdir ./$NOW
fi

# if no delay passing
if test -z "$delay" ; then
	$delay = 1
fi

# wait for a while
sleep $delay

capturing

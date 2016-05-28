#!/bin/sh

# capturing delay
SCROT_DELAY=0.2
# delay in gif
GIF_DELAY=10

ctrlc() {
	echo "Stop capturing"

	echo "Converting to gif..."
	convert -delay $GIF_DELAY -loop 0 *.png terminal.gif
	clean
	
	exit 2
}

clean() {
	rm *.png
}

capturing() {
	echo "Capturing..."
	while true
	do
		scrot -u -d $SCROT_DELAY
	done
}


# main()
trap "ctrlc" 2

if [ ! -d ~/pics ]; then
	mkdir ~/pics
fi

# if no delay passing
if test -z "$delay" ; then
	$delay = 1
fi

# wait for a while
sleep $delay

capturing

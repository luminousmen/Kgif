#!/bin/sh

# Copyright (c) 2016, Bobrov Kirill
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#  * Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
# DAMAGE.


NOCLEAN=false
# capturing delay
SCROT_DELAY=0.5
# delay in gif
GIF_DELAY=1
# output gif file
GIF_FILENAME="terminal.gif"
# clean tmp directory

usage() {
    echo "usage: ./kgif.sh [--delay] [--filename ] [--gifdelay] [--noclean] [--check] [-h]"
    echo "  -h, --help                   Show this help, exit"
    echo "      --check                  Check if all dependencies are installed, exit"
    echo "      --delay=<sec>            Set delay in seconds to specify how long script will wait until start capturing."
    echo "      --gifdelay=<sec>         Set delay in seconds to specify how fast images appears in gif."
    echo "      --filename=<file name>   Set file name for output gif."
    echo "      --noclean                Set if you don't want to delete source *.png screenshots."
    echo ""
}

ctrlc() {
    printf "\\nStop capturing"

    echo "Converting to gif..."
    convert -quiet -delay $GIF_DELAY -loop 0 -- *.png ../$GIF_FILENAME
    cd ..

    if [ "$NOCLEAN" = false ] ; then
        echo "Cleaning..."
        clean
    fi

    echo "Done!"
    exit 2
}

clean() {
    rm -rf "$NOW"
}

capturing() {
    echo "Capturing..."
    cd ./"$NOW" || exit
    while true
    do
        scrot -u -d $SCROT_DELAY
    done
}

dependency_check() {
    (which scrot > /dev/null 2>&1 && echo "OK: found scrot") || echo "ERROR: scrot not found"
    (which convert > /dev/null 2>&1 && echo "OK: found imagemagick") || echo "ERROR: imagemagick not found"
    exit 2
}

while [ "$1" != "" ]; do
    PARAM=$(echo "$1" | awk -F= '{print $1}')
    VALUE=$(echo "$1" | awk -F= '{print $2}')
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        --delay)
            DELAY=$VALUE
            ;;
        --gifdelay)
            GIF_DELAY=$VALUE
            ;;
        --filename)
            GIF_FILENAME=$VALUE
            echo "Out file - $GIF_FILENAME"
            ;;
        --noclean)
            NOCLEAN=true
            echo "NOCLEAN mode enabled"
            ;;
        --check)
            CHECK=true
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
        shift
done


# main()

# dependency check
if [ "$CHECK" = true ] ; then
    dependency_check
fi

trap "ctrlc" INT TERM

NOW=$(date +"%m-%d-%Y_%H:%M:%S")
if [ ! -d ./"$NOW" ]; then
    mkdir ./"$NOW"
fi

# if no delay passing
if test -z "$DELAY" ; then
    DELAY=1
fi

echo "Setting delay to $DELAY sec"
echo ""

# wait for a while
sleep $DELAY

capturing

#!/usr/bin/env bash

function handleResponse {
    url=`echo $1 | grep -Eo '(http|https)://[^/"]+/\w+\.?\w+?'`
    copyq copy ${url}

    if [ ${2} != true ]
    then
        notify-send "fred.moe" "Uploaded as ${url}."
    else
        echo "Seems to be an image"
        notify-send "fred.moe" "Uploaded as ${url}." "-i" "/tmp/moe.png"
    fi

    aplay `dirname $0`/completed_sound.wav
}

len=`copyq clipboard text/plain | wc --bytes`

if [ ${len} != 0 ]
then
    # Upload text
    copyq clipboard text/plain > /tmp/moe.txt
    handleResponse `curl -X POST -F "file=@/tmp/moe.txt" https://fred.moe/upload`
    exit
fi

len=`copyq clipboard image/png | wc --bytes`

if [ ${len} != 0 ]
then
    # Upload text
    copyq clipboard image/png > /tmp/moe.png
    handleResponse `curl -X POST -F "file=@/tmp/moe.png" https://fred.moe/upload` true
    exit
fi

exit 1
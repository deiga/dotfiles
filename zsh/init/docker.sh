#!/bin/sh

if type boot2docker > /dev/null
then 
    $(boot2docker shellinit)
fi

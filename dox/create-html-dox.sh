#! /usr/bin/env mulle-bash

# grab all files

if [ ! -d "dox" ]
then
   echo "must be run in root folder" 1>&2
   exit 1
fi

# stop on failure

mulle-scion -w &
PID=$#

sleep 2
wget -E -nd -P html/raw -m http://127.0.0.1:18048

set -x

for i in html/raw/*
do
   file="${i##*/}"
   file="${file%%.scion*}.html"
   file="${file//.html.html/.html}"
   sed -e 's/\.scion?wrapper=_wrapper\.scion/.html/g' "$i" > "html/${file}"
done

kill $PID


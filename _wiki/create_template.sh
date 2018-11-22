#!/bin/bash
#author: lisongsong
#description: make template md file

set -o errexit
set -o nounset

[ $# -ge 1 ] || {
	echo "wrong args length: less than 1"
	echo "Usage: bash $0 keyword1 keyword2 ..."
	exit 1
}

CURRENT=$(cd $(dirname $BASH_SOURCE) && pwd -P)
IMAGE="${CURRENT%/*}/images/posts"

DATE=`date +%Y-%m-%d`
keyword=$@
title=`echo $keyword | tr ' ' '-'`
if [ ! -d "$IMAGE/$title" ]
then
	mkdir "$IMAGE/$title"
fi
url="${DATE}-${title}.md"

[ -f template.md ] && cp template.md $url
mkdir "$IMAGE/$title" && echo "mkdir $IMAGE/$title"

exit $?

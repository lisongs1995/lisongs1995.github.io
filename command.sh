#!/bin/bash
# usage : bash push.sh message
# usage : bash push.sh
# desciption : update boke

set -o pipefail
#set -x

trap "echo \$LINENO has occured err !!!" ERR

CURRENT=$(cd $(dirname $BASH_SOURCE) && pwd -P)

function upload() {

  local message="$1"
  [ -z "$message" ] && message="update"
  git add . 
  echo "list all added files (y/n)? "
  read ans

  if [ "$ans" ==  "y" -o "$ans" == "Y" -o "$ans" == "yes" ]
  then
    git status

  elif [ "$ans" == "n" -o "$ans" == "N"  -o "$ans" == "no" ]
  then
    echo "added ..."
  else
    echo "wrong args"
  fi
  git commit -m "$message"
  git push origin master && echo "successfully pushed !!"

}

function watch() {

  jekyll s watch  
}


function link_submit(){

  curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=www.lss-bupt.com&token=Xsw8cxgKb3zszvBS" 
}

function main() {

  if [ $# -ne 1 -a $# -ne 2 ]
  then
    echo "wrong args"
    exit 1
  fi
  case $1 in 
    "upload"|"u")
      if [ -z  "$2" ]
      then
        echo "given two args"
        exit 1
      fi
      upload $2
      ;;
    "watch"|"w")
      watch
      ;;
    "link-submit"|"l")
      link_submit && echo "successfully submit url to baidu"
      if [ -s "urls.txt" ]
      then
        >urls.txt >/dev/null
      fi
      ;;
    *)
    echo "error args !!!"
  esac
}

main $@

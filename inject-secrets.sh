#!/bin/sh
set -u

declare () {
  echo "Will use .env to update Smashing files: "
  echo "Continue ?"
}

update_config () {
  if [ -f ".env" ]
  then
      auth_token=$(cat .env | grep SMASHING_KEY | cut -d'=' -f2 | tr -d "\n")
  else
      auth_token=${SMASHING_KEY}
  fi
  sed -i "s/^.*set :auth_token, '.*'$/  set :auth_token, \'$auth_token\'/" ./smashing/config.ru
}

update () {
  file="./smashing/config.ru"
  if [ ! -f "$file" ] ;
  then
    echo "$file not found. Exiting."
    exit 1
  fi

  update_config

  if [ "$?" = "0" ] ;
  then
    echo "Files updated."
  fi
}

wont_update () {
  exit 1
}

declare

read continue_update
case $continue_update in
  [yYoO]*) update;;
  [nN]*) wont_update;;
  *) echo "Undefined option. (y/n)." && exit 1;;
esac

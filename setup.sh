#!/bin/bash

if [ "$(git config --get remote.origin.url)" != 'git@github.com:henrique-dev/hera-rails-postgresql-puma-docker.git' ]
then
  echo "Changing nammes in project and project name"
  SIMPLE_NAME='hera'
  CLASS_NAME='Hera'
  PORT='SETUP_PORT'
  if [ "$1" != '' ] && [ "$2" != '' ]
  then
    NEW_SIMPLE_NAME=$(sed -e 's/\(.*\)/\L\1/' <<< "$1")
    NEW_CLASS_NAME=$(sed -r 's/(^|-|_)(\w)/\U\2/g' <<<"$NEW_SIMPLE_NAME")
    NEW_PORT=$2

    find . -name '*'$SIMPLE_NAME'*' | while read FILE ; do
      newfile="$(echo ${FILE} |sed -e 's/'$SIMPLE_NAME'/'$NEW_SIMPLE_NAME'/')" ;
      echo "Renaming file $FILE to $newfile"
      mv "${FILE}" "${newfile}" ;
    done

    find . -type f -not -path './setup.sh' -exec sed -i 's/'$SIMPLE_NAME'/'$NEW_SIMPLE_NAME'/g' {} +
    find . -type f -not -path './setup.sh' -exec sed -i 's/'$CLASS_NAME'/'$NEW_CLASS_NAME'/g' {} +
    find . -type f -not -path './setup.sh' -exec sed -i 's/'$PORT'/'$NEW_PORT'/g' {} +

    echo "SELF DESTROYING SETUP"
    rm -- "$0"
    rm README.md
    echo "Updating git index"
    rm -f .git/index
    git reset
    echo "git add ."
    git add .
    echo "git commit"
    git commit -m "change project name ${SIMPLE_NAME} to $1 and the port for $2"
    echo "git push"
    git push
  fi
fi

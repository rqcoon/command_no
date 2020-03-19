#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
#$DIR && path
CMDDIR="${DIR}/no"
MP3DIR="$DIR/no.mp3"
TXTDIR="$DIR/no.txt"
BLUE='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'


printf '%b\n' "$DIR"

#check before install
while true; do
    read -p "Is this where everything is currently? Do you wish to continue? " yn
    case $yn in
        [Yy]* ) sudo cp -rp $CMDDIR /usr/local/bin;
                sudo mkdir /usr/local/bin/command_no
                sudo cp -rp $MP3DIR /usr/local/bin/command_no;
                sudo cp -rp $TXTDIR /usr/local/bin/command_no;
                break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

#determine operating system to notify linux users of prerequisites
case $(uname | tr '[:upper:]' '[:lower:]') in
  linux*)
    TRAVIS_OS_NAME="linux"
    ;;
  darwin*)
    TRAVIS_OS_NAME="osx"
    ;;
  msys*)
    TRAVIS_OS_NAME="windows"
    ;;
  *)
    TRAVIS_OS_NAME="notset"
    ;;
esac

#notify linux users of prerequisites
if [ $TRAVIS_OS_NAME == "linux" ]
then
  while true; do
    read -p "This command requires the mpg123 package to be installed for the audio to play, please install mpg123 before attempting to use the command. Do you still wish to continue? " yn
    printf "you can install mpg123 through ${YELLOW}sudo apt-get install mpg123${NC}\n"
    printf "${BLUE}install complete ${NC}\n"
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
      esac
    done
elif [ $TRAVIS_OS_NAME == "osx" ]
then
  printf "${BLUE}install complete ${NC}\n"
else
  echo "how?"
fi
#fuck

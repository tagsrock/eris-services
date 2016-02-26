#!/usr/bin/env bash
#XXX todo re-write this
# ----------------------------------------------------------
# PURPOSE .

# This is the test manager for marmot. It will run the testing
# sequence for marmot using docker.

# ----------------------------------------------------------
# REQUIREMENTS

# eris installed locally

# ----------------------------------------------------------
# USAGE

# test.sh

# ----------------------------------------------------------
# Set defaults

# Where are the Things?


# cd into the repo; 
# get array of services: if file == "*.toml" {}
# or something
#t the hashes; add them;
# `eris services import name #hash
# start service
# exec ls on it
# test that it is still running
# stop and remove
# next service

name=eris-services
base=github.com/eris-ltd/$name
repo=`pwd`
if [ "$CIRCLE_BRANCH" ]
then
  ci=true
  linux=true
elif [ "$TRAVIS_BRANCH" ]
then
  ci=true
  osx=true
elif [ "$APPVEYOR_REPO_BRANCH" ]
then
  ci=true
  win=true
else
  repo=$GOPATH/src/$base
  ci=false
fi

# setup other things?

test_exit=0
export ERIS_PULL_APPROVE="true"
#export ERIS_MIGRATE_APPROVE="true"

perform_tests(){

all_services=$(ls *.toml)

for service in ${all_services[@]}; do
	serv=$(echo $service | awk -F. '{ print $1 }')

	if [ "$serv" == "marmot" ] || [ "$serv" == "toadserver" ] || [ "$serv" == "do_not_use" ] || [ "$serv" == "mindy" ]
	then	
	  #echo "Skipping $serv" #for not
	  continue
	fi

	eris services start $serv
	#eris services exec $serv "ls" -p #randomize port
	eris services stop $serv
 	if [ $? -ne 0 ]
 	then
     	  test_exit=1
   	  return 1
 	fi
done
}

test_teardown(){
  if [ "$ci" = false ]
  then	
    eris clean
  fi

  if [ "$test_exit" -eq 0 ]
  then
    echo "Tests complete! Tests are Green. :)"
  else
    echo "Tests complete. Tests are Red. :("
  fi
  exit $test_exit

}

echo "Testing all the services"

perform_tests

test_teardown


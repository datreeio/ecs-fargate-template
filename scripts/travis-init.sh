#!/bin/bash
echo "datree.io travis init script"
echo "DO NOT ENTER YOUR OWN AWS CREDENTIALS! USE THE TRAVIS USER!"
echo "Please enter your AWS_ACCESS_KEY_ID"
travis encrypt AWS_ACCESS_KEY_ID=`read` --add
echo "Please enter your AWS_SECRET_ACCESS_KEY"
travis encrypt AWS_SECRET_ACCESS_KEY=`read` --add
echo "Please enter your GH_TOKEN"
travis encrypt GH_TOKEN=`read` --add
echo "Please enter your NPM_TOKEN"
travis encrypt NPM_TOKEN=`read` --add
echo "Done - check your travis.yml"

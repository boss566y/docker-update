#!/bin/bash

stacks_locations = ~/docker/

cd $stacks_locations

docker_folders=$(ls -d */)

for folder in $docker_folders
	do
		cd $folder
		echo "Update? $folder"
		select option in "Yes" "No"; do
		choice=${option:-$REPLY}
			case $choice in
				Yes | yes | Y | y ) docker compose pull && docker compose down && docker compose up -d ; break;;
				No | no | N | n ) break;;
				* ) break;;
			esac
		done
		cd ..
	done

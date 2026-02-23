#!/bin/bash

stacks_locations = ~/docker/

cd $stacks_locations

docker_folders=$(ls -d */)

docker_update() {
	docker compose pull && docker compose down && docker compose up -d
}


for folder in $docker_folders; do
	# RESETS
	cd ~/docker/$folder

	docker_update_choice=""

	# CHECKS
	if [ ! -f ./docker-compose.yml ]; then
		continue
	fi

	if [ -f ./.docker_update_choice ]; then
		docker_update_choice=$(cat ./.docker_update_choice)
	fi

	# DOCKER UPDATES
	case $docker_update_choice in
		Yes | yes ) docker_update ; continue;;
		No | no ) continue;;
		* ) ;;
	esac

	echo "Update? $folder"
	select option in "Yes" "No"; do
	choice=${option:-$REPLY}
		case $choice in
			Yes | yes | Y | y ) docker_update ; break;;
			No | no | N | n ) break;;
			* ) break;;
		esac
	done
done

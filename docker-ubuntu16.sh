#!/bin/bash

# installs docker

username="$USER"

if ! sudo ls > /dev/null; then
	printf "prime sudo:\n"; sudo ls
fi

function install() {
	sudo apt-get update

	sudo apt-get -y install \
    		apt-transport-https \
    		ca-certificates \
    		curl \
    		software-properties-common

	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

	sudo add-apt-repository \
   		"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   		$(lsb_release -cs) \
   		stable"

	sudo apt-get update

	sudo apt-get install -y docker-ce

	sudo usermod -aG docker $username

	newgrp docker
}

if ! docker ps; then
	install
else
	docker run docker/whalesay cowsay "All done!"
fi

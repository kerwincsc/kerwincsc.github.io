#!/bin/bash
set -e

function source_change_docker_ce ()
{
    yum-config-manager --add-repo https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo
}


####### main part ##############
case $1 in
    docker)
	echo "Changing the source of docker"
    #	source_change_docker_ce
	echo "Docker source has changed!"
	;;
    
    status|*)
	echo "source-change status | docker"
	;;
esac

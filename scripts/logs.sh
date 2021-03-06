#!/bin/bash

#GLOBAL COLS
cols=$(tput cols)
middle_of_screen=$(expr $cols / 3)
load_env() {
    source ./.env
    APP_NAME=$APP_NAME
}
entry_screen() {
    # clear the screen
    tput clear
    # Move cursor to screen location X,Y (top left is 0,0)
    tput cup 3 $middle_of_screen
    echo -e "############################"
    tput cup 4 $middle_of_screen
    echo -e "######  SCRIPT  LOGS   #####"
    tput cup 5 $middle_of_screen
    echo -e "############################"
}
nodes_screen() {
    for ((i = 0; i < cols; i++)); do printf "="; done
    docker node ls -f "role=worker" --format "{{.Hostname}}" | while read entry_node; do
        docker -H $entry_node ps -q | while read containers_id; do
            for ((i = 0; i < cols; i++)); do printf "="; done
            echo "DOCKER NODE: $entry_node"
            echo "Container ID: $containers_id"
            echo "LOGS:"
            docker -H $entry_node logs $containers_id
            for ((i = 0; i < cols; i++)); do printf "="; done
        done
    done
    for ((i = 0; i < cols; i++)); do printf "="; done
}
stack_screen() {
    # Move cursor to screen location X,Y (top left is 0,0)
    # tput cup 13 $middle_of_screen
    # tput setaf 3
    echo -e "\tStack Name ---> $APP_NAME"
    # Set a foreground colour using ANSI escape
    # tput sgr0
}
load_env
entry_screen
nodes_screen
stack_screen

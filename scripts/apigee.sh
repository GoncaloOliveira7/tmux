#!/bin/bash

SESH="apigee"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
	tmux new-session -d -s $SESH -n "front"

	tmux send-keys -t $SESH "cd ~/work_dir/runway/plugins/backstage-plugin-apigee/" C-m
	tmux send-keys -t $SESH "nvim ." C-m
	tmux split-window -h
	tmux send-keys -t $SESH "cd ~/work_dir/runway/plugins/backstage-plugin-apigee/" C-m

	tmux new-window -t $SESH:2 -n "back"
	tmux send-keys -t $SESH "cd ~/work_dir/runway/plugins/backstage-plugin-apigee-backend/" C-m
	tmux send-keys -t $SESH "nvim ." C-m
	tmux split-window -h
	tmux send-keys -t $SESH "cd ~/work_dir/runway/plugins/backstage-plugin-apigee-backend/" C-m

	tmux new-window -t $SESH:3 -n "common"
	tmux send-keys -t $SESH "cd ~/work_dir/runway/plugins/backstage-plugin-apigee-common/" C-m
	tmux send-keys -t $SESH "nvim ." C-m
	tmux split-window -h
	tmux send-keys -t $SESH "cd ~/work_dir/runway/plugins/backstage-plugin-apigee-common/" C-m

	tmux select-window -t $SESH:front
	tmux select-pane -t 1
	tmux resize-pane -Z
fi

tmux attach-session -t $SESH


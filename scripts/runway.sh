#!/bin/bash

SESH="runway"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
	tmux new-session -d -s $SESH -n "editor"

	tmux send-keys -t $SESH:editor "cd ~/work_dir/runway/" C-m
	tmux send-keys -t $SESH:editor "nvim" C-m
	tmux split-window -h

	tmux new-window -t $SESH -n "server"
	tmux send-keys -t $SESH:server "cd ~/work_dir/runway/" C-m
	tmux send-keys -t $SESH:server "yarn install && runway_dev" C-m
	tmux split-window -h
	tmux send-keys -t $SESH:server "cd ~/work_dir/runway/" C-m

	tmux select-window -t $SESH:editor
	tmux select-pane -t 1
	tmux resize-pane -Z
fi

tmux attach-session -t $SESH


#!/bin/bash

SESH="approval"
DIR="~/work_dir/request-approval-service/"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
    tmux new-session -d -s $SESH -n "editor"

    tmux send-keys -t $SESH:editor "cd ${DIR}" C-m
    tmux send-keys -t $SESH:editor "nvim" C-m
    # tmux split-window -h

    tmux new-window -t $SESH -n "shell"
    tmux send-keys -t $SESH:shell"cd ${DIR}" C-m
    # tmux split-window -h
    # tmux send-keys -t $SESH:server "cd ${DIR}" C-m

    tmux new-window -t $SESH -n "logs"
    tmux send-keys -t $SESH:logs "cd ${DIR}" C-m
    tmux send-keys -t $SESH:tunnel "aws sso login --profile admin-testing" C-m
    tmux send-keys -t $SESH:tunnel "sam logs --stack-name request-approval-service-dev --profile admin-testing --tail host -p 7007 --allow-anonymous" C-m


    tmux new-window -t $SESH -n "tunnel"
    tmux send-keys -t $SESH:tunnel "cd ${DIR}" C-m
    tmux send-keys -t $SESH:tunnel "devtunnel host -p 7007 --allow-anonymous" C-m


    tmux select-window -t $SESH:editor
    tmux select-pane -t 1
    # tmux resize-pane -Z
fi

tmux attach-session -t $SESH


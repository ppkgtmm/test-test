#!/bin/sh

RED="\033[0;31m"
CLEAR="\033[0m"

usage() {
    echo "usage: ./run.sh command"
    echo "where command is one of init, clean, viz, model, tune, api, ui"
}

prepenv() {
    source venv/bin/activate
    export PYTHONPATH=${PWD}
}

init() {
    python3.8 -m venv venv
    prepenv
    pip3 install -r requirements.txt
}

preprocess() {
    prepenv
    python3 runners/preprocess.py
}

visualize() {
    prepenv
    python3 runners/visualize.py
}


model() {
    prepenv
    python3 runners/model.py
}

tune() {
    prepenv
    python3 runners/tune.py
}

api() {
    prepenv
    uvicorn app.api:app --reload
}

if [ "$1" == "init" ]
then
    init
elif [ "$1" == "clean" ]
then
    preprocess
elif [ "$1" == "viz" ]
then
    visualize
elif [ "$1" == "model" ]
then
    model
elif [ "$1" == "tune" ]
then
    tune
elif [ "$1" == "api" ]
then
    api
elif [ "$1" == "ui" ]
then
    open app/frontend.html
else
    usage
    echo "${RED}error : invalid argument${CLEAR}"
    exit 1
fi

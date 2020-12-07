#! /bin/bash

# Author: TimBao

# show uuid
# generate crash log

#------------------------------------变量-------------------------
CURDIR=$PWD
PROJECT_NAME=""
SHOW_UUID=0
PRINT_LOG=0

#-------------------------------------函数------------------------
function install_dwarfdump() {
    which dwarfdump > /dev/null 2>&1
}

function showUUID() {
    install_dwarfdump
    if [ $? -eq 0 ]
    then
       dwarfdump --uuid $CURDIR/$PROJECT_NAME.app/$PROJECT_NAME
       dwarfdump --uuid $CURDIR/$PROJECT_NAME.app.dSYM
       cat $CURDIR/*.ips | grep uuid
    else
        echo "please make sure dwarfdump exist."
    fi
}

function analyzeLog() {

    echo "start to analytics ... ..."

    TOOL=$(find /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/ -type f -name symbolicatecrash)

    export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
    $TOOL *.ips *.app.dSYM > ./Crash.log

    echo "End analytics and open Crash.log to investigate."
}

function usage() {

    echo "Usage: args [-h] [-u] [-a] [-name xxx]"
    echo "-h means help"
    echo "-u means show uuid"
    echo "-a means print crash log"
    echo "-p means project name"
}

#--------------------------执行入口--------------------------

while getopts huap: option
do
    case "$option" in
        u)
            SHOW_UUID=1;;
        a)
            PRINT_LOG=1;;
        p)
            PROJECT_NAME=$OPTARG;;
        h)
            usage
            exit 1;;
    esac
done

echo "project name :$PROJECT_NAME"

if [ $PROJECT_NAME ]; then
    if [ $SHOW_UUID -eq 1 ] && [ $PRINT_LOG -eq 1 ]; then
        showUUID
        analyzeLog
    elif [ $SHOW_UUID -eq 1 ]; then
        showUUID
    elif [ $PRINT_LOG -eq 1 ]; then
        analyzeLog
    else
        echo "something is wrong"
    fi
else
    usage
    exit 1;
fi

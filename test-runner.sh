#!/bin/bash
# Script that runs robot framework tests on Xvfb using Firefox as a browser
set -e
# Set the defaults values
DEFAULT_LOG_LEVEL="INFO" # Available levels: TRACE, DEBUG, INFO (default), WARN, NONE (no logging)
DEFAULT_RES="1280x1024x24"
# Use default if none specified as env var
LOG_LEVEL=${LOG_LEVEL:-$DEFAULT_LOG_LEVEL}
RES=${RES:-$DEFAULT_RES}     
DISPLAY=":99"
ROBOT_TESTS="/Tests/"
# Start Xvfb
echo -e "Starting Xvfb on display ${DISPLAY} with res ${RES}"
Xvfb ${DISPLAY} -ac -screen 0 ${RES} +extension RANDR &
export DISPLAY=${DISPLAY}
# Show firefox version
echo Firefox version is: `firefox -v`
# Execute tests
echo -e "Executing robot tests at log level ${LOG_LEVEL}"
pybot -d /TestResults/TestResults-`date +%Y-%m-%d-%H_%M_%S` --loglevel ${LOG_LEVEL} ${ROBOT_TESTS}
# Stop Xvfb
kill -9 $(pgrep Xvfb)
#!/usr/bin/env sh

echo 'Terminating the "npm start" process using its PID from ".pidfile"...'

# Ensure the script exits if any command fails
set -e

# Check if .pidfile exists
if [ ! -f .pidfile ]; then
  echo 'Error: .pidfile not found.'
  exit 1
fi

# Read the PID from .pidfile
PID=$(cat .pidfile)

# Verify if the process is running
if ! ps -p "$PID" > /dev/null 2>&1; then
  echo "Warning: Process with PID $PID not found. It might have already terminated."
  rm -f .pidfile  # Clean up .pidfile
  exit 0  # Exit gracefully
fi

# Kill the process
set -x
kill "$PID"

# Remove the .pidfile after successful termination
rm -f .pidfile
echo "Process $PID terminated successfully."



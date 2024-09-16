#!/bin/bash

# Start port forwarding in the background
kubectl port-forward --address 0.0.0.0 pod/nginx-bf5d5cf98-c6hx8 8888:80 &

# Get the process ID of the last background command
PID=$!

# Optionally, you can wait for a few seconds to ensure the port-forwarding has started
sleep 2

# Check if the process is still running
if ps -p $PID > /dev/null; then
  echo "Port forwarding is running in the background with PID $PID."
else
  echo "Port forwarding failed to start."
fi

ps -f -p $PID

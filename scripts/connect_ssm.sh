#!/bin/bash

# Define instance IDs
MANAGEMENT_INSTANCE_ID="i-0d13c3283ec88ecef"
MONITORING_INSTANCE_ID="i-0b451df7d6e7f32d8"
APPLICATION_INSTANCE_IDS=("i-00e42f293b796d80f" "i-001368da7593a2d80" )

# Function to start SSM session
start_ssm_session() {
  local instance_id=$1
  echo "Starting SSM session for instance: $instance_id"
  aws ssm start-session --target $instance_id
}

# Menu for selecting instance
echo "Select an instance to connect:"
echo "1) Management Instance"
echo "2) Monitoring Instance"
echo "3) Application Instance 1"
echo "4) Application Instance 2"
echo "5) Application Instance 3"
read -p "Enter your choice [1-5]: " choice

case $choice in
  1)
    start_ssm_session $MANAGEMENT_INSTANCE_ID
    ;;
  2)
    start_ssm_session $MONITORING_INSTANCE_ID
    ;;
  3)
    start_ssm_session ${APPLICATION_INSTANCE_IDS[0]}
    ;;
  4)
    start_ssm_session ${APPLICATION_INSTANCE_IDS[1]}
    ;;
  5)
    start_ssm_session ${APPLICATION_INSTANCE_IDS[2]}
    ;;
  *)
    echo "Invalid choice"
    ;;
esac

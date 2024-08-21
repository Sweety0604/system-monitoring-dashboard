#!/bin/bash

# Function to display the top 10 most used applications by CPU and memory usage
top_applications() {
  echo "Top 10 Applications by CPU Usage:"
  ps aux --sort=-%cpu | head -n 11
  echo "-----------------------------------"
  echo "Top 10 Applications by Memory Usage:"
  ps aux --sort=-%mem | head -n 11
}

# Function to monitor network connections and traffic
network_monitoring() {
  echo "Network Monitoring:"
  echo "-----------------------------------"
  echo "Concurrent Connections:"
  ss -s
  echo "-----------------------------------"
  echo "Network Interfaces and Traffic:"
  netstat -i
}

# Function to display disk usage
disk_usage() {
  echo "Disk Usage:"
  df -h | awk '$5 > 80 {print $0}'  # Highlight partitions using more than 80% of space
}

# Function to display system load and CPU usage
system_load() {
  echo "System Load:"
  uptime
  echo "-----------------------------------"
  echo "CPU Usage:"
  mpstat
}

# Function to display memory usage
memory_usage() {
  echo "Memory Usage:"
  free -h
  echo "-----------------------------------"
  echo "Swap Usage:"
  free -h | grep "Swap"
}

# Function to display process monitoring
process_monitoring() {
  echo "Process Monitoring:"
  echo "-----------------------------------"
  echo "Top 5 Processes by CPU Usage:"
  ps aux --sort=-%cpu | head -n 6
  echo "-----------------------------------"
  echo "Top 5 Processes by Memory Usage:"
  ps aux --sort=-%mem | head -n 6
}

# Function to monitor essential services
service_monitoring() {
  echo "Service Monitoring:"
  echo "-----------------------------------"
  echo "sshd service status:"
  systemctl is-active sshd
  echo "nginx/apache service status:"
  systemctl is-active nginx || systemctl is-active apache2
}

# Parse command-line switches
while [ "$1" != "" ]; do
    case $1 in
        -cpu )           system_load
                         ;;
        -memory )        memory_usage
                         ;;
        -network )       network_monitoring
                         ;;
        -disk )          disk_usage
                         ;;
        -process )       process_monitoring
                         ;;
        -service )       service_monitoring
                         ;;
        -applications )  top_applications
                         ;;
        * )              echo "Invalid option: $1"
                         exit 1
    esac
    shift
done

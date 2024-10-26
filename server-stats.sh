#!/bin/bash

# get total CPU usage
get_cpu_usage() {
    echo "CPU Usage:"
    top -bn1 | grep "Cpu(s)" | \
    sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
    awk '{print "CPU Load: " 100 - $1"%"}'
}

# get total memory usage
get_memory_usage() {
    echo "Memory Usage:"
    free -h | awk '/Mem:/ {printf "Used: %s / Total: %s (%.2f%%)\n", $3, $2, $3/$2 * 100.0}'
}

# get total disk usage
get_disk_usage() {
    echo "Disk Usage:"
    df -h --total | awk '/total/ {printf "Used: %s / Total: %s (%.2f%%)\n", $3, $2, $5}'
}

# get top 5 processes by CPU usage
get_top_cpu_processes() {
    echo "Top 5 Processes by CPU Usage:"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6
}

# get top 5 processes by memory usage
get_top_memory_processes() {
    echo "Top 5 Processes by Memory Usage:"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -6
}

# Additional stats
get_additional_stats() {
    echo "OS Version: $(uname -a)"
    echo "Uptime: $(uptime -p)"
    echo "Logged in Users: $(who | wc -l)"
}

main() {
    echo "Server Performance Stats"
    echo "========================"
    
    get_cpu_usage
    echo ""
    
    get_memory_usage
    echo ""
    
    get_disk_usage
    echo ""
    
    get_top_cpu_processes
    echo ""
    
    get_top_memory_processes
    echo ""
    
    get_additional_stats
}

main

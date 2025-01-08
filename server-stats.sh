#!/bin/bash
#shell script to get server performance stats

cpu_threshold=70
mem_threshold=70
disk_threshold=70

total_cpu_usage() {
	cpu_idle=$(top -b -n 1 | grep Cpu |sed 's/,/, /g' | awk '{print $8}' | cut -f 1 -d ".") #sed to add a space between fields to get more normalized o/p format
	cpu_use=$((100 - cpu_idle))
	echo "Total CPU Usage: $cpu_use%"
	if [ "$cpu_use" -gt "$cpu_threshold" ]
		then
			echo "Warning! High CPU usage!"
			echo "Sending warning mail ..."
			echo "CPU Usage higher than 70%" | mail -s "CPU Warning" someone@something.com
		else
			echo "CPU is fine."
	fi

}

total_memory_usage(){
	mem_free=$(free -m | grep Mem | awk '{print $4+$6}')
	mem_used=$(free -m | grep Mem | awk '/Mem/ {printf "%.0f", ($3/$2)*100}')
	echo "Total Memory Usage: $mem_used%"
	if [ "$mem_used" -gt "$mem_threshold" ]
		then
			echo "Warning! High Memory usage!"
			echo "Sending warning mail ..."
			echo "Memory Usage higher than 70%" | mail -s "Memory Warning" someone@something.com
		else
	                echo "Memory is fine."
	fi
}

total_disk_usage(){
	disk_use=$(df -P | awk '/\/dev/ && !/tmp|boot/ {sum += $5} END {print sum}') #grep /dev | grep -v -E '(tmp|boot)' | awk '{print $5}' | cut -f 1 -d "%")
	echo "Total Disk Usage: $disk_use%"
	if [ "$disk_use" -gt "$disk_threshold" ]
		then
			echo "Warning! High Disk usage!"
			echo "Sending warning mail ..."
			echo "Disk Usage higher than 70%" | mail -s "Disk Warning" someone@something.com
		else
			echo "Disk is fine."
	fi
}

top_five_cpu(){
	echo "Top 5 processes by CPU usage: "
	ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6
}

top_five_mem(){
	echo "Top 5 processes by memory usage: "
	ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6
}

total_cpu_usage
total_memory_usage
total_disk_usage
top_five_cpu
top_five_mem

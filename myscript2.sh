#!/bin/bash

# Elegxw an dinetai argument
if [ -z "$1" ]; then
	usernames_file=usernames.txt
else
	usernames_file=$1
fi

# Diabase kathe onoma apo to arxeio
while read -r username; do
	if [ -z "$username" ]; then
		continue
	fi
	echo "$username"
	echo "##########"

	# ta teleutaia 20 login dates
	echo "Last login date(s):"
	last -n 20 "$username" | head -n -1| awk '{print $4, $5, $6, $7}'
	echo "..."

	# ta teleutaia 20 IPs kai hostnames tous
	echo "Last login IP(s)/hostnames(s):"
	last -n 20 "$username" | awk '{print $3}' | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | while read -r ip; do
		echo "$ip"
		hostname=$(host "$ip" 2>/dev/null | awk '/domain name pointer/ {print $5}')
		if [ -n "$hostname" ]; then
			echo "$hostname"
		else
			echo "Hostname not found"
		fi
	done
	echo "..."
	echo ""
done < "$usernames_file"

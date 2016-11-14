#!/bin/bash
read -p "Enter your image path: " image
image=${image:-Disk.dmg}
echo $image
for pass in $(cat passwordlist.txt | awk '{ gsub(":", "\n") } 1')
do
	printf '%s\0' $pass | hdiutil attach $image -stdinpass
	if [[ $? = 0 ]] 
	then 
		echo "Your password is : "
		echo $pass
		exit 0
	fi
done

echo "No password found on your passwordlist dictionary!"
exit 1
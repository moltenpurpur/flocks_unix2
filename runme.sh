#!/bin/bash
make clean
make

count=10
pids=()
for (( i=0; i<$count; i++ ))
do
	./main my_file.txt &
	pids+=($!)
done

sleep 5m

completedTasks=0
for pid in ${pids[@]}
do
	kill -SIGINT $pid
	if [[ $? -eq 0 ]]
	then
		((completedTasks++))
	fi
done

touch result.txt
echo "Started tasks: " $count >> result.txt
echo "Finished tasks: " $completedTasks >> result.txt
cat stat.txt >> result.txt
rm stat.txt
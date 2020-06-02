#! /bin/bash
if [ $# -lt 1 ] # check if at least one argument is provided
then
  echo "An argument has to be provided" # if not, print this error
  exit 1 # exit with error code 1
fi
if [ ! -d $1 ] # check if the directory provided exists
then
  echo "the directory $1 does not exist" # if not, print this error
  exit 2 # exit with error code 2
fi

counter=0 # a counter to count the number of bash files
total=0 # another counter counting the number of lines matching the pattern
for i in $1/*.sh # for all the bash files
do
	if [ -e $i ] # if the file exists
		then
			cur=$(grep -cv "^\s*#\|^\s*$" $i) # count all the lines not having the following pattern: starting with any number of whitespace followed by # or a line containing only white space
			total=$((total+cur)) # increment the total number of lines
			counter=$((counter+1)) # increment the count of the number of files
			echo $(basename $i) $cur # use the command basename to get only the file name
	fi
done
if [ $counter -eq 0 ] # if there are no bash files
then
	echo "No bash files found in the given directory" # print this error
	exit 3 # exit with error code 3
fi
echo "Total of $counter files with $total lines of code"

#!/bin/sh
#--------------------------------------------
# 查看指定Topic下的数据存储条数
# author：biansutao@gmail.com
# create-date：2017-11-16
#--------------------------------------------

if [[ -z $1 ]];then
        echo "Usage: $0 topic_name"
        exit 0;
fi

str1=$(/home/hadoop/kafka/bin/kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list  10.200.10.67:9092,10.200.10.68:9092,10.200.10.69:9092 -topic $1 --time -2)

str2=$(/home/hadoop/kafka/bin/kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list  10.200.10.67:9092,10.200.10.68:9092,10.200.10.69:9092 -topic $1 --time -1)


echo '########### start position ###########'

arr1=(${str1// / })  

for i in ${arr1[@]}  
do  
    echo  $i 
done 

echo '########### end position ###########'

arr2=(${str2// / })  
  
for i in ${arr2[@]}  
do  
    echo  $i  
done 


echo "########### Topic $1 total records number  ###########"

length=${#arr2[@]}

total=0
index=0
while [ $length -ge 1 ];do 
    var1=${arr1[$index]}
    var2=${arr2[$index]}

    subarr1=(${var1//:/ })  
	subarr2=(${var2//:/ })  

    start=${subarr1[2]}
    end=${subarr2[2]}
    
   
    total=`expr $total + $end - $start`
    
	length=$(($length-1))
    index=$(($index+1))

done;
echo 'total records:' $total



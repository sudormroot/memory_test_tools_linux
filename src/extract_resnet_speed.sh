#!/bin/sh


#result_dirs_list="`echo result_dir-*`"

#sort by memsize
result_dirs_list="`echo result_dir-* | sed 's/\( \)\+/\n/g'|sort -t_ -n -k5`"

result_dirs_list="`echo $result_dirs_list`"

result_csv="result.csv"

echo "FASTMEM_SIZE_IN_MB        THP_MIGRATION   TRAINING_SPEED_AVG      TRAINING_SPEED_MAX      TRAINING_SPEED_MIN" > $result_csv

extract_data_one_dir(){
	result_dir="$1"

	training_speed_list="`cat $result_dir/applog.txt | grep examples | awk '{print $8}'|sed 's/(//g'|sed '1d'`"
	fastmem_size="`cat $result_dir/config.txt | grep FAST_MEM_SIZE|cut -d= -f2`"
	thp_migration="`cat $result_dir/config.txt | grep THP_MIGRATION|cut -d= -f2`"

	min="0"
	max="0"
	avg="0"
	sum="0"
	n="0"

	for x in $training_speed_list;do

        echo "speed=$x"

        if [ "$min" = "0" ] || [ "$min" \< "$x" ];then
                min="$x"
        fi

        if [ "$max" = "0" ] || [ "$max" \> "$x" ];then
                max="$x"
        fi

        sum="`echo $sum + $x | bc`"

        n="`expr $n + 1`"
	done

	avg="`echo $sum / $n | bc`"

	echo "thp_migration=$thp_migration, fastmem_size=$fastmem_size MB, training speed min=$min max=$max avg=$avg"
	echo "$fastmem_size \t\t\t $thp_migration \t\t $avg \t\t\t $max \t\t\t $min" >>  $result_csv
}

for dir in $result_dirs_list;do
	echo ""
	echo "dir=$dir"
	extract_data_one_dir $dir
done

echo "The result is written in \"$result_csv\":"
cat $result_csv
echo ""


#!/bin/bash
array=(1 4);
num=${#array[@]} 
for ((i=0;i<num;i++))
{
#echo ${array[$i]};
command=$(printf 'compare(%d);handle_result(%d)' ${array[$i]} ${array[$i]});
echo $command;
matlab -nodesktop -nosplash -nojvm -r $command

}&



#array=(2,4,6,8);
#num=${#array[@]}
##echo($num)
#for ((i=0;i<num;i++))
#{
#  echo($array[i])
#}
##for ((i=0;i<2;i++))
#{
#   matlab -nodesktop -nosplash -nojvm -r "compare($i);handle_result($i)" 
#}&


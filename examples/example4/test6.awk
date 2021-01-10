BEGIN{
    FS=":"
}
{
  num=num+1
  arr[0]=$1
  arr[1]=$2
  arr[3]=$3
  arr[4]=$4
  for (i in arr)
  if(arr[i]%2 ==0) {
    total[num] = total[num] + arr[i]
  }
}
END{
  for (k in total)
    printf "总数为:%-12d\n",total[k]
}

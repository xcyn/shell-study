BEGIN{
    FS=":"
    printf "%-10s%-10s%-10s%-10s%-10s\n","数学","语文","英语","物理","总计"
}
{
  total=$1+$2+$3+$4
  printf "%-12d%-12d%-12d%-12d%-12d\n",$1,$2,$3,$4,total
}
END{
}

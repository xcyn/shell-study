BEGIN{
    FS=":"
}
{
  if($3 == 03)
  {
    printf "%-20d\n",$3
  }
}

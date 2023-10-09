touch ~/.n
new=$(awk '(NR==1) { print ($1 + 1) % 6; }' ~/.n)
echo $new > ~/.n
if [ $new == 0 ]
then
  echo -e "\001\033[31m\002☺ \001\033[0m\002"
elif [ $new == 1 ]
then 
  echo -e "\001\033[33m\002☺ \001\033[0m\002"
elif [ $new == 2 ]
then
  echo -e "\001\033[32m\002☺ \001\033[0m\002"
elif [ $new == 3 ]
then
  echo -e "\001\033[36m\002☺ \001\033[0m\002"
elif [ $new == 4 ]
then
  echo -e "\001\033[34m\002☺ \001\033[0m\002"
elif [ $new == 5 ]
then
  echo -e "\001\033[35m\002☺ \001\033[0m\002"
fi

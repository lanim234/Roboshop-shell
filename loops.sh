a=10
while [ $a -gt 0 ]; do
  echo Hello World
  a=$(($a-1))
  sleep 1
  done


for master in catalogue cart Redis Shipping MongDB Payment; do
  echo creating master - $master
  sleep 1
done
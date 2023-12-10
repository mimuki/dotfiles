touch ~/Projects/sw/.count
new=$(awk '(NR==1) { print ($1 + 1) % 60; }' ~/Projects/sw/.count)
echo $new > ~/Projects/sw/.count
if [[ $new == 0 ]]
then
  cd ~/Projects/sw
  .venv/bin/python3.11 sw f tmux > ~/Projects/sw/.front
fi
cat ~/Projects/sw/.front

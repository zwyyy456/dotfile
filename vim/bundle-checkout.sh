find . -maxdepth 1 -type d -exec git -C {} reset --hard HEAD \;

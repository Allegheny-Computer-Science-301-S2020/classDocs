
echo  -*- This is an r programming interactive interpreter
echo
echo  -*- Please do not run this in your classDocs
echo  repository because it will save history files
echo  that will interfer when you pull
echo  -*-
sudo docker run -ti --rm -v "$PWD":/home/docker -w /home/docker -u docker r-base
echo
echo -*- All closed down

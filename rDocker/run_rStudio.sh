
echo  -*- This is an rStudio client for your browser
echo
echo  -*- Please do not run this in your classDocs
echo  repository because it will make a directory
echo  "kitematic/" that will interfer when you pull
echo  over your updates
echo  -*-
echo  -*- Use Browser address: http://localhost:8787/
echo  -*- Set password is 'letmein'
echo  -*-
echo  -*- Type Control-C to quit and exit this client
sudo docker run --rm -e PASSWORD=letmein -p 8787:8787 -v $PWD:/home/rstudio/ rocker/verse
echo
# echo -*- Removing kitematic/
# mv sudo rm kitematic
echo -*- All closed down

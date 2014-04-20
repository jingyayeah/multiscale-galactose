# copies the sbml to the different computers to perform simulations
# TODO: make more general

mkdir ~/multiscale-galactose-results/2014-04-20  
cd ~/multiscale-galactose-results/2014-04-20
echo
echo "*** 10.39.32.106 ***"
scp mkoenig@10.39.32.106:~/multiscale-galactose-results/django/timecourse/2014-04-20/*.* .

echo
echo "*** 10.39.32.189 ***"
scp mkoenig@10.39.32.189:~/multiscale-galactose-results/django/timecourse/2014-04-20/*.* .


echo
echo "*** 10.39.34.27 ***"
scp mkoenig@10.39.34.27:~/multiscale-galactose-results/django/timecourse/2014-04-20/*.* .




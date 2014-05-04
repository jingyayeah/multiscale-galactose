# copies the sbml to the different computers to perform simulations
# TODO: make more general

DATE=2014-05-05

mkdir ~/multiscale-galactose-results/$DATE  
cd ~/multiscale-galactose-results/$DATE
echo
echo "*** 10.39.32.106 ***"
scp mkoenig@10.39.32.106:~/multiscale-galactose-results/django/timecourse/$DATE/*.* .

echo
echo "*** 10.39.32.189 ***"
scp mkoenig@10.39.32.189:~/multiscale-galactose-results/django/timecourse/$DATE/*.* .


echo
echo "*** 10.39.34.27 ***"
scp mkoenig@10.39.34.27:~/multiscale-galactose-results/django/timecourse/$DATE/*.* .




# copies the sbml to the different computers to perform simulations

echo
echo "*** 10.39.32.111 ***"
scp -r ~/multiscale-galactose-results/django/sbml mkoenig@10.39.32.111:~/multiscale-galactose-results/django/

echo
echo "*** 10.39.32.106 ***"
scp -r ~/multiscale-galactose-results/django/sbml mkoenig@10.39.32.106:~/multiscale-galactose-results/django/

echo
echo "*** 10.39.32.189 ***"
scp -r ~/multiscale-galactose-results/django/sbml mkoenig@10.39.32.189:~/multiscale-galactose-results/django/

echo
echo "*** 10.39.34.27 ***"
scp -r ~/multiscale-galactose-results/django/sbml mkoenig@10.39.34.27:~/multiscale-galactose-results/django/



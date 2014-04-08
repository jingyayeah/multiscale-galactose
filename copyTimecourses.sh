# copy the resulting timecourses to 10.39.32.111

echo
echo "*** 10.39.32.111 ***" 
# from -> to
# scp -r mkoenig@10.39.32.106:~/multiscale-galactose-results/django/timecourse ~/multiscale-galactose-results/django/

echo "*** 10.39.32.189 ***"
scp -r mkoenig@10.39.32.189:~/multiscale-galactose-results/django/timecourse ~/multiscale-galactose-results/django/

echo "*** 10.39.34.27 ***"
scp -r mkoenig@10.39.34.27:~/multiscale-galactose-results/django/timecourse ~/multiscale-galactose-results/django/


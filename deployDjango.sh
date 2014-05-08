# For the deployment of django it is necessary

## LOCAL PREPARATION ##
# [1] do a local database dump & put database on the production server
# As long as the database is not too large this can be done via the git management
# stored in /multiscale-galactose/database/
# TODO: a dump script for the database
pg_dumb
git push the changes

# [2] tar all the media files to locate them on the server
tar  /multiscale-galactose-results/django
scp tar to production server


## PRODUCTION SERVER ##
MYHOME="/home/mkoenig/"
PROJECT="${MYHOME}/multiscale-galactose/"
MYSITE="${PROJECT}/python/mysite/"

MEDIA_DIR="${MYHOME}/multiscale-galactose-results/django/"
STATIC_DIR="/var/www/multiscale-galactose/static/"

# [1] get the latest sources on the production server
# The settings file which is pulled is always the settings file for the 
# local setup of the server, so it is necessary to change the debug settings & the database settings (see below)
ssh root@hitssv505
cd ${PROJECT}
git pull


# [2] put the latest database dump on the production server database
# /multiscale-galactose/database/?
TODO

# [3] Collect the static files on the production server
rm -rf STATIC_DIR
mkdir STATIC_DIR
chown -R mkoenig:mkoenig STATIC_DIR
cd ${MYSITE}
python manage.py collectstatic

# [4] Update the media
# extract the media tar in the proper location 
tar xzvf media 

# [5] Change the project settings to deployment
# TODO generate the deployment settings
cp ${MYSITE}/settings_deployment.py ${MYSITE}/settings.py


# [5] restart apache2 to be sure
service apache2 restart



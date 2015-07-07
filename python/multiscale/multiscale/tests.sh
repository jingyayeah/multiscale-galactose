clear
# run the classical unittests
python -m unittest discover -s . -p 'test_*.py'

echo "---------------------------------------------"
# run the django database unittests
# The -Wall flag tells Python to display deprecation warnings.
# python -Wall manage.py test
python multiscale/multiscalesite/manage.py test

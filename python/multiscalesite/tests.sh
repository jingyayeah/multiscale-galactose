clear
# run the classical unittests
python -m unittest discover -s . -p '*_test.py'

echo "---------------------------------------------"
# run the django database unittests
python manage.py test

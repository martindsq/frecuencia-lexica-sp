Activate the [virtual environment](https://docs.python.org/3/library/venv.html):

```
source .venv/bin/activate
```

Install the dependencies:

```
python -m pip install -r requirements.txt
```

Create the database:

```
createdb martin		# Only necessary if martin doesn't exist yet
sudo -u martin psql
CREATE DATABASE frecuencialexicasp WITH OWNER martin;
```


```
python manage.py migrate
python manage.py createsuperuser
python manage.py seed --mode=refresh
python manage.py runserver
```


If something doesn't work consider:

```
sudo apt install python3-pip
sudo apt install python3-venv
```
# Subjective lexical frequency in Rioplatense Spanish

## Running the experiment

1. Activate the [virtual environment](https://docs.python.org/3/library/venv.html)

```
source .venv/bin/activate
```

2. Install the dependencies

```
python -m pip install -r requirements.txt
```

3. Create the database in Postgres

```
createdb martin		# Only necessary if martin doesn't exist yet
sudo -u martin psql
CREATE DATABASE frecuencialexicasp WITH OWNER martin;
```

4. Fill the database:

```
python manage.py migrate
python manage.py createsuperuser
python manage.py seed
```

5. Run the server

```
python manage.py runserver
```

## Re-generating the stimuli

1. Place the stimuli in the static folder:

```
Rscript stimuli/clip.R
```

2. Update the database

```
python manage.py seed
```
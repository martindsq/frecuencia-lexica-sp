# Subjective lexical frequency in Rioplatense Spanish

## Running the experiment

1. Install the [package installer](https://pypi.org/project/pip/) and the [virtual environment module](https://docs.python.org/3/library/venv.html)

```
sudo apt install python3-pip
sudo apt install python3-venv
```

2. Create and activate the virtual environment

```
python3 -m venv .venv
source .venv/bin/activate
```

2. Install the dependencies

```
python -m pip install -r requirements.txt
```

3. Install [Postgres](https://www.postgresql.org/) and create the database:

```
sudo apt install postgresql
createdb martin		# Only necessary if martin doesn't exist yet
sudo -u martin psql
CREATE DATABASE frecuencialexicasp WITH OWNER martin;
```

4. Fill the database

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

1. Install the [image manipulation software suite](https://imagemagick.org/)

```
sudo apt install imagemagick
```

2. Place the stimuli in the static folder

```
Rscript stimuli/clip.R
```

3. Update the database

```
python manage.py seed
```
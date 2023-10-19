Run

`
sudo apt install python3-pip
sudo apt install python3-venv
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install -r requirements.txt

CREATE DATABASE frecuencialexicasp WITH OWNER martin;
python manage.py migrate
python manage.py createsuperuser
python manage.py seed --mode=refresh
python manage.py runserver
`

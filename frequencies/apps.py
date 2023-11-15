from django.apps import AppConfig
from .options import ExperimentOptions

class FrequenciesConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'frequencies'
    options = ExperimentOptions()
from django.contrib import admin
from .models import Stimulus, Form

@admin.register(Stimulus)
class StimulusAdmin(admin.ModelAdmin):
    list_display = ('term', 'file_name')
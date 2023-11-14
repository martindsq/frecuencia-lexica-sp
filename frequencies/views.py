from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_protect
from django.templatetags.static import static
from rest_framework.viewsets import ModelViewSet
from .models import Form, Stimulus, experiment
from .serializers import FormAndRepliesSerializer, StimulusSerializer
from .permissions import IsAdminOrWriteOnly

class FormViewSet(ModelViewSet):
    queryset = Form.objects.all()
    serializer_class = FormAndRepliesSerializer
    permission_classes = [IsAdminOrWriteOnly]

class StimulusViewSet(ModelViewSet):
    queryset = Stimulus.objects.all()
    serializer_class = StimulusSerializer

@csrf_protect
def index(request):
	try:
		mode = Form.Mode(int(request.GET.get('mode', 1)))
	except ValueError:
		mode = Form.Mode.ONLINE
	
	template = loader.get_template('index.html')
	context = {
    	'survey_steps': [
    		{
    			'label': '¿En qué año naciste?',
    			'hint': 'birthdate',
    			'type': 'select',
    			'required': True,
    			'options': reversed(range(1900, 2023))
    		},
    		{
    			'label': '¿Con qué género te identificas mejor?',
    			'hint': 'sex',
    			'type': 'radio',
    			'required': True,
    			'options': Form.Sex.choices
    		},
    		{
    			'label': '¿Cuál es nivel de estudios más alto que terminaste?',
    			'hint': 'education',
    			'type': 'radio',
    			'required': True,
    			'options': Form.Education.choices
    		},
    		{
    			'label': '¿Cuál es tu lengua nativa?',
    			'hint': 'preferred_language',
    			'type': 'radio',
    			'required': True,
    			'options': Form.PreferredLanguage.choices
    		}
    	],
    	'stimuli': {static('terms/' + stimulus.file_name): stimulus.file_name for stimulus in Stimulus.objects.all()
    	},
    	'mode': mode,
    	'modes': Form.Mode,
    	'timeout': 1 if mode == Form.Mode.DEBUG else experiment.timeout,
    	'sample_size': 3 if mode == Form.Mode.DEBUG else experiment.sample_size
	}
	return HttpResponse(template.render(context, request))
from dbsettings import Group, PositiveIntegerValue

class ExperimentOptions(Group):
	timeout = PositiveIntegerValue(default = 20, help_text="En minutos")
	sample_size = PositiveIntegerValue(default = 180)
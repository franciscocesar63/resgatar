from django.urls import path
from .views import AlunoView

urlpatterns = [
	path('', AlunoView.as_view(), name = 'aluno'),
]
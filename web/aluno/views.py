from django.views.generic.base import TemplateView
from .utils import pegar_todos_alunos


class AlunoView(TemplateView):
    template_name = "aluno/aluno_view.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        content = pegar_todos_alunos()
        context["content"] = content
        return context

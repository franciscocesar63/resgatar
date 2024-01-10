import '../view/cadastrar_aluno_view.dart';

import '../view/home_page.dart';
import '../view/lista_alunos_matriculados_view.dart';

class Routes {
  static var routes = {
    '/': (context) => const HomePage(title: 'Resgatar Sousa App'),
    '/lista_alunos_matriculados_view': (context) => ListaAlunosMatriculadosView(),
    '/cadastrar_aluno_view': (context) => CadastrarAlunoView(),
  };
}

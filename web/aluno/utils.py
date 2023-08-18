import requests


def pegar_todos_alunos():
	url_base = "https://api.resgatarsousa.com.br/getAlunos.php"
	request = requests.get(url_base)
	if request.status_code == 200:
		alunos = {"alunos": request.json()}
		return alunos
	return {"error": "Erro ao tentar pegar os alunos"}
<?php

header('Access-Control-Allow-Origin: *');
include_once './DBConnection.php';
$authorizationHeader = $_SERVER['HTTP_AUTHORIZATION'] ?? null;

if ($authorizationHeader && preg_match('/Bearer\s+(.*)/', $authorizationHeader, $matches)) {
    $token = $matches[1]; // Extrai o token do cabeçalho

    // Verifique aqui o token de autorização (por exemplo, usando JWT ou chaves de API)
    $isValidToken = validarToken($token, $AUTH);

    if (!$isValidToken) {
        http_response_code(401); // Unauthorized
        echo json_encode(array('error' => 'Acesso não autorizado.'));
        return;
    }



    if (
        isset($_POST['IDALUNO']) && isset($_POST['NOME']) && isset($_POST['DATANASCIMENTO']) && isset($_POST['IDADE']) &&
        isset($_POST['ESCOLARIDADE']) && isset($_POST['NOMEESCOLA']) && isset($_POST['HORARIOESTUDA']) &&
        isset($_POST['NOMERESPONSAVEL']) && isset($_POST['TELEFONERESPONSAVEL']) && isset($_POST['FOTO']) &&
        isset($_POST['RUA']) && isset($_POST['BAIRRO']) && isset($_POST['CEP']) &&
        isset($_POST['CIDADE']) && isset($_POST['ESTADO']) && isset($_POST['PAIS']) && isset($_POST['ISVISITANTE'])


    ) {
        $formData = array(
            'IDALUNO' => isset($_POST['IDALUNO']),
            'NOME' => isset($_POST['NOME']),
            'DATANASCIMENTO' => isset($_POST['DATANASCIMENTO']),
            'IDADE' => isset($_POST['IDADE']),
            'ESCOLARIDADE' => isset($_POST['ESCOLARIDADE']),
            'NOMEESCOLA' => isset($_POST['NOMEESCOLA']),
            'HORARIOESTUDA' => isset($_POST['HORARIOESTUDA']),
            'NOMERESPONSAVEL' => isset($_POST['NOMERESPONSAVEL']),
            'TELEFONERESPONSAVEL' => isset($_POST['TELEFONERESPONSAVEL']),
            'FOTO' => isset($_POST['FOTO']),
            'RUA' => isset($_POST['RUA']),
            'BAIRRO' => isset($_POST['BAIRRO']),
            'CEP' => isset($_POST['CEP']),
            'CIDADE' => isset($_POST['CIDADE']),
            'ESTADO' => isset($_POST['ESTADO']),
            'PAIS' => isset($_POST['PAIS']),
            'ISVISITANTE' => isset($_POST['ISVISITANTE'])
        );
    }

    $db = new DBConnection();
    $result = $db->updateAluno($formData);

    if ($result) {
        echo json_encode($result);
    } else {
        http_response_code(400); // Set HTTP status code to 400
        echo json_encode(array('error' => 'Erro ao atualizar Aluno - Cod: ' + $_POST['idaluno']));
    }

} else {
    http_response_code(401); // Unauthorized
    echo json_encode(array('error' => 'Cabeçalho de autorização ausente ou inválido.'));
}


function validarToken($token, $auth)
{
    if ($token == $auth) {
        return true;
    }
    return false;
}
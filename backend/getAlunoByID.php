<?php

header('Access-Control-Allow-Origin: *');
include_once './DBConnection.php';


$authorizationHeader = $_SERVER['HTTP_AUTHORIZATION'] ?? null;

if ($authorizationHeader && preg_match('/Bearer\s+(.*)/', $authorizationHeader, $matches)) {
    $token = $matches[1]; // Extrai o token do cabeçalho

    // Verifique aqui o token de autorização (por exemplo, usando JWT ou chaves de API)
    $isValidToken = validarToken($token, $AUTH);

    if ($isValidToken) {
        if (isset($_POST['id'])) {
            $id = $_POST['id'];
        }
        $db = new DBConnection();
        $result = $db->selectAlunosByID($id);

        if ($result) {
            echo json_encode($result);
        } else {
            http_response_code(400); // Set HTTP status code to 400
            echo json_encode(array('error' => 'Aluno não encontrado'));
        }
    } else {
        http_response_code(401); // Unauthorized
        echo json_encode(array('error' => 'Acesso não autorizado.'));

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
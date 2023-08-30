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

    $data = json_decode(file_get_contents('php://input'), true);

    if (
        isset($data['IDALUNO']) && isset($data['NOME']) && isset($data['DATANASCIMENTO']) && isset($data['IDADE']) &&
        isset($data['ESCOLARIDADE']) && isset($data['NOMEESCOLA']) && isset($data['HORARIOESTUDA']) &&
        isset($data['NOMERESPONSAVEL']) && isset($data['TELEFONERESPONSAVEL']) && isset($data['FOTO']) &&
        isset($data['RUA']) && isset($data['BAIRRO']) && isset($data['CEP']) &&
        isset($data['CIDADE']) && isset($data['ESTADO']) && isset($data['PAIS']) && isset($data['ISVISITANTE'])


    ) {
        $formData = array(
            'IDALUNO' => isset($data['IDALUNO']),
            'NOME' => isset($data['NOME']),
            'DATANASCIMENTO' => isset($data['DATANASCIMENTO']),
            'IDADE' => isset($data['IDADE']),
            'ESCOLARIDADE' => isset($data['ESCOLARIDADE']),
            'NOMEESCOLA' => isset($data['NOMEESCOLA']),
            'HORARIOESTUDA' => isset($data['HORARIOESTUDA']),
            'NOMERESPONSAVEL' => isset($data['NOMERESPONSAVEL']),
            'TELEFONERESPONSAVEL' => isset($data['TELEFONERESPONSAVEL']),
            'FOTO' => isset($data['FOTO']),
            'RUA' => isset($data['RUA']),
            'BAIRRO' => isset($data['BAIRRO']),
            'CEP' => isset($data['CEP']),
            'CIDADE' => isset($data['CIDADE']),
            'ESTADO' => isset($data['ESTADO']),
            'PAIS' => isset($data['PAIS']),
            'ISVISITANTE' => isset($data['ISVISITANTE'])
        );
    } else {
        $missingIndexes = findMissingIndexes($data);
        http_response_code(400); // Unauthorized
        echo json_encode(array('error' => 'Campos faltando!', 'campos' => implode(', ', $missingIndexes)));
        return;
    }

    $db = new DBConnection();
    $result = $db->updateAluno($formData);

    if ($result) {
        echo json_encode($result);
    } else {
        http_response_code(400); // Set HTTP status code to 400
        echo json_encode(array('error' => 'Erro ao atualizar Aluno - Cod: ' + $data['IDALUNO']));
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

function findMissingIndexes($data)
{
    $missingIndexes = [];

    $requiredIndexes = [
        'IDALUNO',
        'NOME',
        'DATANASCIMENTO',
        'IDADE',
        'ESCOLARIDADE',
        'NOMEESCOLA',
        'HORARIOESTUDA',
        'NOMERESPONSAVEL',
        'TELEFONERESPONSAVEL',
        'FOTO',
        'RUA',
        'BAIRRO',
        'CEP',
        'CIDADE',
        'ESTADO',
        'PAIS',
        'ISVISITANTE'
    ];

    foreach ($requiredIndexes as $index) {
        if (!isset($data[$index])) {
            $missingIndexes[] = $index;
        }
    }

    return $missingIndexes;
}
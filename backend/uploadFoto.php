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

    // Obter dados do arquivo enviado
    // $fileData = file_get_contents('php://input');
    $data = json_decode(file_get_contents('php://input'), true);

    // Verificar se os bytes do arquivo foram recebidos
    if (isset($data['arquivo']) && isset($data['extensao'])) {
        $fileData = base64_decode($data['arquivo']);
        $extensao = $data['extensao'];
        // Nome do arquivo (pode ser gerado aleatoriamente ou baseado em alguma lógica específica)
        $fileName = 'arquivo_' . uniqid() . '.' . $extensao;

        // Caminho para a pasta de destino
        $destinationFolder = 'uploads/';

        // Caminho completo do arquivo no servidor
        $filePath = $destinationFolder . $fileName;

        // Salvar os bytes do arquivo no servidor
        $saveResult = file_put_contents($filePath, $fileData);

        if ($saveResult !== false) {
            echo json_encode(array('success' => 'Arquivo salvo com sucesso.', 'filePath' => $filePath));
        } else {
            http_response_code(500); // Internal Server Error
            echo json_encode(array('error' => 'Erro ao salvar o arquivo no servidor.'));
        }
    } else {
        http_response_code(400); // Bad Request
        echo json_encode(array('error' => 'Dados do arquivo ausentes.'));
    }

} else {
    http_response_code(401); // Unauthorized
    echo json_encode(array('error' => 'Cabeçalho de autorização ausente ou inválido.'));
}

function validarToken($token, $auth)
{
    return $token == $auth;
}

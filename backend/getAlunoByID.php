<?php

header('Access-Control-Allow-Origin: *');
include_once './DBConnection.php';

if (!isset($_POST['auth'])) {
    http_response_code(400); // Set HTTP status code to 400
    echo json_encode(array('error' => 'Token autenticador não definido'));
    return;
}
if ($_POST['auth'] != $AUTH) {
    http_response_code(400); // Set HTTP status code to 400
    echo json_encode(array('error' => 'Token autenticador inválido'));
    return;
}


if (isset($_POST['id'])) {
    $id = $_POST['id'];
}

$db = new DBConnection();
$result = $db->selectAlunosByID($id);

if ($result) {
    echo json_encode($result);
}else{
    http_response_code(400); // Set HTTP status code to 400
    echo json_encode(array('error' => 'Aluno não encontrado'));
}
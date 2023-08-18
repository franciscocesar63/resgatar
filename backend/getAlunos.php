<?php

header('Access-Control-Allow-Origin: *');
include_once './DBConnection.php';
if (!isset($_POST['auth'])) {
    http_response_code(400); // Set HTTP status code to 400
    echo json_encode(array('error' => 'Token autenticador não definido'));
} else {
    if ($_POST['auth'] == $AUTH) {
        $db = new DBConnection();
        echo json_encode($db->selectAlunos());
    } else {
        http_response_code(400); // Set HTTP status code to 400
        echo json_encode(array('error' => 'Token autenticador inválido'));

    }
}
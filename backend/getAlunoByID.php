<?php

header('Access-Control-Allow-Origin: *');
include_once './DBConnection.php';

if (isset($_POST['id'])) {
    $id = $_POST['id'];
}

$db = new DBConnection();

echo json_encode($db->selectAlunosByID($id));

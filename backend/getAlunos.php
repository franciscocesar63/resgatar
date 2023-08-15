<?php

header('Access-Control-Allow-Origin: *');
include_once './DBConnection.php';




$db = new DBConnection();
echo json_encode($db->selectAlunos());

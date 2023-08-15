<?php

header('Access-Control-Allow-Origin: *');
include_once './DBConnection.php';


/**
 * 
 * IDALUNO INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(200) NOT NULL,
    DATANASCIMENTO DATE,
    IDADE INT,
    ESCOLARIDADE VARCHAR(20),
    NOMEESCOLA VARCHAR(50),
    HORARIOESTUDA VARCHAR(10),
    NOMERESPONSAVEL VARCHAR(100),
    TELEFONERESPONSAVEL VARCHAR(15),
    INSTAGRAMRESPONSAVEL VARCHAR(50),
    FOTO TEXT,
    RUA VARCHAR(200),
    BAIRRO VARCHAR(200),
    CEP VARCHAR(9),
    CIDADE VARCHAR(200),
    ESTADO VARCHAR(200),
    ISVISITANTE TINYINT,
    PAIS VARCHAR(200)
 */

if (
    isset($_POST['NOME']) && isset($_POST['DATANASCIMENTO']) && isset($_POST['IDADE']) &&
    isset($_POST['ESCOLARIDADE']) && isset($_POST['NOMEESCOLA']) && isset($_POST['HORARIOESTUDA']) &&
    isset($_POST['NOMERESPONSAVEL']) && isset($_POST['TELEFONERESPONSAVEL']) && isset($_POST['FOTO']) &&
    isset($_POST['RUA']) && isset($_POST['BAIRRO']) && isset($_POST['CEP']) &&
    isset($_POST['CIDADE']) && isset($_POST['ESTADO']) && isset($_POST['PAIS']) && isset($_POST['ISVISITANTE']) 


) {
    $formData = array(
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

echo json_encode($db->updateAluno($formData));

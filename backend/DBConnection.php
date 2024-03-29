<?php
// ini_set('display_errors', 1);
// ini_set('display_startup_erros', 1);
// error_reporting(E_ALL);
require_once 'config.php';
class DBConnection
{
    private $_con;
    public function __construct()
    {
        global $DB_HOST, $DB_NAME, $DB_USER, $DB_PASS;
        try {
            $this->_con = new PDO("mysql:host=$DB_HOST;dbname=$DB_NAME", $DB_USER, $DB_PASS);
            $this->_con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            // echo "Conectado com sucesso.";
        } catch (PDOException $e) {
            echo "<h1>Ops, algo deu errado: " . $e->getMessage() . "</h1>";
            // echo "<pre>";
            echo print_r($e);
        }
    }
    // return Connection
    public function returnConnection()
    {
        return $this->_con;
    }


    public function insertAluno($formData)
    {
        try {
            $pdo = $this->returnConnection();
            $stmt = $pdo->prepare('INSERT INTO `ALUNO`(`idaluno`, `idturma`, `nome`, `datanascimento`, `idade`, `escolaridade`, `nomeescola`, `horarioestuda`, `nomeresponsavel`, `telefoneresponsavel`, `foto`, `rua`, `bairro`, `cep`, `cidade`, `estado`, `pais`, `isvisitante`, `datahora`) VALUES
        (null, :idturma, :nome, :datanascimento, :idade, :escolaridade, :nomeescola, :horarioestuda, :nomeresponsavel, :telefoneresponsavel, :foto, :rua, :bairro, :cep, :cidade, :estado, :pais, :isvisitante, :datahora)');

            $stmt->execute(
                array(
                    ':idturma' => $formData['IDTURMA'],
                    ':nome' => $formData['NOME'],
                    ':datanascimento' => $formData['DATANASCIMENTO'],
                    ':idade' => $formData['IDADE'],
                    ':escolaridade' => $formData['ESCOLARIDADE'],
                    ':nomeescola' => $formData['NOMEESCOLA'],
                    ':horarioestuda' => $formData['HORARIOESTUDA'],
                    ':nomeresponsavel' => $formData['NOMERESPONSAVEL'],
                    ':telefoneresponsavel' => $formData['TELEFONERESPONSAVEL'],
                    ':foto' => $formData['FOTO'],
                    ':rua' => $formData['RUA'],
                    ':bairro' => $formData['BAIRRO'],
                    ':cep' => $formData['CEP'],
                    ':cidade' => $formData['CIDADE'],
                    ':estado' => $formData['ESTADO'],
                    ':pais' => $formData['PAIS'],
                    ':isvisitante' => $formData['ISVISITANTE'],
                    ':datahora' => date('Y-m-d H:i:s')
                )
            );

            if ($stmt->rowCount() > 0) {
                return ['status' => "success"];
            } else {
                return ['error' => 'Houve um erro ao inserir aluno no banco'];
            }
        } catch (\Throwable $th) {
            return ['error' => 'Houve um erro ao inserir aluno no banco', 'exception' => $th];
        }
    }

    public function selectAlunos()
    {
        $pdo = $this->returnConnection();
        $stmt = $pdo->query("SELECT * FROM ALUNO");

        $user = $stmt->fetchAll(PDO::FETCH_ASSOC);
        return $user;
    }

    public function selectAlunosByID($id)
    {
        $pdo = $this->returnConnection();
        $stmt = $pdo->query("SELECT * FROM ALUNO WHERE idaluno ='" . $id . "'");
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        return $user;
    }

    public function updateAluno($formData)
    {
        try {
            $pdo = $this->returnConnection();
            $stmt = $pdo->prepare('UPDATE `ALUNO` SET
            `nome` = :nome,
            `datanascimento` = :datanascimento,
            `idade` = :idade,
            `escolaridade` = :escolaridade,
            `nomeescola` = :nomeescola,
            `horarioestuda` = :horarioestuda,
            `nomeresponsavel` = :nomeresponsavel,
            `telefoneresponsavel` = :telefoneresponsavel,
            `foto` = :foto,
            `rua` = :rua,
            `bairro` = :bairro,
            `cep` = :cep,
            `cidade` = :cidade,
            `estado` = :estado,
            `pais` = :pais,
            `isvisitante` = :isvisitante,
            `datahora` = :datahora
            WHERE `idaluno` = :idaluno');

            $stmt->execute(
                array(
                    ':idaluno' => $formData['IDALUNO'],
                    // Assuming you have an 'ID' field in your form data
                    ':nome' => $formData['NOME'],
                    ':datanascimento' => $formData['DATANASCIMENTO'],
                    ':idade' => $formData['IDADE'],
                    ':escolaridade' => $formData['ESCOLARIDADE'],
                    ':nomeescola' => $formData['NOMEESCOLA'],
                    ':horarioestuda' => $formData['HORARIOESTUDA'],
                    ':nomeresponsavel' => $formData['NOMERESPONSAVEL'],
                    ':telefoneresponsavel' => $formData['TELEFONERESPONSAVEL'],
                    ':foto' => $formData['FOTO'],
                    ':rua' => $formData['RUA'],
                    ':bairro' => $formData['BAIRRO'],
                    ':cep' => $formData['CEP'],
                    ':cidade' => $formData['CIDADE'],
                    ':estado' => $formData['ESTADO'],
                    ':pais' => $formData['PAIS'],
                    ':isvisitante' => $formData['ISVISITANTE'],
                    ':datahora' => date('Y-m-d H:i:s') // Current date and time
                )
            );

            if ($stmt->rowCount() > 0) {
                return ['status' => "success"];
            } else {
                return ['error' => "Houve algum erro ao realizar update do Aluno"];
            }
        } catch (\Throwable $th) {
            return ['error' => 'Houve um erro ao realizar update aluno no banco', 'exception' => $th];
        }
    }


    public function selectTurmas()
    {
        $pdo = $this->returnConnection();
        $stmt = $pdo->query("SELECT * FROM TURMA");

        $user = $stmt->fetchAll(PDO::FETCH_ASSOC);
        return $user;
    }
}
?>
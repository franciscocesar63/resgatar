use u860166086_resgatar;

CREATE TABLE IF NOT EXISTS ALUNO (
IDALUNO INT PRIMARY KEY AUTO_INCREMENT,
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
PAIS VARCHAR(200),
DATAHORA DATE
);

CREATE TABLE IF NOT EXISTS FREQUENCIA(
IDFREQUENCIA INT PRIMARY KEY AUTO_INCREMENT,
IDALUNO INT NOT NULL,
ISPRESENTE TINYINT NOT NULL, -- 0|1 - 0 N�O - 1 SIM
HASVISITANTE TINYINT NOT NULL, -- 0|1 - 0 N�O - 1 SIM
HASVERSICULO TINYINT NOT NULL, -- 0|1 - 0 N�O - 1 SIM
FOREIGN KEY (IDALUNO) REFERENCES ALUNO(IDALUNO)
);




INSERT INTO `ALUNO` (
    `nome`, `datanascimento`, `idade`, `escolaridade`, `nomeescola`, `horarioestuda`, 
    `nomeresponsavel`, `telefoneresponsavel`, `foto`, `rua`, `bairro`, `cep`, `cidade`, 
    `estado`, `pais`, `isvisitante`, `datahora`
) VALUES (
     'John Doe', '1995-08-14', 28, 'High School', 'Sample School', 'Morning', 
    'Jane Doe', '123-456-7890', 'john_doe.jpg', '123 Main Street', 'Downtown', '12345', 
    'Sampleville', 'CA', 'United States', 0, NOW()
);


SELECT * from ALUNO;






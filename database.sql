CREATE DATABASE IF NOT EXISTS clinica_facil;
USE clinica_facil;

CREATE TABLE clinica (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) NOT NULL UNIQUE,
    endereco VARCHAR(200) NOT NULL,
    telefone VARCHAR(20) NOT NULL
);

CREATE TABLE pessoa (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    endereco VARCHAR(200) NOT NULL
);

CREATE TABLE paciente (
    id INT PRIMARY KEY,
    data_nascimento DATE NOT NULL,
    convenio VARCHAR(80),
    numero_carteira VARCHAR(40) UNIQUE,
    clinica_id INT NOT NULL,
    FOREIGN KEY (id) REFERENCES pessoa(id),
    FOREIGN KEY (clinica_id) REFERENCES clinica(id)
);

CREATE TABLE medico (
    id INT PRIMARY KEY,
    crm VARCHAR(20) NOT NULL UNIQUE,
    FOREIGN KEY (id) REFERENCES pessoa(id)
);

CREATE TABLE recepcionista (
    id INT PRIMARY KEY,
    matricula VARCHAR(20) NOT NULL UNIQUE,
    turno VARCHAR(20) NOT NULL DEFAULT 'Manhã',
    clinica_id INT NOT NULL,
    FOREIGN KEY (id) REFERENCES pessoa(id),
    FOREIGN KEY (clinica_id) REFERENCES clinica(id),
    CHECK (turno IN ('Manhã', 'Tarde', 'Noite'))
);

CREATE TABLE especialidade (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao VARCHAR(255) NOT NULL
);

CREATE TABLE consulta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data DATE NOT NULL,
    horario TIME NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Agendada',
    observacoes VARCHAR(255),
    paciente_id INT NOT NULL,
    medico_id INT NOT NULL,
    clinica_id INT NOT NULL,
    FOREIGN KEY (paciente_id) REFERENCES paciente(id),
    FOREIGN KEY (medico_id) REFERENCES medico(id),
    FOREIGN KEY (clinica_id) REFERENCES clinica(id),
    CHECK (status IN ('Agendada', 'Realizada', 'Cancelada'))
);

CREATE TABLE atendimento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data DATE NOT NULL,
    diagnostico VARCHAR(255) NOT NULL,
    prescricoes VARCHAR(255),
    observacoes VARCHAR(255),
    consulta_id INT NOT NULL UNIQUE,
    clinica_id INT NOT NULL,
    FOREIGN KEY (consulta_id) REFERENCES consulta(id),
    FOREIGN KEY (clinica_id) REFERENCES clinica(id)
);

CREATE TABLE recepcionista_especialidade (
    recepcionista_id INT NOT NULL,
    especialidade_id INT NOT NULL,
    PRIMARY KEY (recepcionista_id, especialidade_id),
    FOREIGN KEY (recepcionista_id) REFERENCES recepcionista(id),
    FOREIGN KEY (especialidade_id) REFERENCES especialidade(id)
);

CREATE TABLE atendimento_especialidade (
    atendimento_id INT NOT NULL,
    especialidade_id INT NOT NULL,
    PRIMARY KEY (atendimento_id, especialidade_id),
    FOREIGN KEY (atendimento_id) REFERENCES atendimento(id),
    FOREIGN KEY (especialidade_id) REFERENCES especialidade(id)
);
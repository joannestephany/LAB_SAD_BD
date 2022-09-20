CREATE DATABASE bd_trigger01
use bd_trigger01

CREATE TABLE TB_ALUNO (
    MATRICULA INT NOT NULL PRIMARY KEY,
    NOME VARCHAR(50) NOT NULL,
    RG INT NULL,
    ENDERECO VARCHAR(100) NULL,
    TELEFONE VARCHAR (20) NULL,
)

CREATE TABLE TB_LOG_PENDENCIAS (
  MATRICULA INT,
  NOME VARCHAR(50),
  PENDENCIA VARCHAR(200)
)

-- Quest�o 01 (Cursores) --
CREATE OR ALTER TRIGGER TG_ALUNO_INSERT
ON TB_ALUNO
AFTER INSERT 
AS 
BEGIN 
	DECLARE @MATRICULA INT,
	        @NOME VARCHAR(50),
	        @RG VARCHAR(60),
	        @ENDERECO VARCHAR(10),
	        @TELEFONE VARCHAR(10)

	DECLARE C_ALUNO CURSOR FOR SELECT MATRICULA, NOME, RG, ENDERECO, TELEFONE
	                           FROM INSERTED 
	OPEN C_ALUNO
	FETCH C_ALUNO INTO @MATRICULA, @NOME, @RG, @ENDERECO, @TELEFONE
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		IF (@RG IS NULL)
		   INSERT INTO TB_LOG_PENDENCIAS VALUES (@MATRICULA, @NOME, 'FALTA RG')
		IF (@ENDERECO IS NULL)
		   INSERT INTO TB_LOG_PENDENCIAS VALUES (@MATRICULA, @NOME , 'FALTA ENDERECO')
		IF (@TELEFONE IS NULL)
		   INSERT INTO TB_LOG_PENDENCIAS VALUES (@MATRICULA, @NOME , 'FALTA TELEFONE')
		FETCH C_ALUNO INTO @MATRICULA, @NOME, @RG, @ENDERECO, @TELEFONE
	END
	CLOSE C_ALUNO
	DEALLOCATE C_ALUNO
END


INSERT INTO TB_ALUNO VALUES (1, 'ANDRE', '89999', NULL, NULL)

INSERT INTO TB_ALUNO VALUES (2, 'JOAO', '9999', NULL, NULL)

INSERT INTO TB_ALUNO VALUES (3, 'PATRICIA', '89999', NULL, NULL),
                            (4, 'JOANA', '9999', NULL, NULL)


-- Testes
DELETE FROM TB_ALUNO
DELETE FROM TB_LOG_PENDENCIAS

INSERT INTO TB_ALUNO VALUES(1, 'JOAO',NULL,NULL,NULL)
INSERT INTO TB_ALUNO VALUES(2, 'GUSTAVO',NULL,'RUA H',NULL)

SELECT * FROM TB_ALUNO
SELECT * FROM TB_LOG_PENDENCIAS
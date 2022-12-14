--PROCEDURES COM CURSOR
select * from TB_FUNCIONARIO

CREATE OR ALTER PROCEDURE P_BUSCA --CRIA O PROCEDURE
	@COD_BUSCA INT -- PASSA UM PARAMETRO
	AS -- INICIA O PROCEDIMENTO
		
		DECLARE C_CURSOR CURSOR -- CRIANDO O CURSOR
			FOR SELECT CD_CARGO, NOME FROM TB_FUNCIONARIO --DEFINE PARA PEGAR ESSES DOIS VALORES

		DECLARE @NOME VARCHAR(50),
				@CD_CARGO INT 

		OPEN C_CURSOR -- LEMBRAR DE ABRIR
			FETCH C_CURSOR INTO @CD_CARGO, @NOME -- INICIO, TEM QUE COLOCAR NA ORDEM DO CURSOR
			WHILE (@@FETCH_STATUS = 0) -- ENQUANTO NAO CHEGAR NO FINAL
			BEGIN -- ABRE PARENTIS WHILE	
				IF (@CD_CARGO = @COD_BUSCA)
				BEGIN -- ABRE PARENTIS IF
					PRINT @CD_CARGO
					PRINT @NOME -- PRINTANDO E VE OS VALORES RECEBIDOS	
				END -- FECHA PARENTIS IF
				FETCH C_CURSOR INTO @CD_CARGO, @NOME -- INDO PRA PROXIMA  LINHA
			END -- FECHA PARENTIS WHILE
		CLOSE C_CURSOR -- LEMBRAR DE FECHAR
		DEALLOCATE C_CURSOR -- AQUI REINICIA, TIRANDO DA MEMORIA

EXEC P_BUSCA 2 --RODA O PROCEDURE PASSANDO O PARAMETRO QUE VAI SER USADO COMO FILTRO
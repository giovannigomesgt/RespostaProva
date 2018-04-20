create database dbprova

use prova

create table Jogador(
	idJogador int identity primary key,
	nome varchar(40),
	datanascimento date,
	cpf varchar(11),
	Time_idTime int);

create table Time(
	idTime int identity primary key,
	nome varchar(45),
	estado varchar(2),
	Estadio_idEstadio int);

create table Jogo(
	data Date,
	precoingresso money,
	Estadio_idEstadio int,
	Time_mandante int,
	Time_visitante int,
	primary key(data,Estadio_idEstadio,Time_mandante,Time_visitante));

create table Estadio(
	idEstadio int primary key,
	nome varchar(45),
	capacidade int);

alter table Jogador add foreign key (Time_idTime) references Time(idTime);
alter table Time add foreign key (Estadio_idEstadio) references Estadio(idEstadio);
alter table Jogo add foreign key (Time_mandante) references Time(idTime);
alter table Jogo add foreign key (Time_visitante) references Time(idTime);
alter table Jogo add foreign key (Estadio_idEstadio) references Estadio(idEstadio);

insert into Estadio values (1,'Mineirao',50000), (2,'Estadio do Galo',100), (3,'Arena do Jacare',10000),(4,'Maracana',60000);
insert into Time values ('Cruzeiro','MG',1), ('Atletico','MG',1),('America','MG',3),('SAO PAULO','SP',4), ('FLAMENGO','RJ',4),('Fluminense','RJ',4);
insert into Jogador values ('Pedro','25/02/1986','99345678901',1),
						   ('Joao','26/02/1986','14245678901',1),
						   ('Jose','27/02/1986','44345678901',1),
						   ('Alencar','28/02/1986','00345678901',2),
						   ('Cristian','29/03/1986','12345622901',2),
						   ('Carlos','30/03/1986','12345678901',2),
						   ('Fabio','25/03/1986','12345678801',3),
						   ('Fernando','25/12/1986','12345678991',3),
						   ('Ze','5/12/1986','12345678991',3),
						   ('Joaquim','25/06/1986','12345678971',4),
						   ('Marcos','25/07/1986','12345678961',4),
						   ('Leandro','25/08/1986','12345678901',4),
						   ('Leonardo','22/02/1986','12345678961',4),
						   ('Kaka','01/01/1986','12345678951',1),
						   ('Alberto','01/12/1986','12345678941',1),
						   ('Fabiano','02/01/1986','12345678931',2),
						   ('Olavo','17/08/1986','12345678921',2),
						   ('Rodrigo','25/02/1986','12345678911',3);

	insert into Jogo values('01/01/2015',10,1,1,2), 
						   ('02/01/2015',10,1,2,1),
						   ('03/01/2015',10,2,3,1),
						   ('04/01/2015',10,2,4,2),
						   ('05/01/2015',10,3,1,4),
						   ('06/01/2015',10,3,2,3),
						   ('07/01/2015',10,4,3,4),
						   ('08/01/2015',10,4,4,2),
						   ('09/01/2015',10,1,1,2),
						   ('09/01/2015',10,1,2,3),
						   ('09/01/2015',10,2,3,4),
						   ('09/01/2015',10,2,4,2),
						   ('09/01/2015',10,3,1,2),
						   ('09/01/2015',10,3,2,3);

alter procedure ex7Prova 
 as begin 
	declare @cpf varchar(11)
	declare @nome varchar(45)
	declare informacoes cursor static for (select j.cpf, t.nome from time t inner join Jogador j on j.Time_idTime = t.idTime)
	open informacoes 
	if @@CURSOR_ROWS > 0
	begin
		fetch next from informacoes into @cpf, @nome
		while @@FETCH_STATUS = 0
		begin
			print '<JOGADOR>'
			print char(9) + '<CPF>' + @cpf + '</CPF>'
			print char(9) + '<TIME>' + @nome + '</TIME>'
			fetch next from informacoes into @cpf, @nome
		end
	end
	close informacoes
	deallocate informacoes
 end

-- (V) Uma visão é uma tabela criada a partir de outra(s)  tabelas. 
-- (V) A sintaxe para criar uma visão deve ser a seguinte: 
--      CREATE VIEW nome_da_visão AS expressão_de_consulta
-- (F) Create view aluno_professor as select aluno.nome, professor.nome
--    from aluno inner join professor on aluno.id_professor = professor.id 
--    (Está correto? )
-- (V) Um procedimento armazenado (stored procedure) é um lote de instruções SQL que é armazenado em um banco de dados.
-- (V) Um procedimento armazenado pode ser executado manualmente ou ser invocado por outros programas.
-- (F) O procedimento abaixo está correto. 

-- create database prova2
-- use prova2

create table aluno(
	codMatricula int IDENTITY(1,1) primary key,
	turma_idturma int,
	dataMatricula date,
	nome varchar(45),
	endereco text,
	telefone int,
	dataNascimento date,
	altura float,
	peso int);

create table turma(
	idturma int IDENTITY(1,1) primary key,
	horario time,
	duracao int,
	dataInicio date,
	dataFim date,
	atividade_idatividade int,
	instrutor_idinstrutor int);

create table atividade(
	idatividade int IDENTITY(1,1) primary key,
	nome varchar(100));

create table instrutor(
	idinstrutor int IDENTITY(1,1) primary key,
	RG int,
	nome varchar(45),
	nascimento date,
	titulacao int);

create table telefone_instrutor(
	idtelefone int IDENTITY(1,1) primary key,
	numero int,
	tipo varchar(45),
	instrutor_idinstrutor int);

create table chamada(
	idchamada int IDENTITY(1,1) primary key,
	data date,
	presente bit,
	matricula_aluno_codMatricula int,
	matricula_turma_idturma int);

create table matricula(
	aluno_codMatricula int,
	turma_idturma int,
	constraint PK_Matricula PRIMARY KEY (aluno_codMatricula, turma_idturma));

ALTER TABLE telefone_instrutor
ADD CONSTRAINT fk_idinstrutor
FOREIGN KEY (instrutor_idinstrutor)
REFERENCES instrutor(idinstrutor);

ALTER TABLE turma
add constraint fk_idatividade
foreign key (atividade_idatividade)
references atividade(idatividade);

ALTER TABLE turma
ADD CONSTRAINT fk_idinstrutor_turma
FOREIGN KEY (instrutor_idinstrutor)
REFERENCES instrutor(idinstrutor);

alter table matricula
add constraint fk_codmatricula
foreign key (aluno_codMatricula)
references aluno(codMatricula);

alter table matricula
add constraint fk_idturma
foreign key (turma_idturma)
references turma(idturma);

alter table chamada
add constraint fk_chamada
foreign key (matricula_aluno_codMatricula,matricula_turma_idturma)
references matricula(aluno_codMatricula,turma_idturma);

insert into atividade (nome)
values
('Musculação'),
('Dança'),
('Pilates'),
('Ioga'),
('K2');

insert into aluno (turma_idturma,dataMatricula,nome,endereco,telefone,dataNascimento,altura,peso) 
values
(1, '2000-01-01', 'Joao de Carvalho', 'endereco', 38383838, '1986-02-25',1.86,60),
(1, '2000-01-01', 'Pedro Paulo', 'endereco', 38383838, '1990-01-25',1.76,110),
(2, '2000-01-01', 'Emanuel Joaquim', 'endereco', 38383838, '2000-02-25',1.94,60),
(2, '2000-01-01', 'Santigo Assis', 'endereco', 38383838, '1980-12-25',1.76,60),
(3, '2000-01-01', 'Sheila Lopes', 'endereco', 38383838, '1986-01-5',1.50,60);

insert into instrutor (nome, RG, titulacao, nascimento)
values
('Antonio',1234,1,'1986-01-01'),
('Maria',1324,1,'1987-01-01'),
('Jose',0001,1,'1988-01-01'),
('Miguel',01010,1,'1988-01-01'),
('Emanuel',92929, 2,'1990-01-01');

insert into telefone_instrutor (instrutor_idinstrutor,numero,tipo)
values
(2,11111111,'1'),
(2,22222222,'1'),
(5,33333333,'1'),
(3,55555555,'2'),
(3,55555551,'2');

insert into turma (instrutor_idinstrutor,atividade_idatividade,dataInicio,dataFim,duracao,horario)
values
(3,1,'01-01-2015','01-01-2016',1,'03:00:00'),
(2,2,'01-01-2015','01-01-2016',1,'03:00:00'),
(3,3,'01-01-2015','01-01-2016',1,'04:00:00'),
(4,4,'01-01-2015','01-01-2016',1,'06:00:00'),
(5,4,'01-01-2015','01-01-2016',1,'07:00:00'),
(5,5,'01-01-2015','01-01-2016',1,'08:00:00');

insert into matricula (aluno_codMatricula, turma_idturma)
values
(1,6),
(4,1),
(1,2),
(1,4),
(2,1),
(3,1);



insert into chamada (matricula_aluno_codMatricula,matricula_turma_idturma,presente,data)
values
(2,1,1,'2015-01-01'),
(2,1,1,'2015-01-02'),
(2,1,0,'2015-01-03'),
(2,1,0,'2015-01-04'),
(3,1,1,'2015-01-01'),
(3,1,0,'2015-01-02'),
(3,1,0,'2015-01-03'),
(3,1,0,'2015-01-04');

create procedure qtdeTurma
	@instrutor int
as begin
	return (select count(*) from instrutor inner join turma on idinstrutor = instrutor_idinstrutor
	where idinstrutor = @instrutor)
end

declare @resposta int
exec @resposta = qtdeTurma 2
print @resposta

create function qtdeTurmaFuncao (@instrutor int)
returns int 
as begin
	return (select count(*) from instrutor inner join turma on idinstrutor = instrutor_idinstrutor
	where idinstrutor = @instrutor)
end

select user
select dbo.qtdeTurmaFuncao(2)

create procedure teste 
@id_instrutor int
as begin 
	if dbo.qtdeTurmaFuncao(@id_instrutor) > 1
	    print 'YES'
	else
		print 'No'
end

exec teste 2

CREATE FUNCTION CriandoHorarios(@min int, @inicio datetime, @fim datetime)
RETURNS @tbl TABLE(horario datetime)
AS
BEGIN
    WHILE @inicio <= @fim
    BEGIN
      INSERT INTO @tbl(horario) VALUES (@inicio)
      SET @inicio = DATEADD(MINUTE,@min,@inicio)
    END      
    RETURN
END

select convert(CHAR,horario,100) from CriandoHorarios(15,'20-04-2018 12:00','20-04-2018 17:00')

--Outra questão da prova..
alter trigger impedeApagar on Aluno instead of delete
as begin
	RAISERROR ('DEU RUIM', 16, 1) --msg, severidade (catch acima de 11), state
end

create procedure teste2
as begin
	begin try
		delete  from aluno
	end try
	begin catch 
		print 'Só um teste'
	end catch	
end

exec teste2

--Telefones x Instrutor
create procedure telefonesInstrutores 
as begin
	
	declare @nome varchar(50)
	declare @numero int

	declare resposta cursor static for 
	(select i.nome, t.numero from instrutor i inner join telefone_instrutor t
	on i.idinstrutor = t.instrutor_idinstrutor)
	open resposta
	if @@CURSOR_ROWS > 0
	begin
		fetch next from resposta into @nome, @numero
		while @@FETCH_STATUS = 0
		begin
			print @nome + '  ' + convert(varchar(10),@numero)
			fetch next from resposta into @nome, @numero							
		end
	end
	close resposta
	deallocate resposta
end

exec telefonesInstrutores


--  SCRIPT CLIENTE PEDIDO COM INSERTS ATUALIZADO 2023
--- Excluindo tabelas (caso existam)
--  SE NÃƒO EXISTIREM NÃƒO EXECUTAR OS DROPS

drop table Tb_Item_pedido;
drop table Tb_Pedido;
drop table Tb_cliente;
drop table Tb_vendedor;
drop table Tb_Produto;

--
create table TB_cliente
( codcliente number(5) not null,
  nomecliente varchar2(30) not null,
  endereco varchar2(30),
  cidade varchar2(20),
  cep varchar2(10),
  uf char(2));


create table TB_vendedor
( codvendedor number(5) not null,
  nomevendedor varchar2(30) not null,
  faixa_com    number(4,2),
  salario_fixo number(7,2));


create table TB_produto
( codproduto   number(5) not null,
  descricao varchar(30),
  unid       char(2),
  valor_unit number(6,2));

Create table TB_PEDIDO
( NUMPEDIDO     number(5) NOT NULL,
  PRAZO_ENTREGA DATE,
  CODCLIENTE     number(5),
  CODVENDEDOR   number(5));

CREATE TABLE TB_ITEM_PEDIDO
(NUMPEDIDO   number(5) NOT NULL,
 CODPRODUTO  number(5) NOT NULL,
 QTDE        number(5));


--DEFININDO AS RESTRIÃ‡Ã•ES de PK

select * from user_constraints;

ALTER TABLE TB_Cliente
 ADD CONSTRAINT PK_Cliente_codcliente PRIMARY KEY(Codcliente);
 
 ALTER TABLE TB_Produto 
 ADD CONSTRAINT PK_PRODUTO_CODPRODUTO PRIMARY KEY(CODPRODUTO);

ALTER TABLE TB_VENDEDOR 
 ADD CONSTRAINT PK_VENDEDOR_CODVENDEDOR PRIMARY KEY(CODVENDEDOR);

ALTER TABLE TB_PEDIDO 
 ADD CONSTRAINT PK_PEDIDO_NUMPEDIDO PRIMARY KEY(NUMPEDIDO);
 
 ALTER TABLE TB_ITEM_PEDIDO ADD CONSTRAINT  PK_ITEMPEDIDO_PEDPROD 
 PRIMARY KEY(NUMPEDIDO,CODPRODUTO);

select * from user_constraints order by table_name;

--- RestriÃ§Ãµes de FK 

ALTER TABLE TB_PEDIDO 
 ADD CONSTRAINT FK_PEDIDO_CODCLI FOREIGN KEY(CODCLIENTE) REFERENCES TB_CLIENTE;

ALTER TABLE TB_PEDIDO 
 ADD CONSTRAINT FK_PEDIDO_CODVENDEDOR FOREIGN KEY(CODVENDEDOR) REFERENCES TB_VENDEDOR;

--- ITEM PEDIDO


ALTER TABLE TB_ITEM_PEDIDO 
    ADD CONSTRAINT FK_ITEMPEDIDO_NUMPEDIDO FOREIGN KEY(NUMPEDIDO) REFERENCES TB_PEDIDO;

ALTER TABLE TB_ITEM_PEDIDO 
    ADD CONSTRAINT FK_ITEMPEDIDO_CODPRODUTO FOREIGN KEY(CODPRODUTO) REFERENCES TB_PRODUTO;


select * from user_constraints;
---- Inserindo dados

insert into TB_vendedor values (5,'Antonio Pedro',5.0,400);
insert into TB_vendedor values (15,'Carlos Sola',0.0,400);
insert into TB_vendedor values (25,'Ana Carolina',1.0,200);
insert into TB_vendedor values (35,'Solange Almeida',1.0,300);

--
INSERT INTO TB_CLIENTE 
VALUES ( 30, 'João da Silva', 'AV. MATT HOFFMANN, 1100', 'SÃO PAULO', '97056-001', 'SP');
INSERT INTO TB_CLIENTE 
VALUES ( 31, 'LUCAS ANTUNES', 'RUA TRODANI, 120', 'SOROCABA', '19658-023', 'SP');
INSERT INTO TB_CLIENTE 
VALUES ( 32, 'LAURA STRAUSS', 'RUA TULIPAS, 650', 'PRIMAVERA', '18556-025', 'SP');
INSERT INTO TB_CLIENTE 
VALUES ( 33, 'CARLOS SILVA', 'RUA SETE DE SETEMBRO, 720', 'SOROCABA', '18016-555', 'SP');
INSERT INTO TB_CLIENTE 
VALUES ( 34, 'JULIA MARIA', 'RUA PRIMAVERA, 13', 'SOROCABA', '18016-001', 'SP');
--
INSERT INTO TB_PRODUTO VALUES ( 11, 'Apple Watch', 'UN', 975.99);
INSERT INTO TB_PRODUTO VALUES ( 12, 'IPAD', 'UN', 999.70);
INSERT INTO TB_PRODUTO VALUES ( 13, 'PÃ“ PARA TONER', 'KG', 85.60);
INSERT INTO TB_PRODUTO VALUES ( 14, 'Mouse', 'UN', 45.60);
INSERT INTO TB_PRODUTO VALUES ( 15, 'Caneta digital', 'UN', 100.00);
insert into TB_Produto values (40,'Mouse sem fio', 'UN', 68.90);
insert into TB_Produto values (42,'FIO HDMI', 'UN', 18.00);
insert into TB_Produto values (43,'Pendrive Star Wars', 'UN', 48.00);
insert into TB_Produto values (44,'Mouse com fio', 'UN', 28.00);
insert into TB_Produto values (45,'Pendrive do Mickey', 'UN', 50.00);

--


INSERT INTO TB_PEDIDO VALUES ( 7, SYSDATE, 31, 15);
INSERT INTO TB_PEDIDO VALUES ( 8, '23/05/2022', 32, 25);
INSERT INTO TB_PEDIDO VALUES ( 9,'21/02/2020', 32, 5);
INSERT INTO TB_PEDIDO VALUES ( 10, '20/02/2020', 30, 5);

--
Insert into tb_item_pedido values (7,11,1);
Insert into tb_item_pedido values (7,40,2);
Insert into tb_item_pedido values (7,42,1);
Insert into tb_item_pedido values (8,43,5);
Insert into tb_item_pedido values (9,12,1);
Insert into tb_item_pedido values (10,11,1);
Insert into tb_item_pedido values (10,43,1);
Insert into tb_item_pedido values (10,13,2);
Insert into tb_item_pedido values (8,40,1);

select * from tb_cliente;
select * from tb_vendedor;
select * from tb_produto;
select * from tb_pedido;
select * from tb_item_pedido;


select * from tb_produto where valor_unit > (select avg(valor_unit) from tb_produto);

insert into tb_cliente VALUES ( 35, 'Maria da Silva', 'AV. MATT HOFFMANN, 1100', 'SÃO PAULO', '97056-001', 'SP');
delete from tb_cliente where codcliente=35;
select * from tb_cliente;

--Resposta do exercício 1 da lista 3
select nomecliente 
from tb_cliente 
where nomecliente <> 'João da Silva'
  and cidade = (select cidade 
                from tb_cliente 
                where nomecliente = 'João da Silva');


select nomecliente from TB_cliente inner join tb_pedido
on tb_pedido.codcliente = tb_cliente.codcliente;

select nomecliente from TB_cliente
 where codcliente in ( select codcliente from TB_pedido);
 
 select codcliente from tb_cliente
 intersect 
 select codcliente from tb_pedido;

update tb_pedido set prazo_entrega = add_months (prazo_entrega,60)
where numpedido = 9  or numpedido =10;
select * from tb_pedido ;

 select tb_vendedor.codvendedor,nomevendedor
 from Tb_vendedor, tb_pedido
 where Tb_pedido.codvendedor = tb_vendedor.codvendedor and 
 to_char(prazo_entrega,'mm/yyyy') <> '02/2025'; 
 
 select nomevendedor from tb_vendedor where codvendedor not in(select codvendedor from tb_pedido where to_char(prazo_entrega,'mm/yyyy') = '02/2025');
 
 --Resposta do exercício 2 lista 3
 select descricao 
 from tb_produto 
 where codproduto not in
 (select codproduto from tb_item_pedido where numpedido in
 (select numpedido from tb_pedido where to_char(prazo_entrega,'yyyy')='2025'));
 
 
select nomecliente 
from tb_cliente 
where codcliente in
(select codcliente 
from tb_pedido where codvendedor =5) and codcliente not in(select codcliente from tb_pedido where codvendedor <>5);

select * from tb_pedido;
select * from tb_cliente;

--respostas dos exercícios de Junção Lista 03

--Execício 1  visão
 create or replace view v_Ex01 as 
 select v.nomevendedor, v.codvendedor
 from tb_vendedor v
 join tb_pedido p on v.codvendedor = p.codvendedor
 where p.codcliente = 10;
--Só vou usar outro join se eu quiser comparar outra coluna de outra tabela com alguma coluna que já foi colocada 
 select * from v_Ex01;
 
 select * from tb_cliente; 
 select * from tb_pedido;
 select * from tb_vendedor;
 select * from tb_item_pedido;

--Exercício 2 visão
create or replace view v_Ex02
as select ip.numpedido, ip.codproduto,pe.prazo_entrega, ip.qtde, pr.descricao
from tb_item_pedido ip
join tb_pedido pe on ip.numpedido = pe.numpedido
join tb_produto pr on pr.codproduto = ip.codproduto
where ip.codproduto = 43;
 
 select * from v_Ex02;
 
 --Exercício 3 visão
 create or replace view v_Ex03 as
 select v.codvendedor, v.nomevendedor
 from tb_vendedor v
 join tb_pedido p on v.codvendedor = p.codvendedor
 join tb_cliente c on c.codcliente = p.codcliente
 where c.nomecliente = 'João da Silva';
 
 select * from v_Ex03;
 
 --Exercício 4 visão
 create or replace view v_Ex04 as
 select pe.numpedido, ip.codproduto, pd.descricao, v.codvendedor, v.nomevendedor, c.nomecliente
 from tb_pedido pe
 join tb_item_pedido ip on pe.numpedido = ip.numpedido
 join tb_produto pd on ip.codproduto = pd.codproduto
 join tb_vendedor v on pe.codvendedor = v.codvendedor
 join tb_cliente c on pe.codcliente = c.codcliente
 where c.cidade ='SOROCABA';
 
select * from v_Ex04;

--Exercício 01 de SubConsultas
select nomecliente
from tb_cliente
where cidade in(select cidade from tb_cliente where nomecliente = 'João da Silva') and nomecliente <>'João da Silva';

--Exercício 02 de SubConsultas
select descricao
from tb_produto
where valor_unit >(select AVG(valor_unit) from tb_produto);

--Exercício 03 de subconsulta
select nomecliente 
from tb_cliente 
where codcliente in
(select codcliente 
from tb_pedido where codvendedor =5) and codcliente not in(select codcliente from tb_pedido where codvendedor <>5);

--Exercício 04 de SubConsultas
select nomevendedor
from tb_vendedor
where codvendedor in(select codvendedor from tb_pedido group by codvendedor HAVING COUNT(*)< 2);

select * from tb_pedido;

--Exerc�cio 05 de SubConsultas
select nomevendedor
from tb_vendedor
where codvendedor not in(select codvendedor from tb_pedido where to_char(prazo_entrega,'mm/yyyy') = '05/2021');

--Exerc�cio 06 de SubConsultas
select v.codvendedor, v.nomevendedor, count(*)as pedidos
from tb_pedido p
join tb_vendedor v on p.codvendedor = v.codvendedor
group by v.codvendedor, v.nomevendedor 
having count(*) = (select max(count(*)) from tb_pedido group by codvendedor);


--Exemplo de exists( que retorno se o valor � verdadeiro ou n�o dentro de uma subcosnulta) caso seja veradeiro a consulta externa executa a consulta interna.
select codcliente 
from  tb_cliente
where exists(select codcliente from tb_pedido where tb_pedido.codcliente = tb_cliente.codcliente);

select 'N�o exitem pedidos para o cliente 35' from dual
where not exists(select codcliente from tb_pedido where codcliente =35); 
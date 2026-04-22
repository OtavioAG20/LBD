--Exercício 01 da lista04_B Procedure

create procedure ls04_ex01(pCodVendedor number) as
v_valor number;
Begin
select SUM(ip.quantidade * pr.valor_unitario) into v_valor
from produto pr join item_pedido ip on ip.codproduto = pr.codproduto
join pedido pe on pe.NumPedido = ip.NumPedido
where pe.codvendedor = pCodVendedor;
    if(v_valor > 0 and v_valor <100) then
    update tb_vendedor
    set faixa_com = 10
    where codVendedor = pCodVendedor;
    else
        if(v_valor >=100 and v_valor <=1000) then
        update tb_vendedor
        set faixa_com = 15
        where codVendedor = pCodVendedor;
        else
            if(v_valor > 1000) then
            update tb_vendedor
            set faixa_com = 20
            where codVendedor = pCodVendedor;
            else
                if v_valor is NULL then
                update tb_vendedor
                set faixa_com = 0
                where codVendedor = pCodVendedor;
                end if;
            end if;
        end if;
    end if;
    Exception
    when no_data_found then
    insert into tab_erro values(sysdate, 'Vendedor não encontrado');
end;

--Exercício 02 da lista04_B de procedures
create procedure ls04_ex02(pCodProduto number) as
p_Descricao varchar2(30);
v_cont number;
begin
    select Descricao into p_Descricao
    from tb_produto where pCodProduto = codProduto;
    select COUNT(codProduto) into v_cont from tb_item_pedido 
    where codProduto = pCodProduto;
    if(v_cont = 0) then
    insert into tabLog values(sysdate,'Código do Produto: ' || pCodProduto || 'Descrição: ' || p_Descricao || 'Usuário: ' || USER);
    delete from tb_produto where codProduto = pCodProduto;
    end if;
    Exception
    when no_data_found then
    insert into tab_erro values(sysdate, 'Código do Produto: ' || pCodProduto || 'roduto não encontrado');
end; 

--Exercício 03 da lista04_B de procedures
create procedure ls04_ex_03(pCodProduto number) as
p_Descricao varchar2(30);
v_cont number;
begin
    select Descricao into p_Descricao
    from tb_produto where pCodProduto = codProduto;
    select COUNT(codProduto) into v_cont from tb_item_pedido 
    where codProduto = pCodProduto;
    if(v_cont = 0) then
    insert into tabLog values(sysdate,'Código do Produto: ' || pCodProduto || 'Descrição: ' || p_Descricao || 'Usuário: ' || USER);
    delete from tb_produto where codProduto = pCodProduto;
    end if;
    Exception
    when no_data_found then
    insert into tab_erro values(sysdate, 'Código do Produto: ' || pCodProduto || 'roduto não encontrado');
end; 

--Exercício 04 da lista04_B de procedures
create procedure ls04_ex04(pUnidade char) as
v_cont number;
v_lista varchar2(100);
begin
    select Lista(codproduto, ' , ') from tb_produto where unid = pUnidade; 
    update tb_produto set valor_unit = valor_unit * 1.10 where unid = pUnidade;
    insert into tabLog values(sysdate, 'PRODUTOS com preço modificado' || gdgdg || 'Linhas que atualizaram: ' || v_cont);
end;
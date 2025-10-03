*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Resource    login_keyword.robot
Resource    ../variables/global_variables.robot
Resource    ../keywords/common_keyword.robot
Resource    ../keywords/user_keyword.robot
Resource    ../keywords/product_keyword.robot


*** Keywords ***
Setup para Testes de Carrinho
    [Documentation]    Setup específico para testes de carrinho - cria usuário, faz login e cadastra produto
    Setup Test Session
    ${emailcarrinho}    Gerar Email Aleatorio
    Criar Novo Usuario e Salvar ID    ${USER_ADMIN.nome}    ${emailcarrinho}    ${USER_ADMIN.password}    ${USER_ADMIN.administrador}
    Fazer Login e Salvar Token    ${emailcarrinho}    ${USER_ADMIN.password}
    ${unique_name}      Gerar nome de produto unico
    Cadastrar Novo Produto e Salvar ID   ${unique_name}    ${PRODUTO.preco}    ${PRODUTO.descricao}    ${PRODUTO.quantidade}

Cadastrar carrinho com sucesso
    ${auth_headers}=    Create Dictionary    Authorization=${AUTH_HEADER}
    ${produto_dict}=    Create Dictionary    idProduto=${PRODUCT_ID}    quantidade=1
    ${produto_lista}=    Create List    ${produto_dict}
    ${body}=    Create Dictionary    produtos=${produto_lista}
    ${response}=    POST On Session    ${API_SESSION}    /carrinhos    json=${body}    headers=${auth_headers}
    Status Should Be    201    ${response}
    Should Be Equal As Strings    ${response.json()['message']}    Cadastro realizado com sucesso

Tentar excluir usuario que possui carrinho
    ${response}=    DELETE On Session    ${API_SESSION}    /usuarios/${USER_ID}    expected_status=400
    Should Be Equal As Strings    ${response.json()['message']}    Não é permitido excluir usuário com carrinho cadastrado

Concluir compra e esvaziar carrinho
    ${auth_headers}=    Create Dictionary    Authorization=${AUTH_HEADER}
    ${response}=    DELETE On Session    ${API_SESSION}    /carrinhos/concluir-compra    headers=${auth_headers}
    Status Should Be    200    ${response}
    Should Be Equal As Strings    ${response.json()['message']}    Registro excluído com sucesso

Tentar excluir usuario sem carrinho
    Excluir usuario com sucesso

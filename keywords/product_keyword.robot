*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Resource    login_keyword.robot
Resource    ../variables/global_variables.robot


*** Keywords ***
Gerar nome de produto unico
    ${random_number}=    Generate Random String    5    [NUMBERS]
    ${unique_name}=    Catenate    SEPARATOR=    Produto_    ${random_number}
    Set Global Variable    ${unique_name}
    [Return]    ${unique_name}

Cadastrar Novo Produto e Salvar ID
    [Arguments]    ${unique_name}    ${preco}    ${descricao}    ${quantidade}
    ${auth_headers}=    Create Dictionary    Authorization=${AUTH_HEADER}
    ${body}=    Create Dictionary
    ...    nome=${unique_name}
    ...    preco=${preco}
    ...    descricao=${descricao}
    ...    quantidade=${quantidade}

    ${response}=    POST On Session
    ...    ${API_SESSION}
    ...    /produtos
    ...    json=${body}
    ...    headers=${auth_headers}
    ...    expected_status=201

    ${product_id}=    Set Variable    ${response.json()['_id']}
    Set Global Variable    ${PRODUCT_ID}    ${product_id}
    [Return]    ${response}

Listar produtos e validar schema
    ${response}=    GET On Session    ${API_SESSION}    /produtos
    Status Should Be    200    ${response}
    ${json_response}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json_response}    quantidade
    Dictionary Should Contain Key    ${json_response}    produtos
    ${primeiro_produto}=    Get From List    ${json_response['produtos']}    0
    Dictionary Should Contain Key    ${primeiro_produto}    nome
    Dictionary Should Contain Key    ${primeiro_produto}    preco
    Dictionary Should Contain Key    ${primeiro_produto}    descricao
    Dictionary Should Contain Key    ${primeiro_produto}    quantidade
    Dictionary Should Contain Key    ${primeiro_produto}    _id
Cadastrar produto com sucesso
    ${auth_headers}=    Create Dictionary    Authorization=${AUTH_HEADER}
    ${unique_name}=    Gerar nome de produto unico
    ${body}=    Create Dictionary
    ...    nome=${unique_name}
    ...    preco=${PRODUTO.preco}
    ...    descricao=${PRODUTO.descricao}
    ...    quantidade=${PRODUTO.quantidade}
    ${response}=    POST On Session    ${API_SESSION}    /produtos    json=${body}    headers=${auth_headers}
    Status Should Be    201    ${response}
    Should Be Equal As Strings    ${response.json()['message']}    Cadastro realizado com sucesso
    Set Global Variable    ${PRODUCT_ID}    ${response.json()['_id']}
    Set Global Variable    ${Produto.unique_name}    ${unique_name}
Tentar cadastrar produto com nome duplicado
    ${auth_headers}=    Create Dictionary    Authorization=${AUTH_HEADER}
    ${body}=    Create Dictionary    nome=${Produto.unique_name}    preco=99    descricao=Outro    quantidade=1
    ${response}=    POST On Session    ${API_SESSION}    /produtos    json=${body}    headers=${auth_headers}    expected_status=400
    Should Be Equal As Strings    ${response.json()['message']}    Já existe produto com esse nome

Buscar produto por ID e validar dados
    ${response}=    GET On Session    ${API_SESSION}    /produtos/${PRODUCT_ID}
    Status Should Be    200    ${response}
Editar produto com sucesso
    ${auth_headers}=    Create Dictionary    Authorization=${AUTH_HEADER}
    ${body}=    Create Dictionary
    ...    nome=Produto Editado
    ...    preco=150
    ...    descricao=Descrição Editada
    ...    quantidade=20
    ${response}=    PUT On Session    ${API_SESSION}    /produtos/${PRODUCT_ID}    json=${body}    headers=${auth_headers}
    Status Should Be    200    ${response}
    Should Be Equal As Strings    ${response.json()['message']}    Registro alterado com sucesso

Excluir produto com sucesso
    ${auth_headers}=    Create Dictionary    Authorization=${AUTH_HEADER}
    ${response}=    DELETE On Session    ${API_SESSION}    /produtos/${PRODUCT_ID}    headers=${auth_headers}
    Status Should Be    200    ${response}
    Should Be Equal As Strings    ${response.json()['message']}    Registro excluído com sucesso


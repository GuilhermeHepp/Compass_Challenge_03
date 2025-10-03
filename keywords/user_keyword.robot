*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Resource    ../variables/global_variables.robot


*** Keywords ***
Gerar Email Aleatorio
    ${random_string}=    Generate Random String    8    [LOWER]
    ${email}=            Catenate    SEPARATOR=    teste_robot_${random_string}    @qa.com.br
    [Return]    ${email}

Criar Novo Usuario e Salvar ID
    [Arguments]    ${nome}    ${email}    ${password}    ${administrador}
    ${body}=    Create Dictionary
    ...    nome=${nome}
    ...    email=${email}
    ...    password=${password}
    ...    administrador=${administrador}
    ${response}=    POST On Session
    ...    ${API_SESSION}
    ...    /usuarios
    ...    json=${body}
    ...    expected_status=201

    ${user_id}=    Set Variable    ${response.json()['_id']}
    Set Suite Variable    ${USER_ID}    ${user_id}
    [Return]    ${response}

Listar usuarios e validar schema
    Create Session    ${API_SESSION}    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=    GET On Session    ${API_SESSION}    /usuarios
    Status Should Be    200    ${response}
    ${json_response}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json_response}    quantidade
    Dictionary Should Contain Key    ${json_response}    usuarios
    ${primeiro_usuario}=    Get From List    ${json_response['usuarios']}    0
    Dictionary Should Contain Key    ${primeiro_usuario}    nome
    Dictionary Should Contain Key    ${primeiro_usuario}    email
    Dictionary Should Contain Key    ${primeiro_usuario}    administrador
    Dictionary Should Contain Key    ${primeiro_usuario}    _id

Cadastrar novo usuario com sucesso
    ${email_comum}=    Gerar Email Aleatorio
    Set Global Variable    ${EMAIL_COMUM}    ${email_comum}
    ${response}=    Criar Novo Usuario e Salvar ID    ${USER_COMUM.nome}    ${email_comum}    ${USER_COMUM.password}    ${USER_COMUM.administrador}
    Should Be Equal As Strings    ${response.json()['message']}    Cadastro realizado com sucesso

Tentar cadastrar usuario com email duplicado
    ${body}=    Create Dictionary    nome=Outro Nome    email=${EMAIL_COMUM}    password=outrasenha    administrador=false
    ${response}=    POST On Session    ${API_SESSION}    /usuarios    json=${body}    expected_status=400
    Should Be Equal As Strings    ${response.json()['message']}    Este email já está sendo usado

Buscar usuario por ID e validar dados
    ${response}=    GET On Session    ${API_SESSION}    /usuarios/${USER_ID}
    Status Should Be    200    ${response}
    Should Be Equal As Strings    ${response.json()['nome']}    ${USER_COMUM.nome}
    Should Be Equal As Strings    ${response.json()['email']}    ${EMAIL_COMUM}

Editar usuario com sucesso
    ${body}=    Create Dictionary    nome=Nome Alterado Robot    email=${EMAIL_COMUM}    password=senhaalterada    administrador=false
    ${response}=    PUT On Session    ${API_SESSION}    /usuarios/${USER_ID}    json=${body}
    Status Should Be    200    ${response}
    Should Be Equal As Strings    ${response.json()['message']}    Registro alterado com sucesso

Excluir usuario com sucesso
    ${response}=    DELETE On Session    ${API_SESSION}    /usuarios/${USER_ID}
    Status Should Be    200    ${response}
    Should Be Equal As Strings    ${response.json()['message']}    Registro excluído com sucesso

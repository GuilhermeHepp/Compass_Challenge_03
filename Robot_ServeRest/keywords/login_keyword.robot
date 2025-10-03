*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Resource    ../variables/global_variables.robot
Resource    ../keywords/common_keyword.robot

*** Keywords ***
Fazer Login e Salvar Token
    [Arguments]    ${email}    ${password}
    ${body}=    Create Dictionary
    ...    email=${email}
    ...    password=${password}
    ${response}=    POST On Session
    ...    ${API_SESSION}
    ...    /login
    ...    json=${body}
    ...    expected_status=200

    ${auth_header}=    Set Variable    ${response.json()['authorization']}
    Set Global Variable    ${AUTH_HEADER}    ${auth_header}
    [Return]    ${response}

Realizar login com sucesso
    Create Session    ${API_SESSION}    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=    Fazer Login e Salvar Token    ${EMAIL_ADMIN}    ${USER_ADMIN.password}
    Dictionary Should Contain Key    ${response.json()}    authorization

Tentar realizar login com senha invalida
    ${body}=    Create Dictionary    email=${EMAIL_ADMIN}    password=senhaerrada123
    ${response}=    POST On Session    ${API_SESSION}    /login    json=${body}    expected_status=401
    Should Be Equal As Strings    ${response.json()['message']}    Email e/ou senha inválidos

Tentar realizar login com email invalido
    ${body}=    Create Dictionary    email=email.invalido@qa.com.br    password=senhaerrada123
    ${response}=    POST On Session    ${API_SESSION}    /login    json=${body}    expected_status=401
    Should Be Equal As Strings    ${response.json()['message']}    Email e/ou senha inválidos
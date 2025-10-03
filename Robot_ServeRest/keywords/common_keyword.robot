*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    JSONLibrary
Resource    ../variables/global_variables.robot
Resource    ../keywords/login_keyword.robot
Resource    ../keywords/user_keyword.robot

*** Keywords ***
Setup Test Session
    [Documentation]  
    Create Session    ${API_SESSION}    ${BASE_URL}    timeout=${TIMEOUT}

Setup para Testes Autenticados
    [Documentation]
    Setup Test Session
    ${response}=    Fazer Login e Salvar Token    ${EMAIL_ADMIN}    ${USER_ADMIN.password}
    Dictionary Should Contain Key    ${response.json()}    authorization
    [Return]    ${response}
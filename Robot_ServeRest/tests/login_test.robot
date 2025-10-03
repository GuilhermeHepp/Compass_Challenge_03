*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Resource          ../variables/global_variables.robot
Resource          ../keywords/login_keyword.robot
Resource          ../keywords/common_keyword.robot

Suite Teardown    Delete All Sessions

*** Test Cases ***
Fluxo de Login
    [Tags]    login
    Realizar login com sucesso
    Tentar realizar login com senha invalida
    Tentar realizar login com email invalido
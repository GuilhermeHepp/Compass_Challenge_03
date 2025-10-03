*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Resource          ../variables/global_variables.robot
Resource          ../keywords/product_keyword.robot
Resource          ../keywords/common_keyword.robot

Suite Teardown    Delete All Sessions  

*** Test Cases ***
Fluxo de Usuarios
    [Tags]    usuarios
    Listar usuarios e validar schema
    Cadastrar novo usuario com sucesso
    Tentar cadastrar usuario com email duplicado
    Buscar usuario por ID e validar dados
    Editar usuario com sucesso
    Excluir usuario com sucesso
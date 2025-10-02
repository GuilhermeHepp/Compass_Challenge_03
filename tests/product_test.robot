*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Resource          ../variables/global_variables.robot
Resource          ../keywords/product_keyword.robot
Resource          ../keywords/common_keyword.robot

Suite Teardown    Delete All Sessions

*** Test Cases ***
Fluxo de Produtos (Requer Autenticacao)
    [Tags]    produtos
    [Setup]    Setup para Testes Autenticados
    Listar produtos e validar schema
    Cadastrar produto com sucesso
    Tentar cadastrar produto com nome duplicado
    Buscar produto por ID e validar dados
    Editar produto com sucesso
    Excluir produto com sucesso
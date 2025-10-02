*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Resource          ../variables/global_variables.robot
Resource          ../keywords/carrinho_keyword.robot
Resource          ../keywords/common_keyword.robot

Suite Teardown    Delete All Sessions

*** Test Cases ***
Fluxo de Carrinhos (Requer Autenticacao)
    [Tags]    carrinhos
    [Setup]    Setup para Testes de Carrinho
    Cadastrar carrinho com sucesso
    Tentar excluir usuario que possui carrinho
    Concluir compra e esvaziar carrinho
    Tentar excluir usuario sem carrinho
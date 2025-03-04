*** Settings ***
Documentation    Teste Projeto

*** Variables ***
${nome}    Marcelo Martins

*** Test Cases ***
Imprimir Nome no Terminal
    Imprimir Nome

*** Keywords ***
Imprimir Nome
    Log To Console    Olá ${nome}, seja bem vindo ao Dojo de Robot!

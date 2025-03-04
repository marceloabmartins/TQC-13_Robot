*** Settings ***
Documentation    Pegar Token

Library    RequestsLibrary
Library    String
Library    Collections


*** Variables ***
${baseUrl}    https://develop.qacoders-academy.com.br/api/
${id_user}    66df6d8817b3e584b6eaf753
#${token}    xyz

*** Test Cases ***
Deletar usuário
    Delete User

*** Keywords ***
Criar Sessao
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=develop    url=${baseUrl}    headers=${headers}    verify=true

Pegar Token
    ${body}    Create Dictionary    
    ...    mail=sysadmin@qacoders.com
    ...    password=1234@Test
    Criar Sessao
    ${resposta}    POST On Session    alias=develop    url=/login    json=${body}
    Status Should Be    200    ${resposta}
    RETURN    ${resposta.json()["token"]}

Delete User
    ${token}    Pegar Token
    ${resposta}    DELETE On Session    alias=develop    url=/user/${id_user}/?token=${token}
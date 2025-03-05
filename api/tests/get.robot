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
Listar usuários
    Listagem Users

Contar Usuários
    Count Users

Pegar Usuário
    Get User

*** Keywords ***
Criar Sessao
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=develop    url=${baseUrl}    headers=${headers}    verify=true

Pegar Token
    ${body}    Create Dictionary    
    ...    mail=sysadmin@qacoders.com
    ...    password=1234@Test
    #Log    ${body}
    Criar Sessao
    ${resposta}    POST On Session    alias=develop    url=/login    json=${body}
    #Log To Console    ${resposta.json()}
    #Log To Console    ${resposta.json()["token"]}
    Status Should Be    200    ${resposta}
    RETURN    ${resposta.json()["token"]}

Listagem Users
    ${token}    Pegar Token
    GET On Session    alias=develop    url=/user/?token=${token}

Count Users
    ${token}    Pegar Token
    ${resposta}    GET On Session    alias=develop    url=/user/count/?token=${token}
    #RETURN    ${resposta.json()}
    Log To Console    ${resposta.json()["count"]}

Get User
    ${token}    Pegar Token
    ${resposta}    GET On Session    alias=develop    url=/user/${id_user}/?token=${token}

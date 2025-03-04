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
Mudar status de usuário para false
    Put Status False

Mudar status de usuário para true
    Put Status True

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

Put Status False
    ${token}    Pegar Token
    ${body}    Create Dictionary    status=false
    PUT On Session    alias=develop    url=/user/status/${id_user}/?token=${token}    json=${body}
    

Put Status True
    ${token}    Pegar Token
    ${body}    Create Dictionary    status=true
    PUT On Session    alias=develop    url=/user/status/${id_user}/?token=${token}    json=${body}
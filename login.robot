*** Settings ***
Documentation    Pegar Token

Library    RequestsLibrary
Library    String
Library    Collections


*** Variables ***
${baseUrl}    https://develop.qacoders-academy.com.br/api/

*** Test Cases ***
Validar login
    Realizar Login

*** Keywords ***
Criar Sessao
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=develop    url=${baseUrl}    headers=${headers}    verify=true

Realizar Login
    ${body}    Create Dictionary    
    ...    mail=sysadmin@qacoders.com
    ...    password=1234@Test
    #Log    ${body}
    Criar Sessao
    ${resposta}    POST On Session    alias=develop    url=/login    json=${body}
    #Log To Console    ${resposta.json()}
    #Log To Console    ${resposta.json()["token"]}
    Status Should Be    200    ${resposta}
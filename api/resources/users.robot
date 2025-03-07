*** Settings ***
Documentation    Keywords para o Path /Users
Resource    ../resources/resource.robot

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

Create user
    [Arguments]    ${userName}    ${numero}
    Log To Console    ${userName}
    ${token}    Pegar Token
    ${body}    Create Dictionary
    ...    fullName=Clarice Allana Araujo${userName}
    ...    mail=clarice_araujo${userName}@macaubas.com
    ...    password=1234@Test
    ...    accessProfile=ADMIN
    ...    cpf=081611828${numero}
    ...    confirmPassword=1234@Test
    ${resposta}    POST On Session    alias=develop    url=/user/?token=${token}    json=${body}
    Status Should Be    201    ${resposta}
    Log To Console    ${resposta.json()["user"]["_id"]}

List Users
    [Documentation]    Retorna a listagem de usuários
    ${token}    Pegar Token
    ${ressposta}    GET On Session    alias=develop    url=/user/?token=${token}
    Status Should Be    200    ${resposta}
    RETURN    ${ressposta.json()}

Count Users
    ${token}    Pegar Token
    ${resposta}    GET On Session    alias=develop    url=/user/count/?token=${token}
    RETURN    ${resposta.json()}
    #Log To Console    ${resposta.json()["count"]}

Get User
    ${token}    Pegar Token
    ${resposta}    GET On Session    alias=develop    url=/user/${id_user}/?token=${token}

Delete User
    ${token}    Pegar Token
    ${resposta}    DELETE On Session    alias=develop    url=/user/${id_user}/?token=${token}

Put Status False
    ${token}    Pegar Token
    ${body}    Create Dictionary    status=false
    PUT On Session    alias=develop    url=/user/status/${id_user}/?token=${token}    json=${body}
    

Put Status True
    ${token}    Pegar Token
    ${body}    Create Dictionary    status=true
    PUT On Session    alias=develop    url=/user/status/${id_user}/?token=${token}    json=${body}

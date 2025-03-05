*** Settings ***
Documentation    Pegar Token

Library    RequestsLibrary
Library    String
Library    random
Library    Collections

*** Variables ***
${baseUrl}    https://develop.qacoders-academy.com.br/api/

*** Test Cases ***
Validar login
    Realizar Login

Criar usuário
    [Tags]    test001 
    #robot --include test001 post.robot
    ${letras}    Generate Random String    length=4    chars=[LETTERS]
    ${numero}  Generate Random String  2    [NUMBERS]
    ${letras_minusculas}    Convert To Lower Case    ${letras}
    Create user    ${letras_minusculas}    ${numero}

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
    RETURN    ${resposta.json()["token"]}

Create user
    [Arguments]    ${userName}    ${numero}
    Log To Console    ${userName}
    ${token}    Realizar Login
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

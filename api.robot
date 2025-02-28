*** Settings ***
Documentation    Configurações iniciais do projeto

## Importando as Bibliotecas
Library    RequestsLibrary
#Library    libs/get_fake_person.py


*** Variables ***
${baseUrl}    https://ron-bugado.qacoders.dev.br/api/


*** Test Cases ***
# REQUEST POST
CT01 - Realizar Login com sucesso
    ${resposta}    Realizar Login    email=sysadmin@qacoders.com    senha=1234@Test
    Status Should Be    200    ${resposta}

CT02 - Realizar Login com senha inválida
    ${resposta}    Realizar Login    email=sysadmin@qacoders.com    senha=1234@Tes
    Status Should Be    400    ${resposta}

CT03 - Realizar Login com email inválido
    ${resposta}    Realizar Login    email=sysadmin@qacoders.com.br    senha=1234@Test
    Status Should Be    400    ${resposta}
    Should Be Equal    first=E-mail ou senha informados são inválidos.    second=${resposta.json()["alert"]}
    #Log To Console    ${resposta}
    #Log To Console    ${resposta.json()}
    #Log To Console    ${resposta.json()["alert"]}


*** Keywords ***
Criar Sessao
    [Documentation]    Criando sessão inicial para usar nas proximas requests
    ${headers}    Create Dictionary    accept=applications/json    Content-Type=application/json
    Create Session    alias=ronbugado    url=${baseUrl}    headers=${headers}    verify=true


Pegar Token
    [Documentation]    Request usada para pegar o token do admin
    ${body}    Create Dictionary    
    ...    mail=sysadmin@qacoders.com
    ...    password=1234@Test
    Criar Sessao
    POST On Session    alias=ronbugado    url=/login    json=${body}


Realizar Login
    [Documentation]    Realizar Login
    [Arguments]    ${email}    ${senha}
    ${body}    Create Dictionary    
    ...    mail=${email}
    ...    password=${senha}
    Criar Sessao
    ${resposta}    POST On Session    alias=ronbugado    expected_status=any    url=/login    json=${body}
    RETURN    ${resposta}


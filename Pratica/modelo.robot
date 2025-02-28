*** Settings ***
Documentation    Configurações iniciais do projeto

## Importando as Bibliotecas
Library    RequestsLibrary

*** Variables ***
${baseUrl}    https://www.google.com


*** Test Cases ***
# CT01 - Caso de Teste 1
# CT02 - Caso de Teste 2


*** Keywords ***
Criar Sessao
    [Documentation]    Criando sessão inicial para usar nas proximas requests
    ${headers}    Create Dictionary    accept=applications/json    Content-Type=application/json
    Create Session    alias=testeinicial    url=${baseUrl}    headers=${headers}    verify=true

Pegar Token
    [Documentation]    Request usada para pegar o token do admin
    ${body}    Create Dictionary    
    ...    mail=teste@teste.com
    ...    password=1234@Test
    Criar Sessao
    POST On Session    alias=testeinicial    url=/login    json=${body}

Realizar Login
    [Documentation]    Realizar Login
    [Arguments]    ${email}    ${senha}
    ${body}    Create Dictionary    
    ...    mail=${email}
    ...    password=${senha}
    Criar Sessao
    ${resposta}    POST On Session    alias=testeinicial    expected_status=any    url=/login    json=${body}
    RETURN    ${resposta}
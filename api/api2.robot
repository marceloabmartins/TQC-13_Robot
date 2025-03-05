*** Settings ***
Documentation    Configurações iniciais do projeto

## Importando as Bibliotecas
Library    RequestsLibrary
Library    libs/get_fake_person.py
#Library    urllib3


*** Variables ***
${baseUrl}    https://ron-bugado.qacoders.dev.br/api/


*** Test Cases ***
# REQUEST POST
# CT01 - Realizar Login com sucesso
#     ${resposta}    Realizar Login    email=sysadmin@qacoders.com    senha=1234@Test
#     Status Should Be    200    ${resposta}

# CT02 - Realizar Login com senha inválida
#     ${resposta}    Realizar Login    email=sysadmin@qacoders.com    senha=1234@Tes
#     Status Should Be    400    ${resposta}

# CT03 - Realizar Login com email inválido
#     ${resposta}    Realizar Login    email=sysadmin@qacoders.com.br    senha=1234@Test
#     Status Should Be    400    ${resposta}
#     Should Be Equal    first=E-mail ou senha informados são inválidos.    second=${resposta.json()["alert"]}
#     #Log To Console    ${resposta}
#     #Log To Console    ${resposta.json()}
#     #Log To Console    ${resposta.json()["alert"]}

# REQUEST PUT
CT04 - Atualizar Status para false com sucesso
    # ${user_ID}    Create User
    ${resposta}    Put Status    id_user=679b7c76eb35b543c276b06c    status=false

*** Keywords ***
Criar Sessao
    [Documentation]    Criando sessão inicial para usar nas proximas requests
    ${headers}    Create Dictionary    accept=applications/json    Content-Type=application/json
    Create Session    alias=ronbugado    url=${baseUrl}    headers=${headers}    verify=true
    Log To Console    Loguei com sucesso!

Pegar Token
    [Documentation]    Request usada para pegar o token do admin
    ${body}    Create Dictionary    
    ...    mail=sysadmin@qacoders.com
    ...    password=1234@Test
    Criar Sessao
    ${resposta}    POST On Session    alias=ronbugado    url=/login    json=${body}
    RETURN    ${resposta.json()["token"]}
    Log To Console    Peguei com sucesso (la ele!)

# Realizar Login
#     [Documentation]    Realizar Login
#     [Arguments]    ${email}    ${senha}
#     ${body}    Create Dictionary    
#     ...    mail=${email}
#     ...    password=${senha}
#     Criar Sessao
#     ${resposta}    POST On Session    alias=ronbugado    expected_status=any    url=/login    json=${body}
#     RETURN    ${resposta}

# Create User
#     [Documentation]    Keyword que cria um usuário
#     ${token}    Pegar Token
#     ${headers}       Create Dictionary    Authorization=${token}    Content-Type=application/json
#     ${person}    Get Fake Person
#     #${token}    Pegar Token
#     ${body}    Create Dictionary
#     ...    fullName=${person}[name]
#     ...    mail=${person}[email]
#     ...    password=1234@Test
#     ...    accessProfile=ADMIN
#     ...    cpf=${person}[cpf]
#     ...    confirmPassword=1234@Test
#     ${resposta}    POST On Session    alias=ronbugado    url=/user    headers=${headers}    json=${body}
#     #${resposta}    POST On Session    alias=ronbugado    url=/user?token=${token}    json=${body}
#     Status Should Be    201    ${resposta}
#     RETURN    ${resposta.json()}["user"]["_id"]

# Cadastro Sucesso
#     ${uder_ID}    Create User

Put Status
    [Arguments]    ${id_user}    ${status}
    ${token}    Pegar Token
    Log To Console    ${token}    
    ${headers}       Create Dictionary    Authorization=${token}    Content-Type=application/json
    ${body}    Create Dictionary    status=${status}
    #
    ${resposta}    PUT On Session    alias=ronbugado    url=/user/status/679b7c76eb35b543c276b06c    json=${body}    headers=${headers}
    Log To Console    ${resposta.json()["token"]}
    RETURN    ${resposta.json()}
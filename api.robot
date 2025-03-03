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

# REQUEST PUT
CT04 - Atualizar Status para false com sucesso
    ${user_ID}    Create User
    ${resposta}    Put Status    id_user=${user_ID}    status=false
    Should Be Equal    Status do usuario atualizado com sucesso para status false.    ${resposta["msg"]}

# REQUEST GET
CT05 - Listar usuários com Sucesso
    ${token}    Pegar Token
    ${resposta}    GET On Session    alias=ronbugado    url=/user/?token=${token}
    Status Should Be    200    ${resposta}

# REQUEST DELETE
CT06 - Deletar usuário com Sucesso
    ${user_ID}    Create User
    ${resposta}    Delete User    id_user=${user_ID}
    Should Be Equal    Usuário deletado com sucesso!.    ${resposta.json()["MSG"]}

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
    ${resposta}    POST On Session    alias=ronbugado    url=/login    json=${body}
    RETURN    ${resposta.json()["token"]}

Realizar Login
    [Documentation]    Realizar Login
    [Arguments]    ${email}    ${senha}
    ${body}    Create Dictionary    
    ...    mail=${email}
    ...    password=${senha}
    Criar Sessao
    ${resposta}    POST On Session    alias=ronbugado    expected_status=any    url=/login    json=${body}
    RETURN    ${resposta}

Create User
    [Documentation]    Keyword que cria um usuário
    ${token}    Pegar Token
    ${headers}       Create Dictionary    Authorization=${token}    Content-Type=application/json
    ${person}    Get Fake Person
    #${token}    Pegar Token
    ${body}    Create Dictionary
    ...    fullName=${person}[name]
    ...    mail=${person}[email]
    ...    password=1234@Test
    ...    accessProfile=ADMIN
    ...    cpf=${person}[cpf]
    ...    confirmPassword=1234@Test
    ${resposta}    POST On Session    alias=ronbugado    url=/user    headers=${headers}    json=${body}
    #${resposta}    POST On Session    alias=ronbugado    url=/user?token=${token}    json=${body}
    Status Should Be    201    ${resposta}
    RETURN    ${resposta.json()}["user"]["_id"]

Delete user
    [Arguments]    ${id_user}
    ${token}    Pegar Token
    ${resposta}    DELETE On Session    alias=ronbugado    url=/user/${id_user}?token=${token}
    RETURN    ${resposta}

#Cadastro Sucesso
#${user_ID}    Create User

Put Status
    [Arguments]    ${id_user}    ${status}
    ${token}    Pegar Token
    ${headers}       Create Dictionary    Authorization=${token}    Content-Type=application/json
    ${body}    Create Dictionary    status=${status}
    #
    ${resposta}    PUT On Session    alias=ronbugado    url=/user/status/${id_user}    json=${body}    headers=${headers}
    Log To Console    ${resposta.json()["token"]}
    RETURN    ${resposta.json()}


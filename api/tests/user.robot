*** Settings ***
Resource    ../resources/users.robot

*** Test Cases ***
Criar usuário com sucesso
    Log To Console    message=Sucesso user

Pegar um usário por ID
    Log To Console    message=SUcesso ID

Listagem de usuários com sucesso
    [Tags]    Smnoke
    ${list_users}    List Users
    Log To Console    ${list_users}
    Should Be Equal As Strings    ${list_users[0]['_id']}
    


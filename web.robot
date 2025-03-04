*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://automacao.qacoders-academy.com.br/login
${BROWSER}    Chrome
${btn-entrar}    button[id=login]
${input_email}    input[id=email]
${input_senha}    input[id=password]
${div_cadastros}    span[class*=MuiTypography-root]
${msg_error}    div[class*=MuiAlert-standard]

*** Test Cases ***
CT01 - Realizar login com Sucesso
    Realizar login    email=sysadmin@qacoders.com    senha=1234@Test
    Wait Until Element Is Visible    css=${div_cadastros}
    Element Should Be Visible    css=${div_cadastros}
    Capture Element Screenshot    css=${div_cadastros}
    Capture Page Screenshot
    Sleep    5
    Fechar Navegador

CT02 - Realizar login com senha Inválida
    Realizar login    email=sysadmin@qacoders.com    senha=1234@Tests
    Wait Until Element Is Visible    css=${msg_error}
    Element Should Be Visible    css=${msg_error}
    Capture Element Screenshot    css=${msg_error}
    Capture Page Screenshot
    Fechar Navegador


*** Keywords ***
Realizar login
    [Documentation]    Keyowrd usada para relizar login, é obrigatorio 2 argumentos: [senha] e [email]
    [Arguments]    ${email}    ${senha}
    Abrir o navegador
    Input Text    css=${input_email}    ${email}
    Input Text    css=${input_senha}    ${senha}
    Click Button    css=${btn-entrar}

Abrir o navegador
    Open Browser    ${URL}    ${BROWSER}    #options=add_argument("--headless")
    Maximize Browser Window

Fechar Navegador
    Close Browser
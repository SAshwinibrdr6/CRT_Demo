*** Settings ***
Library                 QForce
Library                 QWeb
Library                 String

*** Variables ***
${home_url}               ${sf_login_url}/lightning/page/home


*** Keywords ***
Setup Browser
    Set Library Search Order            QWeb                    QForce
    Open Browser                        about:blank             chrome
    Set Config                          LineBreak               ${EMPTY}            #\ue000
    Set Config                          DefaultTimeout          20s                 # waits in case salesforce takes time to load

End Suite
    Set Library Search Order            QWeb                    QForce
    Close All Browsers

Login
    [Documentation]                    Login to Salesforce Environment
    Set Library Search Order           QWeb                    QForce
    GoTo                               ${sf_login_url}
    TypeText                           Username                ${sf_username}            
    TypeText                           Password                ${sf_password}   
    ClickText                          Log In

    #Login with MFA enabled
    ${mfa_code}=           GetOTP                      sheetalchougule360@agentforce.com        ${sf_mfasecret}    ${sf_login_url}
    ${login_status} =     IsNoText                    Seller Home
    Run Keyword If        ${login_status}             TypeSecret             Verification Code           ${mfa_code}
    Run Keyword If        ${login_status}             ClickText              Verify

Home
    [Documentation]       Navigate to homepage, login if needed
    Set Library Search Order                          QWeb                   QForce
    GoTo                  ${home_url}
    ${login_status} =     IsNoText                    Seller Home
    Run Keyword If        ${login_status}             Login
    ClickText             Home
    VerifyTitle           Home | Salesforce
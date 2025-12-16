*** Settings ***

Documentation           New test suite
Library                 QForce 
Suite Setup             Open Browser    about:blank    chrome
Suite Teardown          Close All Browsers

*** Variables ***
${login_url}            https://login.salesforce.com
${home_url}             https://login.salesforce.com/lightning/page/home
${secret}               FU3KTO2OWY27HPVSPR7FPMCYODQ66ECT

*** Keywords ***
Setup Browser
    Set Library Search Order            QWeb                    QForce
    Open Browser                        about:blank             chrome
    Set Config                          LineBreak               ${EMPTY}            #\ue000
    Set Config                          DefaultTimeout          20s                 # waits in case salesforce takes time to load

End Suite
    Set Library Search Order            QWeb                    QForce
    Close All Browsers

Login to Salesforce
    [Documentation]                    Login to Salesforce
    Set Library Search Order           QWeb                    QForce
    GoTo                               ${login_url}
    TypeText                           Username                     ashwinibrdr6807@agentforce.com   
    TypeText                           Password                     Sammu@2025
    ClickText                          Log In

    #Login with MFA enabled
    ${mfa_code}=          GetOTP                      ashwinibrdr6807@agentforce.com         ${secret}    ${login_url}
    ${login_status} =     IsNoText                    Seller Home
    Run Keyword If        ${login_status}             TypeSecret             Verification Code           ${mfa_code}
    Run Keyword If        ${login_status}             ClickText              Verify

Home
    [Documentation]       Navigate to homepage, login if needed
    Set Library Search Order                          QWeb                   QForce
    GoTo                  ${home_url}
    ${login_status} =     IsNoText                    Seller Home
    Run Keyword If        ${login_status}             Login to Salesforce
    ClickText             Home
    VerifyTitle           Home | Salesforce
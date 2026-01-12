*** Settings ***
Library                 QForce
Library                 QWeb
Library                 String

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
    [Documentation]                    Login to Salesforce Environment
    Set Library Search Order           QWeb                    QForce
    GoTo                               ${sf_login_url}
    TypeText                           Username                ${sf_username}            
    TypeText                           Password                ${sf_password}   
    ClickText                          Log In

    #Login with MFA enabled
    ${MFA_Needed}=                     Run Keyword And Return Status                Should Not Be Equal        ${None}        ${sf_mfasecret}
    Run Keyword If                     ${MFA_Needed}                                Generate MFA               ${sf_username}    ${sf_mfasecret}    ${sf_login_url}
    
Generate MFA
    [Documentation]                    Retrieve the OTP and Geneate MFA then Login
    [Arguments]                        ${username}=${sf_username}    ${secret_mfa}=${sf_mfasecret}    ${instance_url}=${sf_login_url}
    ${mfa_code}=                       GetOTP                      ${username}        ${secret_mfa}    ${instance_url}
    TypeSecret                         Verification Code           ${mfa_code}
    ClickText                          Verify

Create Unique Account
    [Arguments]                        ${Account_Name}            ${Unique_Id}
    ${unique_name}=                    Catenate                   ${Account_Name}  ${Unique_Id}
    Launch App                         Sales
    Click text                         Accounts
    Click text                         New
    UseModal                           On
    Sleep                              2s
    Wait Until Keyword Succeeds        1 min       5 sec    Type Text    Account Name    ${unique_name}
    
    RETURN                           ${unique_name}

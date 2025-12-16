*** Settings ***

Documentation           Single Data Driven testing scenario
# You can change imported library to "QWeb" if testing generic web application, not Salesforce.
Library                 QForce
Library                 QWeb
Resource                ../resources/common.robot
Suite Setup             Setup Browser
Suite Teardown          Close All Browsers


*** Test Cases ***
Login to Salesforce with MFA
    Login to Salesforce

Example test ${account_name} ${type} ${annual_revenue}
    # Your tests here, this is just an example
    # just use the values from excel using variable names
    # ClickText     ${account_name}
    # VerifyText    ${type}
    # VerifyText    ${annual_revenue}
    # VerifyText    ${industry}
    [Tags]             Account    Create New

    LaunchApp          Sales
    ClickText          Accounts
    Clicktext          New
    UseModal           On
    Sleep              1 sec
    
    TypeText           Name                       ${account_name}
    PickList           Type                       ${type}
    ClickText          Website
    TypeText           Website                    www.test.org
    PickList           Industry                   ${industry}
    TypeText           Annual Revenue            ${annual_revenue}
    ClickText          Save                       partial_match=false
    UseModal           Off
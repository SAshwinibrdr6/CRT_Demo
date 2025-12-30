*** Settings ***

Documentation           New test suite
# You can change imported library to "QWeb" if testing generic web application, not Salesforce.

Resource                ../resources/common.robot
Library                 QForce 
Library                 QWeb
Library                 DataDriver                    reader_class=TestDataApi            name=Account_Data1.csv


Suite Setup             Open Browser    about:blank    chrome
Suite Teardown          Close All Browsers
Test Template           Creating Account with Data

*** Test Cases ***
Home
    Home
Creating Account with Data ${account_name} ${type} ${annual_revenue} ${industry}
    # No implementation can be done under the Test Case. This should only have test case name
    # ClickText     ${account_name}
    # VerifyText    ${type}
    # VerifyText    ${annual_revenue}
    # VerifyText    ${industry}
    [Tags]          All Data

    
*** Keywords ***
Creating Account with Data
    # Implementation for the data driven test to be performed
    # The name of the keyword should match the Test Template Name
    [Arguments]       ${account_name}     ${type}     ${annual_revenue}     ${industry}
    
    
    ClickText          Accounts
    Clicktext          New
    UseModal           On
    Sleep              1 sec
    
    TypeText           Name                       ${account_name}
    PickList           Type                       ${type}
    ClickText          Website
    TypeText           Website                    www.test.org
    PickList           Industry                   ${industry}
    TypeText           Annual Revenue             ${annual_revenue}
    ClickText          Save                       partial_match=false
    UseModal           Off

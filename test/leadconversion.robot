*** Settings ***
Resource        ../resources/common.robot
Library         QWeb
Library         QForce
Library         DataDriver            reader_class=TestDataApi    name=Leads_for_Conversion.csv

Suite Setup       Open Browser        about:blank     Chrome
Suite Teardown    Close All Browsers
Test Template     Convert Lead With Data

*** Test Cases ***
Lead Conversion - ${FirstName}  ${LastName}   ${Company}   ${Industry}   ${LeadSource}   ${ExpectedAccount}   ${ExpectedOpportunity}

*** Keywords ***
Convert Lead With Data
    [Arguments]    ${FirstName}    ${LastName}    ${Company}    ${Industry}    ${LeadSource}    ${ExpectedAccount}    ${ExpectedOpportunity}
    # Your tests here, this is just an example
    # just use the values from excel using variable names
    # ClickText     ${FirstName}
    # VerifyText    ${LastName}
    # VerifyText    ${Company}
    # VerifyText    ${Industry}
    # VerifyText    ${LeadSource}

  # Step 1: Login
    Home

    # Step 2: Navigate to Leads
    LaunchApp             Sales
    ClickText          Leads

    # Step 3: Create Lead
    Click Text     New
    Type Text      First Name       ${FirstName}
    Type Text      Last Name        ${LastName}
    Type Text      Company          ${Company}
    Picklist       Industry         ${Industry}
    Picklist       Lead Source      ${LeadSource}
    Click Text     Save

    # Step 4: Convert
    Click Text     Convert
    Click Text     Convert

    # Step 5: Verify
    Verify Text    ${ExpectedAccount}
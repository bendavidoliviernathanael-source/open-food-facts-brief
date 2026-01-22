*** Settings ***
Library             AppiumLibrary

Test Teardown       Close Application
# Test Teardown    Terminate Application    openfoodfacts.github.scrachx.openfood

*** Test Cases ***
Recherche d'un produit par son code barre
    Launch App
    # page de recherche
    VAR    ${el11}        accessibility_id=Chercher un produit
    Wait Until Element Is Visible    accessibility_id=Chercher un produit    timeout=5s
    Click Element    ${el11}

    Wait Until Element Is Visible    class=android.widget.EditText    timeout=5s
    VAR    ${el12}        class=android.widget.EditText
    Click Element    ${el12}

    Input Text    ${el12}    3250391781966

    VAR    ${el13}    accessibility_id=Rechercher

    Click Element    ${el13}


*** Keywords ***
Launch App
    Open Application
    ...    http://127.0.0.1:4723
    ...    platformName=Android
    ...    appium:automationName=UIAutomator2
    ...    appium:appPackage=openfoodfacts.github.scrachx.openfood
    # ...    appium:appActivity=.MainActivity
    ...    appium:noReset=true

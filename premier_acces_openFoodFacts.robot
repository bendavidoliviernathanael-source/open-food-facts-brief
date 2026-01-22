*** Settings ***
Library             AppiumLibrary

# Test Teardown       Close Application
# Test Teardown    Terminate Application    openfoodfacts.github.scrachx.openfood


*** Test Cases ***
Login
    # précondition: la localisation est en English(United States) dans les paramètres système de l'émulateur

    # Premier accès à l'application OpenFoodFacts
    Launch App

    VAR    ${el1} =    accessibility_id=Continue
    Wait Until Element Is Visible    accessibility_id=Continue    timeout=5s
    Click Element    ${el1}

    Click Element    xpath=//*[contains(@content-desc, "United States")]

    VAR    ${el3} =    class=android.widget.EditText
    Click Element    ${el3}
    Input Text    ${el3}    france

    VAR    ${el4} =    accessibility_id=OpenFoodFactsCountry.FRANCE
    Wait Until Element Is Visible    accessibility_id=OpenFoodFactsCountry.FRANCE    timeout=5s
    Click Element    ${el4}

    VAR    ${el5} =    accessibility_id=Next
    Click Element    ${el5}

    Wait Until Element Is Visible    accessibility_id=Next    timeout=5s
    VAR    ${el6} =    accessibility_id=Next
    Click Element    ${el6}

    VAR    ${el7} =    accessibility_id=Next
    Click Element    ${el7}

    VAR    ${el8} =       accessibility_id=Next
    Wait Until Element Is Visible    accessibility_id=Next    timeout=5s
    Click Element    ${el8}

    VAR    ${el9} =       accessibility_id=Authorize
    Wait Until Element Is Visible    accessibility_id=Authorize    timeout=5s
    Click Element    ${el9}

    VAR    ${el10} =     id=com.android.permissioncontroller:id/permission_allow_foreground_only_button
    Wait Until Element Is Visible
    ...    id=com.android.permissioncontroller:id/permission_allow_foreground_only_button
    ...    timeout=5s

    Click Element    ${el10}
    Sleep    10s

Accès à la page d'accueil en français
    # précondition: la localisation est en Français dans les paramètres système de l'émulateur

    # Premier accès à l'application OpenFoodFacts
    Launch App

    VAR    ${el1} =    accessibility_id=Continuer
    Wait Until Element Is Visible    accessibility_id=Continuer    timeout=10s
    Click Element    ${el1}

    VAR    ${el5} =    accessibility_id=Suivant
    Click Element    ${el5}

    Wait Until Element Is Visible    accessibility_id=Suivant    timeout=10s
    VAR    ${el6} =    accessibility_id=Suivant
    Click Element    ${el6}

    VAR    ${el7} =       accessibility_id=Suivant
    Click Element    ${el7}

    Wait Until Element Is Visible    accessibility_id=Suivant    timeout=5s
    VAR    ${el8} =        accessibility_id=Suivant
    #    Wait Until Element Is Visible    accessibility_id=Suivant    timeout=10s
    Click Element    ${el8}

    VAR    ${el9} =        accessibility_id=Autoriser
    Wait Until Element Is Visible    accessibility_id=Autoriser    timeout=10s
    Click Element    ${el9}

    VAR    ${el10} =    id=com.android.permissioncontroller:id/permission_allow_foreground_only_button
    Wait Until Element Is Visible
    ...    id=com.android.permissioncontroller:id/permission_allow_foreground_only_button
    ...    timeout=10s

    Click Element    ${el10}

    Sleep     10s


*** Keywords ***
Launch App
    Open Application
    ...    http://127.0.0.1:4723
    ...    platformName=Android
    ...    appium:automationName=UIAutomator2
    ...    appium:appPackage=openfoodfacts.github.scrachx.openfood
    # ...    appium:appActivity=.MainActivity
    ...    appium:noReset=false

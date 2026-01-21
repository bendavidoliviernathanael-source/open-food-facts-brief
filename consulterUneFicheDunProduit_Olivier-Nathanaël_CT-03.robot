*** Settings ***
Library             AppiumLibrary

Test Teardown       Close Application


*** Variables ***

*** Test Cases ***


Verifier que consulter une fiche produit permet daccéder a plusieurs informations concernant ce produit
    Demarrer openfoodfacts
    Faire une configuration initiale
    Chercher un produit   coca cola

    ${el4} =    Set Variable    android=new UiSelector().description("Photo du produit (recto)").instance(0)
    Click Element    ${el4}


*** Keywords ***
Demarrer openfoodfacts
    Open Application
    ...    http://127.0.0.1:4723
    ...    platformName=Android
    ...    appium:automationName=UIAutomator2
    ...    appium:appPackage=openfoodfacts.github.scrachx.openfood
    ...    appium:noReset=${False}
    ...    appium:fullReset=${False}
    ...    appium:ensureWebviewsHavePages=${True}
    ...    appium:nativeWebScreenshot=${True}
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}

Faire une configuration initiale
    ${el1}    Set Variable    accessibility_id=Continuer
    Wait Until Element Is Visible    accessibility_id=Continuer    timeout=10s
    Click Element    ${el1}

    ${el2} =    Set Variable    accessibility_id=Suivant
    Wait Until Element Is Visible    accessibility_id=Suivant    timeout=10s
    Click Element    ${el2}

    ${el3} =    Set Variable    accessibility_id=Suivant
    Wait Until Element Is Visible    accessibility_id=Suivant    timeout=10s
    Click Element    ${el3}

    ${el4} =    Set Variable    accessibility_id=Suivant
    Wait Until Element Is Visible    accessibility_id=Suivant    timeout=10s
    Click Element    ${el4}

    ${el5} =    Set Variable    accessibility_id=Suivant
    Wait Until Element Is Visible    accessibility_id=Suivant    timeout=10s
    Click Element    ${el5}

    ${el6} =    Set Variable    accessibility_id=Plus tard
    Wait Until Element Is Visible    accessibility_id=Plus tard    timeout=10s
    Click Element    ${el6}

Chercher un produit
    [Arguments]    ${nomProduit}

    ${el1} =    Set Variable    accessibility_id=Chercher un produit

    Click Element    ${el1}

    ${el2} =    Set Variable    class=android.widget.EditText

    Input Text    ${el2}    ${nomProduit}

    ${el3} =    Set Variable    accessibility_id=Rechercher

    Click Element    ${el3}

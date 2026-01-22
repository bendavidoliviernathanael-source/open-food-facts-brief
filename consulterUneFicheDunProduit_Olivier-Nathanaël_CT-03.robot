*** Settings ***
Library             AppiumLibrary

Test Teardown       Terminate Application    openfoodfacts.github.scrachx.openfood


*** Test Cases ***
Consulter une fiche produit test 1
    Skip
    ...    Vérifier que consulter une fiche produit permet d'accéder à plusieurs informations concernant ce produit (premier démarrage)

Consulter une fiche produit test 2
    Vérifier que consulter une fiche produit permet d'accéder à plusieurs informations concernant ce produit


*** Keywords ***
Démarrer openfoodfacts (premier démarrage)
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

Démarrer openfoodfacts
    Open Application
    ...    http://127.0.0.1:4723
    ...    platformName=Android
    ...    appium:automationName=UIAutomator2
    ...    appium:appPackage=openfoodfacts.github.scrachx.openfood
    ...    appium:noReset=${True}
    ...    appium:fullReset=${False}
    ...    appium:ensureWebviewsHavePages=${True}
    ...    appium:nativeWebScreenshot=${True}
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}

Faire une configuration initiale
    ${el1} =    Set Variable    accessibility_id=Continuer
    ${el2} =    Set Variable    accessibility_id=Suivant
    ${el3} =    Set Variable    accessibility_id=Plus tard

    Wait Until Element Is Visible    ${el1}    timeout=10s
    Click Element    ${el1}

    Wait Until Element Is Visible    ${el2}    timeout=10s
    Click Element    ${el2}

    Wait Until Element Is Visible    ${el2}    timeout=10s
    Click Element    ${el2}

    Wait Until Element Is Visible    ${el2}    timeout=10s
    Click Element    ${el2}

    Wait Until Element Is Visible    ${el2}    timeout=10s
    Click Element    ${el2}

    Wait Until Element Is Visible    ${el3}    timeout=10s
    Click Element    ${el3}

Chercher un produit
    [Arguments]    ${nomProduit}

    ${el1} =    Set Variable    accessibility_id=Chercher un produit
    Wait Until Element Is Visible    ${el1}    timeout=10s
    Click Element    ${el1}

    ${el2} =    Set Variable    class=android.widget.EditText
    Wait Until Element Is Visible    ${el2}    timeout=10s
    Input Text    ${el2}    ${nomProduit}

    ${el3} =    Set Variable    accessibility_id=Rechercher
    Wait Until Element Is Visible    ${el3}    timeout=10s
    Click Element    ${el3}

Vérifier que consulter une fiche produit permet d'accéder à plusieurs informations concernant ce produit (premier démarrage)
    Démarrer openfoodfacts (premier démarrage)
    Faire une configuration initiale
    Chercher un produit    coca cola

    ${el4} =    Set Variable    android=new UiSelector().description("Photo du produit (recto)").instance(0)
    Wait Until Element Is Visible    ${el4}    timeout=10s
    Click Element    ${el4}

    # assertion 1 : la page devrait contenir le texte Goût Original
    Page Should Contain Text    Goût Original
    # assertion 2 : l'élément avec ce xpath a un attribut dont la valeur devrait être égale à Goût Original
    ${el5} =    Set Variable    xpath=//android.view.View[@content-desc="Goût Original"]
    Wait Until Element Is Visible    ${el5}    10s
    ${desc} =    Get Element Attribute    ${el5}    content-desc
    Should Be Equal    ${desc}    Goût Original
    # assertion 3 : la page contient un élément avec un accessibility_id égal à Goût Original
    ${el6} =    Set Variable    accessibility_id=Goût Original
    Page Should Contain Element    ${el6}

Vérifier que consulter une fiche produit permet d'accéder à plusieurs informations concernant ce produit
    Démarrer openfoodfacts
    Chercher un produit    coca cola

    ${el4} =    Set Variable    android=new UiSelector().description("Photo du produit (recto)").instance(0)
    Wait Until Element Is Visible    ${el4}    timeout=10s
    Click Element    ${el4}

    # assertion 1 : la page devrait contenir le texte Goût Original
    Page Should Contain Text    Goût Original
    # assertion 2 : l'élément avec ce xpath a un attribut dont la valeur devrait être égale à Goût Original
    ${el5} =    Set Variable    xpath=//android.view.View[@content-desc="Goût Original"]
    Wait Until Element Is Visible    ${el5}    10s
    ${desc} =    Get Element Attribute    ${el5}    content-desc
    Should Be Equal    ${desc}    Goût Original
    # assertion 3 : la page contient un élément avec un accessibility_id égal à Goût Original
    ${el6} =    Set Variable    accessibility_id=Goût Original
    Page Should Contain Element    ${el6}

    # la page contient un onglet santé
    Page Should Contain Text    Santé
    ${el7} =    Set Variable    //android.view.View[@content-desc="Santé\nOnglet 1 sur 6"]
    Wait Until Element Is Visible    ${el7}    10s
    ${desc} =    Get Element Attribute    ${el7}    content-desc
    Should Be Equal    ${desc}    Santé\nOnglet 1 sur 6

    # la page contient une rubrique nutrition (qui contient l'information nutriscore)
    Page Should Contain Text    Nutrition
    ${el7} =    Set Variable    //android.view.View[@content-desc="Nutrition"]
    Wait Until Element Is Visible    ${el7}    10s
    ${desc} =    Get Element Attribute    ${el7}    content-desc
    Should Be Equal    ${desc}    Nutrition

    # la page contient une rubrique Ingrédients (qui contient l'information quantité d'ingrédients)
    Page Should Contain Text    Ingrédients
    ${el7} =    Set Variable    //android.view.View[@content-desc="Ingrédients"]
    Wait Until Element Is Visible    ${el7}    10s
    ${desc} =    Get Element Attribute    ${el7}    content-desc
    Should Be Equal    ${desc}    Ingrédients

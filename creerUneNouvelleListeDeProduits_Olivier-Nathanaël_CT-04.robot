*** Settings ***
Library             AppiumLibrary

Test Teardown       Terminate Application    openfoodfacts.github.scrachx.openfood


*** Test Cases ***
Créer une nouvelle liste de produits
    Vérifier que créer une nouvelle liste de produits permet d'ajouter cette liste à sa collection de listes

Supprimer une liste de produits
    Supprimer la liste Liste A


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

Vérifier que créer une nouvelle liste de produits permet d'ajouter cette liste à sa collection de listes
    Démarrer openfoodfacts

    # Appuyer sur le bouton Listes en bas à droite de l'écran d'accueil    bouton : Listes
    ${elt} =    Set Variable    accessibility_id=Listes
    Wait Until Element Is Visible    ${elt}    timeout=10s
    Click Element    ${elt}
    # Un écran affichant une liste est obtenu. Le nom de la liste est inscrit en haut de l'écran.
    # Un élément avec l'accessibility_id Afficher le menu est visible sur l'écran (élément qui permet d'identifier cet écran par rapport aux écrans Scanner et Communauté)
    Wait Until Element Is Visible    accessibility_id=Afficher le menu    10s

    # Appuyer sur le nom de la liste affichée
    ${elt} =    Set Variable    android=new UiSelector().className("android.widget.Button").instance(0)
    Wait Until Element Is Visible    ${elt}    timeout=10s
    Click Element    ${elt}
    # Une pop up apparaît avec le texte Sélectionner une liste
    ${elt} =    Set Variable    accessibility_id=Sélectionner une liste
    Wait Until Element Is Visible    ${elt}    timeout=10s
    ${desc} =    Get Element Attribute    ${elt}    content-desc
    Should Be Equal    ${desc}    Sélectionner une liste

    # Appuyer sur le bouton créer    bouton : Créer
    ${elt} =    Set Variable    accessibility_id=Créer une nouvelle liste
    Wait Until Element Is Visible    ${elt}    timeout=10s
    Click Element    ${elt}
    # Une pop up apparaît avec le texte Nouvelle liste de produits
    ${elt} =    Set Variable    accessibility_id=Nouvelle liste de produits
    Wait Until Element Is Visible    ${elt}    timeout=10s
    ${desc} =    Get Element Attribute    ${elt}    content-desc
    Should Be Equal    ${desc}    Nouvelle liste de produits

    # Saisir Liste A dans le champ de saisie    nom de la liste : Liste A
    ${elt} =    Set Variable    class=android.widget.EditText
    Wait Until Element Is Visible    ${elt}    timeout=10s
    Input Text    ${elt}    Liste A
    # Le champ de saisie contient la valeur Liste A
    Element Text Should Be    ${elt}    Liste A

    # Appuyer sur le bouton créer    bouton : Créer
    ${elt} =    Set Variable    accessibility_id=Créer
    Wait Until Element Is Visible    ${elt}    timeout=10s
    Click Element    ${elt}
    # Le nom de la liste créée Liste A apparaît dans la pop up sélectionner une liste
    Page Should Contain Text    Liste A

Supprimer la liste Liste A
    Démarrer openfoodfacts

    # Appuyer sur le bouton Listes en bas à droite de l'écran d'accueil    bouton : Listes
    ${elt} =    Set Variable    accessibility_id=Listes
    Wait Until Element Is Visible    ${elt}    timeout=10s
    Click Element    ${elt}
    # Un écran affichant une liste est obtenu. Le nom de la liste est inscrit en haut de l'écran.
    # Un élément avec l'accessibility_id Afficher le menu est visible sur l'écran (élément qui permet d'identifier cet écran par rapport aux écrans Scanner et Communauté)
    Wait Until Element Is Visible    accessibility_id=Afficher le menu    10s

    # Appuyer sur le nom de la liste affichée
    # Appuyer sur l'élément qui est de type bouton et qui est l'instance 0
    ${elt} =    Set Variable    android=new UiSelector().className("android.widget.Button").instance(0)
    Wait Until Element Is Visible    ${elt}    timeout=10s
    Click Element    ${elt}
    # Une pop up apparaît avec le texte Sélectionner une liste
    ${elt} =    Set Variable    accessibility_id=Sélectionner une liste
    Wait Until Element Is Visible    ${elt}    timeout=10s
    ${desc} =    Get Element Attribute    ${elt}    content-desc
    Should Be Equal    ${desc}    Sélectionner une liste

    # Appuyer sur le bouton Afficher le menu (représenté par ... verticaux) sur la droite de la ligne Liste A
    ${elt} =    Set Variable    xpath=(//android.widget.Button[@content-desc="Afficher le menu"])[1]
    Wait Until Element Is Visible    ${elt}    timeout=10s
    Click Element    ${elt}
    # Une pop up est obtenue avec le bouton supprimer
    ${elt} =    Set Variable    accessibility_id=Supprimer
    Wait Until Element Is Visible    ${elt}    timeout=10s

    # Appuyer sur le bouton Supprimer
    ${elt} =    Set Variable    accessibility_id=Supprimer
    Wait Until Element Is Visible    ${elt}    timeout=10s
    Click Element    ${elt}
    # Une pop up avec le texte Supprimer la liste ? est obtenue
    Page Should Contain Text    Supprimer la liste ?

    # Appuyer sur le bouton OUI, JE CONFIRME
    ${elt} =    Set Variable    accessibility_id=Oui, je confirme
    Wait Until Element Is Visible    ${elt}    timeout=10s
    Click Element    ${elt}
    # Une liste de listes sans liste A est obtenue
    Page Should Not Contain Text    Liste A

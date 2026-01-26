*** Settings ***
Library             AppiumLibrary

Suite Setup         Open My Application
Suite Teardown      Close Application
Test Teardown       Terminate Application    openfoodfacts.github.scrachx.openfood


*** Variables ***
${APPIUM_SERVER}    http://127.0.0.1:4723

&{CAPS}
...                 platformName=Android
...                 automationName=UiAutomator2
...                 appPackage=openfoodfacts.github.scrachx.openfood
...                 noReset=${TRUE}
...                 fullReset=${FALSE}


*** Test Cases ***
CT-06 Création d'un compte utilisateur depuis le mode DEV de l'application Open Food Facts
    ${Bouton_Communauté} =    Set Variable    accessibility_id=Communauté
    Click Element    ${Bouton_Communauté}

    ${Créer_un_compte} =    Set Variable    accessibility_id=Créer un compte
    Click Element    ${Créer_un_compte}

    ${Champ_Nom} =    Set Variable    android=new UiSelector().className("android.widget.EditText").instance(0)
    Click Element    ${Champ_Nom}
    Input Text    ${Champ_Nom}    NOUVEAU2

    ${Champ-Email} =    Set Variable    android=new UiSelector().className("android.widget.EditText").instance(1)
    Click Element    ${Champ-Email}
    Input Text    ${Champ-Email}    nouveau2@yahoo.fr

    ${Nom_Utilisateur} =    Set Variable    android=new UiSelector().className("android.widget.EditText").instance(2)
    Click Element    ${Nom_Utilisateur}
    Input Text    ${Nom_Utilisateur}    nouveaux

    ${Mot_de_Passe} =    Set Variable    android=new UiSelector().className("android.widget.EditText").instance(3)
    Click Element    ${Mot_de_Passe}
    Input Text    ${Mot_de_Passe}    Nouveau!

    ${Confirmation_MDP} =    Set Variable    android=new UiSelector().className("android.widget.EditText").instance(4)
    Click Element    ${Confirmation_MDP}
    Input Text    ${Confirmation_MDP}    Nouveau!

    ${Condditions_Utilisation} =    Set Variable    android=new UiSelector().description("Je suis d'accord avec les ")
    Click Element    ${Condditions_Utilisation}

    ${Producteur_Alimentaire} =    Set Variable    accessibility_id=Je suis un producteur alimentaire
    Click Element    ${Producteur_Alimentaire}

    ${Nom_du_Producteur} =    Set Variable    android=new UiSelector().className("android.widget.EditText").instance(5)
    Click Element    ${Nom_du_Producteur}
    Input Text    ${Nom_du_Producteur}    Les Gateaux du week-end

    ${Newsletter} =    Set Variable
    ...    accessibility_id=Je souhaite m'inscrire à la newsletter Open Food Facts (Vous pouvez vous désinscrire à tout moment)
    Click Element    ${Newsletter}

    ${Bouton_Inscription} =    Set Variable    accessibility_id=S'inscrire
    Click Element    ${Bouton_Inscription}

    # Message de succès sur une pop-up
    ${Popup_Success} =    Set Variable
    ...    xpath=//*[contains(@content-desc,"Toutes nos félicitations") and contains(@content-desc,"vient d'être créé")]
    Wait Until Element Is Visible    ${Popup_Success}    20s

    # Vérifier la présence du bouton Ok
    Wait Until Page Contains Element    accessibility_id=Ok    10s

    # Cliquer sur le bouton Ok
    Click Element    accessibility_id=Ok

    # Se deconnecter du compte
    ${Gerer_Votre_Compte} =    Set Variable    accessibility_id=Gérez votre compte
    Click Element    ${Gerer_Votre_Compte}
    ${Se_Deconecter} =    Set Variable    accessibility_id=Se déconnecter
    Click Element    ${Se_Deconecter}
    ${Confirmation_Deconnection} =    Set Variable    accessibility_id=Oui
    Click Element    ${Confirmation_Deconnection}


*** Keywords ***
Open My Application
    Open Application    ${APPIUM_SERVER}    &{CAPS}

*** Settings ***
Library             String
Library             FakerLibrary    locale=fr_FR
Library             AppiumLibrary

Suite Setup         Open My Application
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
CT-06 Création d'un compte utilisateur + déconnexion + reconnection
    # Génération des données dynamiques
    ${NOM_COMPLET} =    Name
    ${PSEUDO} =    Generate Unique Username
    ${EMAIL} =    Generate Yahoo Email From Username    ${PSEUDO}
    ${MOT_DE_PASSE} =    Generate Random String    12    [LETTERS][NUMBERS]
    ${NOM_PRODUCTEUR} =    Generate Unique Producer Name

    # Affichage des infos sur la console
    Log    Nom complet: ${NOM_COMPLET}
    Log    Pseudo: ${PSEUDO}
    Log    Email: ${EMAIL}
    Log    MDP: ${MOT_DE_PASSE}
    Log    Producteur: ${NOM_PRODUCTEUR}

    # Acces a l'onglet "Communauté"
    ${Bouton_Communauté} =    Set Variable    accessibility_id=Communauté
    Click Element    ${Bouton_Communauté}

    # Click sur "Créer un compte"
    ${Créer_un_compte} =    Set Variable    accessibility_id=Créer un compte
    Click Element    ${Créer_un_compte}

    # Nom complet
    ${Champ_Nom} =    Set Variable    android=new UiSelector().className("android.widget.EditText").instance(0)
    Click Element    ${Champ_Nom}
    Input Text    ${Champ_Nom}    ${NOM_COMPLET}

    # Email complet
    ${Champ_Email} =    Set Variable    android=new UiSelector().className("android.widget.EditText").instance(1)
    Click Element    ${Champ_Email}
    Input Text    ${Champ_Email}    ${EMAIL}

    # Nom d'utilisateur ou pseudo
    ${Nom_Utilisateur} =    Set Variable    android=new UiSelector().className("android.widget.EditText").instance(2)
    Click Element    ${Nom_Utilisateur}
    Input Text    ${Nom_Utilisateur}    ${PSEUDO}

    # Mot de passe 1
    ${Mot_de_Passe} =    Set Variable    android=new UiSelector().className("android.widget.EditText").instance(3)
    Click Element    ${Mot_de_Passe}
    Input Text    ${Mot_de_Passe}    ${MOT_DE_PASSE}

    # Mot de passe 2 pour vérification
    ${Confirmation_MDP} =    Set Variable    android=new UiSelector().className("android.widget.EditText").instance(4)
    Click Element    ${Confirmation_MDP}
    Input Text    ${Confirmation_MDP}    ${MOT_DE_PASSE}

    # Acceptation conditions d'utilisation en cliquant sur le switch + vérif
    ${Condditions_Utilisation} =    Set Variable    android=new UiSelector().description("Je suis d'accord avec les ")
    Click Element    ${Condditions_Utilisation}

    # Je suis un producteur alimentaire en cliquant sur le switch + vérif
    ${Producteur_Alimentaire} =    Set Variable    accessibility_id=Je suis un producteur alimentaire
    Click Element    ${Producteur_Alimentaire}

    # Cliquer sur le champ et nom complet du producteur
    ${Nom_du_Producteur} =    Set Variable    android=new UiSelector().className("android.widget.EditText").instance(5)
    Click Element    ${Nom_du_Producteur}
    Input Text    ${Nom_du_Producteur}    ${NOM_PRODUCTEUR}

    # Accepter de s'inscrire à la newsletter en cliquant sur le switch
    ${Newsletter} =    Set Variable
    ...    accessibility_id=Je souhaite m'inscrire à la newsletter Open Food Facts (Vous pouvez vous désinscrire à tout moment)
    Click Element    ${Newsletter}

    # Cliquer sur le bouton S'inscire
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

    # Se reconnecter avec les identifiants
    ${Se_connecter} =    Set Variable    accessibility_id=Se connecter
    Click Element    ${Se_connecter}

    ${Champ_Pseudo_Ou_Email} =    Set Variable
    ...    android=new UiSelector().className("android.widget.EditText").instance(0)
    Click Element    ${Champ_Pseudo_Ou_Email}
    Input Text    ${Champ_Pseudo_Ou_Email}    ${PSEUDO}

    ${Mot_de_Passe_Reconexion} =    Set Variable
    ...    android=new UiSelector().className("android.widget.EditText").instance(1)
    Click Element    ${Mot_de_Passe_Reconexion}
    Input Text    ${Mot_de_Passe_Reconexion}    ${MOT_DE_PASSE}

    ${Bouton_Se_connecter} =    Set Variable    android=new UiSelector().description("Se connecter")
    Click Element    ${Bouton_Se_connecter}

    Sleep    10s

    # Vérifier que le Pseudo ou Nom d'utilisateur est bien affiché sur la page
    ${Pseudo_Affiche} =    Set Variable    xpath=//android.view.View[@content-desc="${PSEUDO}"]

    Wait Until Element Is Visible    ${Pseudo_Affiche}    10s


*** Keywords ***
Generate Unique Username
    ${base} =    User Name
    ${random} =    Generate Random String    4    [NUMBERS]
    ${pseudo} =    Set Variable    ${base}${random}
    RETURN    ${pseudo}

Generate Yahoo Email From Username
    [Documentation]    Génère email
    [Arguments]    ${username}
    ${email} =    Set Variable    ${username}@yahoo.fr
    RETURN    ${email}

Generate Unique Producer Name
    [Documentation]    Génère un nom de producteur
    ${company} =    Company
    ${suffix} =    Generate Random String    4    [UPPER][NUMBERS]
    ${producer} =    Set Variable    ${company} ${suffix}
    RETURN    ${producer}

Open My Application
    Open Application    ${APPIUM_SERVER}    &{CAPS}

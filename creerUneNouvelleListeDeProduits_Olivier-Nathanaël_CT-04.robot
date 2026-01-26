*** Settings ***
Library     AppiumLibrary
Resource  keywords_communs_Olivier-Nathanaël.robot

Test Teardown       Terminate Application    openfoodfacts.github.scrachx.openfood


*** Test Cases ***
Créer une nouvelle liste de produits
    Vérifier que créer une nouvelle liste de produits permet d'ajouter cette liste à sa collection de listes

Supprimer une liste de produits
    Supprimer la première liste de la liste de listes


*** Keywords ***
Vérifier que créer une nouvelle liste de produits permet d'ajouter cette liste à sa collection de listes
    Démarrer openfoodfacts    ${True}

    # Appuyer sur le bouton Listes en bas à droite de l'écran d'accueil    bouton : Listes
    Appuyer sur un bouton visible    accessibility_id=Listes
    # Un écran affichant une liste est obtenu. Le nom de la liste est inscrit en haut de l'écran.
    # Un élément avec l'accessibility_id Afficher le menu est visible sur l'écran (élément qui permet d'identifier cet écran par rapport aux écrans Scanner et Communauté)
    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale
    ...    accessibility_id=Afficher le menu
    ...    10s

    # Appuyer sur le nom de la liste affichée
    Appuyer sur un bouton visible    android=new UiSelector().className("android.widget.Button").instance(0)
    # Une pop up apparaît avec le texte Sélectionner une liste
    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale
    ...    accessibility_id=Sélectionner une liste
    ...    10s
    Vérifier que l'écran contient un texte    Sélectionner une liste

    # Appuyer sur le bouton créer    bouton : Créer
    Appuyer sur un bouton visible    accessibility_id=Créer une nouvelle liste
    # Une pop up apparaît avec le texte Nouvelle liste de produits
    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale
    ...    accessibility_id=Nouvelle liste de produits
    ...    10s
    Vérifier que l'écran contient un texte    Nouvelle liste de produits

    # Saisir Liste A dans le champ de saisie    nom de la liste : Liste A
    Saisir un texte dans une zone de saisie visible    Liste A    class=android.widget.EditText
    # Le champ de saisie contient la valeur Liste A
    Vérifier que un élément a un texte    class=android.widget.EditText    Liste A

    # Appuyer sur le bouton créer    bouton : Créer
    Appuyer sur un bouton visible    accessibility_id=Créer
    # Le nom de la liste créée Liste A apparaît dans la pop up sélectionner une liste
    Vérifier que l'écran contient un texte    Liste A

    # patienter
    Démarrer une attente pendant une durée  2s

Supprimer la première liste de la liste de listes
    Démarrer openfoodfacts    ${True}

    # Appuyer sur le bouton Listes en bas à droite de l'écran d'accueil    bouton : Listes
    Appuyer sur un bouton visible    accessibility_id=Listes
    # Un écran affichant une liste est obtenu. Le nom de la liste est inscrit en haut de l'écran.
    # Un élément avec l'accessibility_id Afficher le menu est visible sur l'écran (élément qui permet d'identifier cet écran par rapport aux écrans Scanner et Communauté)
    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale
    ...    accessibility_id=Afficher le menu
    ...    10s

    # Appuyer sur le nom de la liste affichée
    # Appuyer sur l'élément qui est de type bouton et qui est l'instance 0
    Appuyer sur un bouton visible    android=new UiSelector().className("android.widget.Button").instance(0)
    # Une pop up apparaît avec le texte Sélectionner une liste
    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale
    ...    accessibility_id=Sélectionner une liste
    ...    10s
    Vérifier que l'écran contient un texte    Sélectionner une liste

    # Appuyer sur le bouton Afficher le menu (représenté par ... verticaux) sur la droite de la ligne Liste A
    Appuyer sur un bouton visible    xpath=(//android.widget.Button[@content-desc="Afficher le menu"])[1]
    # Une pop up est obtenue avec le bouton supprimer
    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale    accessibility_id=Supprimer  10s

    # Appuyer sur le bouton Supprimer
    Appuyer sur un bouton visible    accessibility_id=Supprimer
    # Une pop up avec le texte Supprimer la liste ? est obtenue
    Vérifier que l'écran contient un texte    Supprimer la liste ?

    # Appuyer sur le bouton OUI, JE CONFIRME
    Appuyer sur un bouton visible    accessibility_id=Oui, je confirme
    # Une liste de listes sans liste A est obtenue
    Vérifier que l'écran ne contient pas un texte    Liste A

    # patienter
    Démarrer une attente pendant une durée  2s

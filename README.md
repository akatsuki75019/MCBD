# MCBD Shop - Librairie Paris

#### Avant-propos :
  * Github de l'équipe : [MCBD](https://github.com/akatsuki75019/MCBD)
  * Notion de l'équipe (gestion de projet) : [Projet Final Fullstack](https://little-self-taught-chameleon.notion.site/Projet-final-fullstack-af79220fcb33424899d3cfd75030d07d?pvs=4)
  * MCBD Shop en production : [MCBD App](https://mcbd-a75a07330df5.herokuapp.com/) 


## À propos de MCBD Shop 

MCBD App est une application rails 7 développée pour une petite librairie parisienne spécialisée dans la vente de Mangas, Comics et Bandes Dessinées.


## Fonctionnalités

### 1. Gestion des utilisateurs :
  * Inscription, connexion et déconnexion des utilisateurs,
  * Profil utilisateur avec possibilité de modification du mot de passe et de l'adresse e-mail,
  * Collecte d'informations supplémentaires telles que l'année de naissance, le nom et le prénom (pour une expérience utilisateur renforcée et la création d'une communauté).
### 2. Catalogue de livres :
  * Consultation des derniers livres reçus sur la page d'accueil,
  * Affichage de tous les livres en stock, organisés par catégories,
  * Consultation des détails d'un livre sur la page dédiée,
  * Ajout d'un ou plusieurs livres au panier, avec la possibilité de faire un achat express.
### 3. Gestion du panier :
  * Intégration du service de paiement Stripe pour les transactions,
  * Modification des quantités et/ou suppression d'un ou plusieurs produits.
### 4. Événements :
  * Affichage de tous les événements sur la page "Événements",
  * Accès à des informations détaillées sur un événement sur la page dédiée,
  * Inscription aux événements.
### 5. Autres pages :
  * Accès à des à des informations telles que les conditions générales de vente, la page de contact, la politique RGPD et les mentions légales.
### 6. Tableau de bord administrateur (géré par Administrate) :
  * Gestion complète des événements : création, modification, suppression,
  * Gestion complète des livres : création, modification, suppression,
  * Gestion complète des commandes : visualisation, modification, suppression,
  * Gestion des utilisateurs : modification, suppression,
  * Visualisation des paniers et des listes de souhait (possibilité plus tard de créer des emails automatiques pour relancer quand produit dans panier et/ou proposer des remises).
### 7. Responsive Design :
  * Adapté pour tous les appareils avec une sidebar et une navbar sur la version bureau, et seulement une sidebar sur mobile.


## Technologies utilisées

* Back-End : Ruby "3.2.2" et Rails "7.1.2"
* Framework Front-End : Bootstrap avec des templates personnalisés
* Base de Données : PostgreSQL
* Système de Paiement : Stripe
* Hébergement : Heroku
* Scraping des informations des livres : GoogleBooks API 

## Gems Utilisées
* administrate
* cloudinary
* csv
* devise
* dotenv-rails
* googlebooks
* letter_opener (en développement)
* pg_search
* rails-i18n
* stripe
* table_print (en développement)


## Diagramme de la base de données
[Diagramme MCBD](https://dbdiagram.io/d/MCBD-project-656def0856d8064ca059e219)

![MCBD dbdiagram.io](https://res.cloudinary.com/dgsiwrjpp/image/upload/v1702993184/MCBD/dbdiagram.png)


## Modèles définis
### 1. Catégorie (Category)
  * Peut être rattachée à plusieurs livres
### 2. Code Prix (PriceCode)
  * Peut concerner plusieurs livres
### 3. Commande (Order)
  * Appartient à un utilisateur
  * Peut contenir plusieurs livres
### 4. Éditeur (Editor)
  * Peut être rattaché à plusieurs livres
### 5. Événement (Event)
  * Peut posséder plusieurs participants
### 6. Info Google Book (GoogleBookInfo)
  * Appartient à un livre
### 7. Liste de Souhaits (Wishlist)
  * Appartient à un utilisateur
  * Appartient à un livre
### 8. Livre (Book)
  * Est rattaché à une catégorie
  * Est rattaché à un éditeur
  * Est rattaché à un code prix
  * Peut se trouver dans plusieurs paniers et/ou listes de souhait
  * Peut se trouver dans plusieurs commandes
### 9. Panier (Cart)
  * Peut contenir plusieurs livres
  * Est rattaché à un utilisateur
### 10. Utilisateur (User)
  * Authentification avec Devise (email, mot de passe)
  * Peut posséder plusieurs livres (books)
  * Possède un panier (cart)
  * Peut posséder plusieurs commandes (orders)
  * Peut participer à un ou plusieurs événements
  * Peut être administrateur (admin)



## Installation

Assurez-vous d'avoir Ruby 7 et PostgreSQL installés sur votre machine.

1. Clonez le repository : `$ git clone https://github.com/votre-utilisateur/mcbd-shop.git`
2. Accédez au répertoire : `$ cd mcbd-shop`
3. Installez les dépendances : `$ bundle install`
4. Créez et migrez la base de données : `$ rails db:create && rails db:migrate`
5. Générer le seed : `$ rails db:seed`
6. Créer le fichier .env et y ajouter vos clés API : 
  * `MAILJET_LOGIN='votre-cle-mailjet'`
  * `MAILJET_PWD='votre-mot-de-passe-mailjet'`
  * `PUBLISHABLE_KEY='votre-cle-API-stripe'`
  * `SECRET_KEY='votre-cle-secrete-stripe'`
7. Lancez la commande `rails assets:precompile`
8. Lancez le serveur : `$ rails server`

L'application devrait être accessible à l'adresse http://localhost:3000.


## Déploiement sur Heroku

Pour déployer l'application sur Heroku :

1. Créez une application Heroku : `$ heroku create`
2. Poussez le code sur Heroku : `$ git push heroku main`
3. Migrez la base de données sur Heroku : `$ heroku run rails db:migrate`
4. Lancez le seed : `$ heroku run rails db:seed`
5. Partagez vos clés API avec Heroku : 
  * `$ heroku config:set MAILJET_LOGIN='VotreMailjetAPIKey'`
  * `$ heroku config:set MAILJET_PWD='VotreMailjetAPISecret'`
  * Etc.
6. Ouvrez l'application dans le navigateur : `$ heroku open`


## Tests

### 1. Pour tester les paiements
  * Numéro de carte Stripe : 4242 4242 4242 4242, 
  * Date d'expiration : date doit être dans le future,
  * CVC : 3 chiffres.
### 2. Pour tester le mode Admin 
  * Login : floriane@yopmail.com OU nelly@yopmail.com
  * Mot de passe : flothp OU nellythp 


## Contribuer

Les contributions sont les bienvenues ! Si vous souhaitez contribuer à l'amélioration de MCBD Shop, veuillez suivre ces étapes :

1. Fork du repository.
2. Création d'une branche : git checkout -b feature/nouvelle-fonctionnalite.
3. Commit de vos changements : git commit -am 'Ajout d'une nouvelle fonctionnalité'.
4. Poussez la branche : git push origin feature/nouvelle-fonctionnalite.
5. Ouvrez une Pull Request.


## Auteurs

Alizadeh Sam
Blanchard-Chabay Floriane
Coron Alexandre
Courtois Axel
Guerin Nelly


## Remerciements

À Hadrien Samouillan et Charles Dutheil, un immense merci pour votre mentorat précieux tout au long du développement de MCBD Shop. Votre expertise et vos conseils ont été des clés essentielles pour résoudre nos défis. Votre soutien continu a été inestimable.

Merci d'utiliser MCBD Shop - Librairie Paris ! N'hésitez pas à nous contacter pour toute question ou commentaire.

# THP PROJET FINAL - Colonel moutarde

Colonel Moutarde est une plateforme de location de jeux de société entre particuliers  
[Lien Colonel Moutarde en production](http://colonel-moutarde.herokuapp.com/)

##  Brief :

Tu en as marre de passer tes soirées devant les Anges / à coder ? Tu connais le bowling, la patinoire et le cinéma du coin ? Arrête tout et invite tes potes à jouer avec toi !  
En quelques clics, tu pourras louer un jeu fun à tes voisins et en profiter avec tes potes !

##  Modèle de fonctionnement :

La plateforme se veut communautaire et accessible à tous.  
Un jeu en location coûtera 3.50€ par semaine.   
Le site prendra une petite commission sur chaque jeu loué et reversera le reste au loueur.  

##  Le cahier des charges :

- Un visiteur doit pouvoir :
  - S'inscrire
  - Regarder les jeux de societé mis en ligne

- Un utilisateur doit pouvoir :
  - Se connecter/déconnecter, éditer son profil
  - Se géolocaliser
  - Réserver des jeux ou en proposer en location
  - Gérer son panier, passer une commande via Stripe, voir l'historique de ses commandes
  - Valider la disponibilité de son jeu en tant que loueur
  - Commenter les jeux en ligne et supprimer le commentaire au besoins

- Un admin doit pouvoir :
  - Créer, éditer, supprimer les jeux du catalogue
  - A tous les droits

- Les jeux :
  - Tous les jeux seront visibles sur une page globale
  - Pour chaque jeu, on aura la possibilité de voir combien de loueurs le proposent et où cette copie se trouve à l'aide de Google Maps
  - Une recherche par nom de jeu ou par catégorie est disponible  

**Le tout en 14 jours !**

- Possibilités d'évolution :
  - Scraping d'une base de données de jeux
  - Evolution de la fonction de recherche autour d'un lieu donné
  - Amélioration de la confidentialité des adresses des loueurs
  - Notation des loueurs et des utilisateurs
  - Système de calendrier pour la location de jeux
  - etc...

## Pour tester le projet en local : 
* git clone https://github.com/sassani134/colonel_moutarde
* faire `bundle install`
* créer la base de donnée avec `rails db:create`
* faire les migrations avec `rails db:migrate`
* seeder la page avec `rails db:seed`

## Projet réalisé par la team de Grenoble : 

| Nom                | Pseudo Slack      |
| -------------------|-------------------|
| Guillaume Pichot   | @Guillaume        |
| Hai-Dang Ha-Thuc   | @Hai-Dang         |
| Fayçal Meghzili    | @Fays             |
| Samuel Assani      | @sassani          |
| Romain Recher      | @RomainRecher     |

Moussaillons Session 6 de [The Hacking Project](https://www.thehackingproject.org/)

:end::end::end:

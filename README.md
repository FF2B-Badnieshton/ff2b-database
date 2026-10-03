# FF2B - Base de Données

Ce dépôt contient la modélisation, le schéma physique SQL et la documentation technique de la base de données relationnelle centrale de la **Fédération Française de Badnieshton (FF2B)**. 

Cette infrastructure constitue le socle unique d'information (Single Source of Truth) pour l'ensemble des services numériques de la fédération (gestion des personnes, licences, compétitions, cotisations, commissions et traçabilité RGPD).

--- 

## Choix Technologiques & Architecture - **SGBD**

- PostgreSQL (v15+) - **Modélisation :** Relationnelle (MCD / MLD conçus sous DrawDB)

- **Identifiants Uniques :** UUID v4 (`ff2b_id`, `id`) pour les entités métier majeures (Personnes, Licences, Documents, Paiements, Comptes) 

-  **Découplage :** Architecture 100 % indépendante de l'interface graphique (prête à être interrogée via API REST / GraphQL) 

---

## Guide de Déploiement & Initialisation Rapide

### Prérequis

- Une instance **PostgreSQL** installée localement ou sur un serveur (ex: Docker, Supabase, Neon ou VPS OVH).

- L'outil de ligne de commande `psql` (ou une interface graphique comme DBeaver / pgAdmin).

### 1. Cloner le dépôt


```
git clone [https://github.com/ff2b-officiel/ff2b-database.git](https://github.com/ff2b-officiel/ff2b-database.git)
cd ff2b-database
```

### 2. Créer la base de données


```
CREATE DATABASE ff2b_db;
```

### 3. Exécuter le script d'initialisation (`init.sql`)

Ce script va créer les types personnalisés (`ENUM`), les tables, les clés étrangères, les contraintes d'unicité, les index et insérer les commentaires SQL sur chaque colonne :


```
psql -U postgres -d ff2b_db -f sql/init.sql
```

### 4. Exécuter le script d'injection des données de référence (`seed.sql`)

Ce script injecte la commune pilote Deshaies, les rôles administratifs, les types de documents et les statuts par défaut :


```
psql -U postgres -d ff2b_db -f sql/seed.sql
```




**Auteur / Lead Architecte BDD :** Alexandre

**Organisme :** Fédération Française de Badnieshton (FF2B
# FF2B - Base de Données

Ce dépôt contient la modélisation, le schéma physique SQL et la documentation technique de la base de données relationnelle centrale de la **Fédération Française de Badnieshton (FF2B)**.

Cette infrastructure constitue le socle unique d'information pour l'ensemble des services numériques de la fédération (gestion des personnes, licences, compétitions, cotisations, commissions et traçabilité RGPD).

---

## Choix Technologiques & Architecture - **SGBD**

- PostgreSQL (v15+)
- **Identifiants Uniques :** UUID v4 (`ff2b_id`, `id`) pour les entités métier majeures (Personnes, Licences, Documents, Paiements, Comptes)

---

## Guide de Déploiement & Initialisation Rapide

### Prérequis

- Une instance **PostgreSQL** installée localement ou sur un serveur (ex: Docker, Supabase, Neon ou VPS OVH).
- Sqitch installé sur le système (Linux recommandé ou voir [ici](https://sqitch.org/download/) 

### 1. Cloner le dépôt

```
git clone [https://github.com/ff2b-officiel/ff2b-database.git](https://github.com/ff2b-officiel/ff2b-database.git)
cd ff2b-database
```

### 2. Créer la base de données

```
CREATE DATABASE ff2b_db;
```

### 3. Initialiser la Base de données avec Sqitch

Pour versionner la base de données, effectuer les migration et faire des test, on utilise **Sqitch.**

Pour plus d'informations sur **Sqitch**, allez voir le fichier *How to use squitch* ou la [documentation officiel](https://sqitch.org/docs/)

### 4. Exécuter le script d'injection des données de référence (`seed.sql`)

Ce script injecte la commune pilote Deshaies, les rôles administratifs, les types de documents et les statuts par défaut :

```
psql -U postgres -d ff2b_db -f sql/seed.sql
```

**Auteur / Lead Architecte BDD :** Alexandre

**Organisme :** Fédération Française de Badnieshton (FF2B

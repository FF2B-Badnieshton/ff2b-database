
>[!note] Contexte
>Document produit dans le cadre de la Phase 1 (Architecture) du projet de système d'information de la Fédération Française de Badnieshton.


## 1. Introduction & Contexte

L'objectif de ce projet est de doter la **FF2B** d'une infrastructure numérique **centrale**, fiable et structurée, capable d'accompagner la croissance de l'association sans nécessiter de reconstruction future. Conformément au chapitre 33 du cahier des charges, ce document a pour but de documenter et justifier les choix technologiques retenus pour la conception de cette base de données.

## 2. Choix technique et justification

Conformément à **l'article 33** du cahier des charges exigeant l'utilisation d'une technologie de base de données standard et pérenne, le Système de Gestion de Base de Données retenu pour l'infrastructure de la FF2B est **PostgreSQL**. Ce choix s'impose car il remplit nativement l'intégralité des contraintes techniques du projet :

- **Base relationnelle :** PostgreSQL est l'un des moteurs relationnels Open Source les plus puissants du marché. Il permet d'organiser de manière optimale les données dans des tables séparées mais interconnectées, respectant l'exigence d'avoir une source unique et fiable.

- **Intégrité référentielle :** Le moteur garantit une gestion stricte des données grâce au support avancé des clés étrangères (Foreign Keys) et des contraintes de modification/suppression (`ON DELETE CASCADE`, `SET NULL`). Cela garantit l'impossibilité d'avoir des données orphelines ou incohérentes dans le système.

- **Transactions :** PostgreSQL respecte scrupuleusement le standard ACID (Atomicité, Cohérence, Isolation, Durabilité). Cela sécurise de façon absolue les opérations critiques impliquant plusieurs tables en simultané (par exemple, la validation d'un paiement liée à la création d'une licence).

- **Indexation :** Le SGBD propose des algorithmes de recherche très performants, allant de l'indexation classique (B-Tree pour accélérer les jointures) à des index avancés (GIN) particulièrement puissants pour fouiller dans les historiques de modifications au format JSONB.

- **Sauvegarde et Restauration :** La technologie inclut des utilitaires natifs robustes (`pg_dump`, `pg_restore`) permettant d'automatiser les sauvegardes à chaud et de garantir un rétablissement rapide et fiable des données en cas de sinistre.

- **Sécurité :** PostgreSQL offre une gestion des permissions extrêmement granulaire (RBAC). Il permet de sécuriser les accès en base et s'intègre parfaitement avec la logique de hachage des mots de passe et la protection imposée par le RGPD.

- **Évolutivité :** Le moteur est conçu pour encaisser de très gros volumes de données. Il accompagnera la croissance de la fédération et permettra d'ajouter de nouvelles fonctionnalités sportives sans aucune refonte fondamentale de l'architecture.

- **Documentation :** Technologie standard et open-source existant depuis plus de 30 ans, PostgreSQL bénéficie d'une documentation officielle exhaustive et d'une communauté mondiale, garantissant la pérennité et la facilité de reprise du projet par n'importe quel autre développeur. PostgreSQL est considéré comme 

- **Possibilité d'interconnexion web :** PostgreSQL est le standard de l'industrie pour les applications modernes. Sa structure découplée s'interconnecte facilement via n'importe quelle API (Python, Node.js) pour alimenter simultanément le site internet vitrine et le futur espace adhérent interactif.
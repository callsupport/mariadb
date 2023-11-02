#!/bin/bash

# Demander le nom du projet à l'utilisateur
read -p "Veuillez entrer le nom du projet : " project_name

# Installer MariaDB si nécessaire
if ! [ -x "$(command -v mariadb)" ]; then
    sudo apt update
    sudo apt install mariadb-server -y
fi

# Créer un mot de passe aléatoire
password=$(openssl rand -base64 12)

# Créer la base de données avec le nom du projet
echo "CREATE DATABASE $project_name;" | sudo mariadb -u root -p

# Créer un utilisateur avec le nom du projet et le mot de passe aléatoire
echo "CREATE USER '$project_name'@'localhost' IDENTIFIED BY '$password';" | sudo mariadb -u root -p

# Accorder tous les droits à l'utilisateur sur la base de données
echo "GRANT ALL PRIVILEGES ON $project_name.* TO '$project_name'@'localhost';" | sudo mariadb -u root -p

# Afficher les informations récapitulatives
echo "Base de données $project_name créée avec succès."
echo "Nom d'utilisateur : $project_name"
echo "Mot de passe : $password"

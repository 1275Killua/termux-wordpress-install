#!/bin/bash

# Fungsi untuk menampilkan menu
function show_menu {
    echo "============================"
    echo " WordPress Setup in Termux"
    echo "============================"
    echo "1. Install Apache"
    echo "2. Install MySQL"
    echo "3. Install PHPMyAdmin"
    echo "4. Install WordPress"
    echo "5. Manage Database"
    echo "6. Exit"
    echo "============================"
    read -p "Pilih opsi [1-6]: " option
}

# Fungsi untuk menginstal Apache
function install_apache {
    pkg install apache2 -y
    echo "Apache telah terinstal."
}

# Fungsi untuk menginstal MySQL
function install_mysql {
    pkg install mariadb -y
    mysql_install_db
    echo "MySQL telah terinstal. Silakan jalankan 'mysql_secure_installation' untuk mengamankan instalasi."
}

# Fungsi untuk menginstal PHPMyAdmin
function install_phpmyadmin {
    pkg install phpmyadmin -y
    echo "PHPMyAdmin telah terinstal."
}

# Fungsi untuk menginstal WordPress
function install_wordpress {
    pkg install wget -y
    wget https://wordpress.org/latest.tar.gz
    tar -xvzf latest.tar.gz
    mv wordpress /data/data/com.termux/files/usr/share/apache2/default-site/wordpress
    echo "WordPress telah terinstal di /usr/share/apache2/default-site/wordpress"
}

# Fungsi untuk mengelola database
function manage_database {
    echo "Menu Manajemen Database"
    echo "1. Buat Database"
    echo "2. Hapus Database"
    echo "3. Lihat Database"
    echo "4. Kembali"
    
    read -p "Pilih opsi [1-4]: " db_option
    case $db_option in
        1)
            read -p "Nama database: " db_name
            mysql -u root -e "CREATE DATABASE $db_name;"
            echo "Database $db_name telah dibuat."
            ;;
        2)
            read -p "Nama database yang akan dihapus: " db_name
            mysql -u root -e "DROP DATABASE $db_name;"
            echo "Database $db_name telah dihapus."
            ;;
        3)
            mysql -u root -e "SHOW DATABASES;"
            ;;
        4)
            return
            ;;
        *)
            echo "Opsi tidak valid."
            ;;
    esac
}

# Menu utama
while true; do
    show_menu
    case $option in
        1) install_apache ;;
        2) install_mysql ;;
        3) install_phpmyadmin ;;
        4) install_wordpress ;;
        5) manage_database ;;
        6) echo "Keluar dari program."; exit 0 ;;
        *) echo "Opsi tidak valid." ;;
    esac
done

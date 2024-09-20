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
    echo "6. Start MySQL"
    echo "7. Start Apache"
    echo "8. Access WordPress"
    echo "9. Exit"
    echo "============================"
    read -p "Pilih opsi [1-9]: " option
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
    echo "WordPress telah terinstal di /data/data/com.termux/files/usr/share/apache2/default-site/wordpress"
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

# Fungsi untuk menjalankan MySQL
function start_mysql {
    mysqld_safe &
    echo "MySQL server berjalan di socket '/data/data/com.termux/files/usr/tmp/mysqld.sock'."
}

# Fungsi untuk keluar dari MySQL
function exit_mysql {
    mysqladmin -u root -p shutdown
    echo "MySQL server telah dihentikan."
}

# Fungsi untuk menjalankan Apache
function start_apache {
    httpd
    echo "Apache server berjalan di http://127.0.0.1:8080."
}

# Fungsi untuk mengakses WordPress
function access_wordpress {
    echo "Akses WordPress di http://127.0.0.1:8080/wordpress"
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
        6) start_mysql ;;
        7) start_apache ;;
        8) access_wordpress ;;
        9) exit_mysql; echo "Keluar dari program."; exit 0 ;;
        *) echo "Opsi tidak valid." ;;
    esac
done

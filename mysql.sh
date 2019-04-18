#!/bin/bash
# Стырено тут https://techlist.top/ustanovka-wordpress-odnoj-knopkoj/
# но переделано
# -------------------------------------------------------------------------
# Переменные базы данных (имя базы, имя пользователя, пароль пользователя).
# -------------------------------------------------------------------------
 
# basename, username, password - заменить на свои значения.
DBNAME=basename
DBUSER=username
DBPASS=password
 
# Переменная пароля root-пользователя mysql/mariadb, для входа в консоль.
ROOTPASS=password
 
# Переменная каталога в котором находятся базы данных - НЕ ИЗМЕНЯТЬ!!!
DBDIR=/var/lib/mysql/
 
# -----------------------------------
# 1 - Создание базы данных для сайта.
# -----------------------------------
 
echo "Создаю базу данных…"
 
if [ -e "$DBDIR"/"$DBNAME" ]; then
echo -e "\nБаза с таким именем уже есть. Выбери другое имя для базы данных.
Работа скрипта остановлена." && exit
fi
 
# Создание пользователя (раскомментировать если нужен новый пользователь).
#mysql -u root -p"$ROOTPASS" -e "create user "$DBUSER"@'localhost' identified by '$DBPASS';"
 
# Создание базы данных и назначение привилегий пользователя.
mysql -u root -p"$ROOTPASS" -e "create database "$DBNAME"; grant all on "$DBNAME".* to "$DBUSER"@'localhost'; flush privileges;"
 
if [ "$?" != 0 ]; then
echo -e "\nВо время создания базы возникла ошибка.
Работа скрипта остановлена." && exit
fi
 
echo -e "\nБаза данных: "$DBNAME"
Пользователь базы данных: "$DBUSER"
Пароль пользователя: "$DBPASS" "

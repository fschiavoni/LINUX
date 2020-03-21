#!/bin/bash
# Script to add a user to Linux system

while [ true ]
do
	#################	ADD USER 	#################
	while [ true ]
	do
	# Si el usuario es root, entramos en el if
	if [ $(id -u) -eq 0 ]; then 

### Hacemos input del usuario y su contraseña
#   Si el usuario introduce "0" se termina el script.
	read -p "Enter username : " username

		if [ "$username" = "0" ]; then break
		fi

	read -s -p "Enter password : " password

### Buscamos dicho usuario en la carpeta passwd
	egrep "^$username" /etc/passwd >/dev/null

### Comprobarmos que el usuario no existe

### $? equivale al return del ultimo comando utilizado
#	en este caso, egrep. Si egrep devuelve 0 es que ha
### encontrado al usuario por tanto ya existe.
		if [ $? -eq 0 ]; then
			echo "$username already exists!"
			exit 1
		else 
			pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
			useradd -m -p $pass $username
			[ $? -eq 0 ] && echo "User - $username - has been added to the system." ||
			echo "Failed to add the user - $username -"
		fi

	else 
		echo "Only root may add a user to the system"
		exit 2	
	fi
done 
    #################	ADD GROUP 	################
	read -p "Enter group name : " group

	if [ "$group" = "0" ]; then break
	fi

	egrep "^$group" /etc/group >/dev/null

	if [ $? -eq 0 ]; then
		echo "$group already exists!"
		exit 1
	else 

	groupadd $group
	[ $? -eq 0 ] && echo "Group - $group - has been added to the system." ||
	echo "Failed to add the group - $group -"
	fi


done

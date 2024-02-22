#!/bin/bash
#Below Script will add modify and Delete the user

<< comment
Below Script will add modify and delete the user and also help to add group delete group.
It will also take compressed backup of file.
comment

echo "Please enter yor Choice:"
echo "1. Add User"
echo "2. Modify User"
echo "3. Delete User"
echo "4. Add Group"
echo "5. Delete Grop"
echo "6. Backup the Directory"
echo "7. Exit from menu "
echo -n "Enter your menu choice [1-7]: "

create_user(){
	echo "Enter User Name to create:"
	read username
	echo "Enter the password for user"
	read password
	
#Create the user with input provided by script runner

# Check if the username already exists

	if id "$username" &>/dev/null; then
		echo "Error: The username '$username' already exists. Please choose a different username."
		return 1
	fi

sudo useradd -m -s /bin/bash $username
sudo passwd $password

echo "$username Created Successfully"

}
mod_user(){
read -p "Enter user name to Modify : " old_user

	if id "$old_user" &>/dev/null;
	then
		read -p "Enter new user name : " new_user
		sudo usermod -l $new_user $old_user
		echo "Folder name is changing.."

                     cd ../.. && sudo mv $oldusername $newusername
                echo "Folder name is changed"
                echo "Group name is changing.."
                     sudo groupmod -n $newusername $oldusername
                echo "Group name changed"
                     #cat /etc/group
                echo "The process of user modification is completed successfully"
	
		echo "User name as changed successfully to $new_user"
		sudo cat /etc/passwd | grep $new_user
		
	else
		echo "User $old_user is not found"
		echo ""
	fi
}
del_user(){

read -p "Please enter user name to delete : " username

        if id "$username" &>/dev/null;
        then
		
		sudo userdel -r $username
                echo "User $username is successfully deleted...!"
                
	else
                echo "User $username is not found...!"
        fi
}
add_grp() 
{

read -p "Enter a groupname: " groupname

if grep -q $groupname /etc/group; then

		echo "$groupname is already Exist"
	else
		
		sudo groupadd $groupname
		echo "Group $groupname ceated SUcessfully."
	fi
}

# Function to delete an existing group

del_grp()
{
read -p "Which group you want to delete? " groupname

echo
	if grep -q $groupname /etc/group; then
		sudo groupdel $groupname		
		echo "$groupname deleted successfully"
	else
		echo "Error: Failed to delete '$groupname' because Group doesnot exist."
	fi

}
backup_dir(){
 
	read -p "Ener full DIrectory Path to Backup" dirpath
	read -p "Enter Source Path to store Backup" srcpath

	backup_filename="back_$(date +%Y_%m_%d_%H_%M_%S).tar.gz"
	echo "Backup STarted....."
	echo "Backing up to $backup_filename...."

	sudo tar -czvf  "$backup_filename" "$dirpath" "$srcpath"

	echo "Backup Completed Successfully and stored in $srcpath"

}

while :
do

# reading choice
read choice

# case statement is used to compare one value with the multiple cases.
case $choice in
  # Pattern 1
  1)  echo "You have selected the option 1"
  create_user
  ;;
  # Pattern 2
  2)  echo "You have selected the option 2"
  mod_user
  ;;
  # Pattern 3
  3)  echo "You have selected the option 3"
  del_user
  ;;
  # Pattern 4
  4)  echo "You have selected the option 4"
  add_grp
  ;;
  # Pattern 5
  5)  echo "You have selected the option 5"
  del_grp
  ;;
  # Pattern 6
  6)  echo "You have selected the option 6"
  backup_dir
  ;;
  # Pattern 7
  7)  echo "Quitting ..."
      exit;;
  # Default Pattern
  *) echo "invalid option";;

esac
  echo -n "Enter your menu choice [1-7]:" 
done

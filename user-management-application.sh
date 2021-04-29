#! /bin/bash

# add_user function
add_user(){
    # if file is not available create that file
    if [ ! -e users.dat ]; then
        touch users.dat
    fi 
        echo "Please provide following details"
        echo "---------------------------------"
        read -p "First Name : " fname
        read -p "Last Name : " lname
        read -p "User Id : " uid
        count=$(cat users.dat | cut -d ":" -f 1 | grep $uid | wc -l)
        
        # if userid already exist
        if [ $count -ne 0 ]; then 
            echo "---------------------------------"
            echo "User Id : $uid already exist"
            echo "---------------------------------"
            return 1
        fi 
        read -s -p "Password : " pswd 
        echo
        read -s -p "Retype Password : " repswd 
        echo 
        # if password and retype password is not same
        if [ $pswd != $repswd ]; then
            echo "---------------------------------"
            echo "Password are not matching..."
            echo "---------------------------------"
            return 2
        fi
        read -p "zip : " zip 
        echo "$uid:$fname:$lname:$zip" >> users.dat
        echo "---------------------------------"
        echo "Users added sucessfully...."
        echo "---------------------------------"     
        echo
        echo

          
}



echo "****************************************"
echo "WELCOME TO USER MANAGEMENT APPLICATION"
echo "****************************************"
while [ true ]
do
    echo "1. Add User : "
    echo "2. Search User : "
    echo "3. Change Password : "
    echo "4. Delete User : "
    echo "5. Show All User : "
    echo "6. Users Count : "
    echo "7. EXIT : "
    read -p "Enter Choice : [1|2|3|4|5|6|7] : " CHOICE
    case $CHOICE in 
    1)
        add_user
        ;;
    2)
        search_user
        ;;
    3)
        change_password
        ;;
    4)
       delete_user
        ;;
    5)
        show_all_user
        ;;
    6)
        user_count
        ;;
    7)
        exit
        ;;
  esac      
done
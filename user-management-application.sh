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
        count=$(cat users.dat | cut -d ":" -f 1 | grep -w $uid | wc -l)
        
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
        echo "$uid:$pswd:$fname:$lname:$zip" >> users.dat
        echo "---------------------------------"
        echo "Users added sucessfully...."
        echo "---------------------------------"     
        echo
        echo

          
}

search_user(){
    read -p "Enter user id to search : " uid
    count=$(cat users.dat | cut -d ":" -f 1 | grep -w $uid | wc -l)
    if [ $count -eq 0 ]; then
        echo "---------------------------------"
        echo "User Id : $uid does'nt exist"
        echo "---------------------------------"
        return 3
    fi
    read -p "Enter user password to search : " upwd
    count=$(cat users.dat | grep -w $uid | cut -d ":" -f 2 |grep -w $upwd | wc -l)
    if [ $count -eq 0 ]; then
        echo "---------------------------------"
        echo "Invalid Password"
        echo "---------------------------------"
        return 4
    fi
    
    echo
    available="no"
    # count=$(cat users.dat | cut -d ":" -f 1 | grep $uid | wc -l)
    # # if userid doesn't exist
    #     if [ $count -eq 0 ]; then 
    #         echo "---------------------------------"
    #         echo "User Id : $uid doesn't exist"
    #         echo "---------------------------------"
    #         return 3
    #     fi
    # count=$(cat users.dat | grep $uid | cut -d ":" -f 2 |grep $upwd | wc -l)
    # # if upwd doesn't exist
    #     if [ $count -eq 0 ]; then 
    #         echo "---------------------------------"
    #         echo "Invalid Password"
    #         echo "---------------------------------"
    #         return 4
    #     fi
        
        while read line
        do
            fuid=$(echo $line | cut -d ":" -f1)
            fpwd=$(echo $line | cut -d ":" -f2)
            if [ $uid = $fuid -a $upwd = $fpwd ]; then
                available="yes"
                echo "Complete User Information"
                echo "--------------------------"
                echo "User Id : $(echo $line | cut -d ":" -f 1)"
                echo "User Password : $(echo $line | cut -d ":" -f 2)"
                echo "First Name : $(echo $line | cut -d ":" -f 3)"
                echo "Last Name : $(echo $line | cut -d ":" -f 4)"
                echo "ZIP Code : $(echo $line | cut -d ":" -f 5)"
                echo
                echo
                break
                
            fi
            done < users.dat
            if [ $available = no ]; then
                echo "---------------------------------"
                echo "User id or Password not matched"  
                echo "---------------------------------"  
            fi
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
#!/bin/bash

# password Generator Script
# this script generates a random password based on user input.
echo "Welcome to the password generator!"  
echo "NSM Norway, NIST (National Institute of Standards and Technology), and ENISA (European Union Agency for Cybersecurity) recommend using at least 16 characters for better security."
echo "You can choose a different length, but shorter passwords are less secure."

# check if cracklib-check is installed
if  ! command -v cracklib-check &> /dev/null; then
     echo "Warning: cracklib-check is not installed! The password will not be strength-checked."
     CHECK_PASSORD=false
else
     CHECK_PASSORD=true
fi

# ask the user for password length and ensure it is a valid number
while true; do   
    read -p "Please enter the password length: " LENGTH
    LENGTH=$(echo "$LENGTH" | xargs) # remove any spaces

# check if LENGTH contains only valid numbers (0-9)
    if [[ "$LENGTH" =~ ^[0-9]+$ ]]; then
        break # proceed if the user entered a valid number
    else
        echo "Error: Please enter a valid number."
    fi
done

# generate a random password
# [:punct:] includes all special charachters in the ASCII-table, symbols like ~!@#$%^&*()_+=-{}[]\|:";'.,<>?/ etc.
while true; do
   PASSORD=$(tr -dc 'A-Za-z0-9[:punct:]' </dev/urandom | head -c "$LENGTH")
   echo "Your generated password: $PASSORD"

    
   if [[ "$CHECK_PASSORD" == "true" ]]; then
       STRENGTH=$(echo "$PASSORD" | cracklib-check)
       if [[ "$STRENGTH" != *"OK" ]]; then
           echo "Warning: Cracklib considers this password weak.($STRENGTH)" 
           echo "Would you like to generate a new one? (yes/no)"
           read -p "Your choice: " CHANGE_PASS
           CHANGE_PASS=$(echo "$CHANGE_PASS" | tr '[:upper:]' '[:lower:]' | xargs)
           if [[ "$CHANGE_PASS" == "yes" ]]; then
               echo "Please enter a new password length:"
               read -p "New password: " LENGTH
               continue
           fi
       fi
    fi
    break

done

# ask the user if they want to save the password
while true; do
      read -p "Would you like to save the password? (yes/no): " SAVE
      SAVE=$(echo "$SAVE" | tr '[:upper:]' '[:lower:]'| xargs) # removes spaces and converts to lowercase

      if [[ "$SAVE" == "yes" ]]; then
         break  
     elif [[ "$SAVE" == "no" ]]; then
         echo "The password was not saved."
        exit 0
     else
        echo "Invalid input, please enter 'yes' or 'no'."
     fi
done

# encrypt the password if the user chooses to save it
if [[ "$SAVE" == "yes" ]]; then
    if [[ ! -f passphrase.txt ]]; then
       echo "Warning: passphrase.txt does not exist."
       read -p "Would you like to create a new passphrase-file? (yes/no): " CREATE_KEY
       CREATE_KEY=$(echo "$CREATE_KEY" | tr '[:upper:]' '[:lower:]' | xargs)

       if [[ "$CREATE_KEY" == "yes" ]]; then
           while true; do
              echo ""
              read -s -p "Please enter a  passphrase (not displayed): " PASSPHRASE
              echo ""
              read -s -p "Confirm passphrase: " CONFIRM_PASSPHRASE
              echo ""

              if [[ "$PASSPHRASE" == "$CONFIRM_PASSPHRASE" && -n "$PASSPHRASE" ]]; then
                 echo "$PASSPHRASE" > passphrase.txt
                 chmod 600 passphrase.txt # protects the file
                 echo  "Passphrase file created."
                 break
              else
                 echo "Error: Passphrase does not match or is empty. Try again."
              fi
           done
      else 
           echo "Cannot save password without a passphrase file."
           exit 1
         fi
      fi
     
      echo "$PASSORD" | ccrypt -e -k passphrase.txt > passphrase.txt.cpt
      echo "The password has been saved in an encrypted file: password.txt.cpt"
fi        







<<<<<<< HEAD
# passord-generator
=======
# Password Generator

This is a Bash script that generates random passwords based on user input.
The script includes a **strength check using 'cracklib-check'** and an option to **save the password in an encrypted file**.

# Project Requirements
**This script was developed as part of an assignment and meets the following criteria:**
- The user must specify the desired password length.
- If the user inputs anything other than a number, an appropriate error message should be displayed.
- The password must be randomly generated and contain:
  - Numbers [0-9]
  - Lowercase letters [a-z]
  - Uppercase letters [A-Z]
  - Bonus: Special characters [@, $, (, etc]
- The generated password should be displayed in the terminal.

# Bonus Functionality
- Ask the user if they want to save the password to a file.
   - If yes:
      - Encrypt the password with **ccrypt** and save it in a **password.txt.cpt** file.
   - If no:
      - Display a message informing the user that the password was not saved.
  
# Features  
- User-defined password length
- Generates password with uppercase, lowercase, digits, and special characters
- Strength validation with **cracklib-check**
- Option to generate a new password if the first is weak
- Encrypted password storage with **ccrypt**

# Installation
**Step 1: Install required packages** 
If not installed, run the following command:
```bash
sudo apt update && sudo apt install cracklib-runtime ccrypt -y
```

**Step 2: Clone the repository**
```bash
git clone https://github.com/Fanmagoria/password-generator.git
cd password-generator 
```

**Step 3: Make the script executable**
```bash
chmod +x password_generator.sh 
```

# Usage
**Run the script:**
```bash
./password_generator.sh
```

# Encrypting and saving passwords
**If you choose to save the password, it will be encrypted and stored i password.txt.cpt**. 
To decrypt it, use:
```bash
ccrypt -d password.txt.cpt
```

# Password Security Recommendations
**The following organizations recommend using passwords that are at least 16 characters long:**
- NSM Norway (National Security Authoity of Norway)
- NIST (National Institute of Standards and Technology, USA)
- ENISA (European Union Agency for Cybersecurity)
**Using a combination of uppercase, lowercase, numbers, and special characters improves password security.**

# Delivery & Submission
- The script must be uploaded to a GitHub repository.
- A README.md file should contain a short description of how the script works.

# Licene & Author
- License: MIT
- Author: Elizabeth Hovdal
- GitHub: Fanmagoria 
 

>>>>>>> ff03b4d (Initial commit: Added password generator script and README.md)

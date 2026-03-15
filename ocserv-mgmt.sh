#!/bin/sh

# POSIX sh compatible ocserv management script
# (without install/uninstall + separated add/change password)

addUser() {
    if [ ! -f /etc/ocserv/ocpasswd ]; then
        echo "ocserv password file not found. Is ocserv installed?"
        return
    fi
    echo "Enter new username:"
    read -r username
    ocpasswd -c /etc/ocserv/ocpasswd "$username"
    echo "User added."
}

changePassword() {
    if [ ! -f /etc/ocserv/ocpasswd ]; then
        echo "ocserv password file not found. Is ocserv installed?"
        return
    fi
    echo "Enter username to change password:"
    read -r username
    ocpasswd -c /etc/ocserv/ocpasswd "$username"
    echo "Password changed."
}

showUsers() {
    if [ -f /etc/ocserv/ocpasswd ]; then
        echo "Registered users:"
        echo "-----------------"
        cat /etc/ocserv/ocpasswd
    else
        echo "No users file found (/etc/ocserv/ocpasswd)"
    fi
}

deleteUser() {
    if [ ! -f /etc/ocserv/ocpasswd ]; then
        echo "No users file found."
        return
    fi
    echo "Enter username to delete:"
    read -r username
    ocpasswd -c /etc/ocserv/ocpasswd -d "$username" && echo "User deleted."
}

lockUser() {
    if [ ! -f /etc/ocserv/ocpasswd ]; then
        echo "No users file found."
        return
    fi
    echo "Enter username to lock:"
    read -r username
    ocpasswd -c /etc/ocserv/ocpasswd -l "$username" && echo "User locked."
}

unlockUser() {
    if [ ! -f /etc/ocserv/ocpasswd ]; then
        echo "No users file found."
        return
    fi
    echo "Enter username to unlock:"
    read -r username
    ocpasswd -c /etc/ocserv/ocpasswd -u "$username" && echo "User unlocked."
}

# ───────────────────────────────────────────────────────────────
#  Main program
# ───────────────────────────────────────────────────────────────

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root (sudo)"
    exit 1
fi

cat << 'EOF'

   ocserv User Management
   ----------------------

EOF

echo "Choose an option:"
echo ""
echo "  1) Add User"
echo "  2) Change Password"
echo "  3) Show Users"
echo "  4) Delete User"
echo "  5) Lock User"
echo "  6) Unlock User"
echo "  7) Quit"
echo ""

printf "Enter choice [1-7]: "
read -r choice

case "$choice" in
    1) addUser ;;
    2) changePassword ;;
    3) showUsers ;;
    4) deleteUser ;;
    5) lockUser ;;
    6) unlockUser ;;
    7) echo "Goodbye." ; exit 0 ;;
    *) echo "Invalid choice." ; exit 1 ;;
esac

echo ""
echo "Done."

# Do not use this pam module unless you have a encrypted root partition

# libpam-pwdfile-plain

## Description

This is a fork of <https://git.tiwe.de/libpam-pwdfile.git>

The original version uses hashed passwords. This version uses plain text passwords. This is useful if you have a encrypted root partition and you are very lazy to hash your passwords or if you quite can't figure out how to exactly to hash your password to the original version's liking (like me).

## Installation

```bash
# Not yet tested if it works then remove this comment
git clone https://github.com/Supernovatux/libpam-pwdfile-UNSAFE
cd libpam-pwdfile-UNSAFE
make
sudo make install
```

## Usage

### With sudo

Edit the files as in below

```console
$ cat /etc/pam.d/sudo
#%PAM-1.0
auth        sufficient  pam_pwdfile_plain.so pwdfile /etc/pwd_file
auth        include     system-auth
account     include     system-auth
session     include     system-auth

$ sudo cat /etc/pwd_file
your_username:your_password
root:root_password
```
### With kde lockscreen

Create /etc/pwd_file as above then modify /etc/pam.d/kde as below
```console
$ cat /etc/pam.d/kde
#%PAM-1.0
auth        sufficient  pam_pwdfile_plain.so pwdfile /etc/pwd_file
auth            include         system-login
account         include         system-login
password        include         system-login
session         include         system-login
```
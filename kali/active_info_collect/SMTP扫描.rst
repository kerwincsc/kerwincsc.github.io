SMTP扫描
======================================================================

- nc -nv 1.1.1.1 25

  - VRFY root

- nmap

  ::

     nmap smtp.163.com -p25 --script=smtp-enum-users.nse \
          --script-args=smtp-enum-users.methods={VRFY} 
     nmap smtp.163.com -p25 --script=smtp-open-relay.nse

- ``smtp-user-enum -M VRFY -U users.txt -t 1.1.1.1``



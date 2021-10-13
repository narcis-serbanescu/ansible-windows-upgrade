Role Name: win2012_upgrade_2019    
=========

Use of Ansible in upgrading Windows Server 2012 directly to 2019, by skipping 2016 version, while staying on the same virtual hardware and without removing the older existing version.     
In-place upgrade method leverages the Windows installation to preserve all data, accounts, settings, applications, drivers from the existing version.    
It requires the least IT effort, because there is no need for any complex deployment infrastructure.


Requirements
------------

VM is member of a certain Active Directory Domain e.g. xxx.yyy.com   
WinRM is configured so that target systems accept requests.  
Kerberos is configured on Ansible controller node to allow user authentication to the domain that VM belongs to.  
VM has enough hardware resources, e.g: RAM, CPU, space on C drive.    
Snaphots or Clone have been already taken for backup purposes.   

Role Variables
--------------

Few variables are declared in vars/main.yml like:   
   `` src: C:\win_upgrade``       
   `` iso_src: "{{ src }}\\ISO" ``      
   `` sr_sds: 146.89.141.138``       
   `` drive: "{{ ansible_facts['env']['SystemDrive'] }}"``
   `` iso2019: "\\\\{{ sr_sds }}\\sds\\local\\sceplus\\infra\\vmware\\Windows_Images\\en_windows_server_2019_updated_march_2019_x64_dvd_2ae967ab.iso"``

Dependencies
------------

    dependencies:
    - role: local_user
    - role: rm_win_roles
    - role: work_dir
    - role: cleanup_before
    - role: stop_win_srv



Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: win2012_upgrade_2019, when: "ansible_facts['os_family'] == 'Windows' and ansible_facts['distribution_version'] == '6.3.9600.0'" }

License
-------

BSD

Author Information
------------------

Narcis Serbanescu (narcis.serbanescu@gmail.com)

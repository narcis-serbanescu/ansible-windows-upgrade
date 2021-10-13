Role Name: win2008_upgrade_2012
=========

Use of Ansible in upgrading Windows Server 2008 operating system to Windows Server 2012, while staying on the same virtual hardware and without removing the older existing version.    
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
   `` scripts_location: "{{ role_path }}/files"``       
   `` sr_sds: 146.89.141.138``       
   `` drive: "{{ ansible_facts['env']['SystemDrive'] }}"``
   `` iso2012file: en_windows_server_2012_r2_with_update_x64_dvd_6052708.iso``
   `` iso2012: "\\\\{{ sr_sds }}\\sds\\local\\sceplus\\infra\\vmware\\Windows_Images\\{{ iso2012file }}"``

Dependencies
------------

    dependencies:
    - role: local_user
    - role: rm_win_roles
    - role: work_dir
    - role: 7zip_install
    - role: cleanup_before
    - role: stop_win_srv


Example Playbook
----------------

      - hosts: Q71
      gather_facts: True
      roles:
         - { role: win2008_upgrade_2012, when: "ansible_facts['os_family'] == 'Windows' and ansible_facts['distribution_version'] == '6.1.7601.65536'" }


License
-------

BSD

Author Information
------------------

Narcis Serbanescu (narcis.serbanescu@gmail.com)

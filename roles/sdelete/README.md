Role Name: sdelete
=========

Secure delete application    
https://docs.microsoft.com/en-us/sysinternals/downloads/sdelete    

Requirements
------------

Kerberos is configured on Ansible controller node to allow user authentication to the domain that VM belongs to.

Role Variables
--------------

Few variables are declared in vars/main.yml like:   
   `` src: C:\win_upgrade``       
   `` scripts_location: "{{ role_path }}/files" ``      
   `` drive: "{{ ansible_facts['env']['SystemDrive'] }}"``    


Dependencies
------------

    dependencies:
    - role: work_dir
    - role: 7zip_install only for Windows Server 2008 R2 cases where no other unzip option exists

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: sdelete, when: "ansible_facts['os_family'] == 'Windows'" }

License
-------

BSD

Author Information
------------------

Narcis Serbanescu (narcis.serbanescu@gmail.com)


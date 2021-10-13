Role Name: sdelete
=========

Install 7zip free and open-source file archiver tool - especially for Windows Server 2008 cases where there isn't any possibility to extract content from zip, iso files      

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

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: 7zip_install, when: "ansible_facts['os_family'] == 'Windows'" }

License
-------

BSD

Author Information
------------------

Narcis Serbanescu (narcis.serbanescu@gmail.com)


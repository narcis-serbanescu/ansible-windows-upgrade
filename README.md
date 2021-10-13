
# Use of Ansible in upgrading Windows Server 2008/2012 to 2019 with "in-place" method 


## The Idea   
Bringing a bit of automation to the in-place upgrade of Windows Server 2008/2012 operating system to Windows Server 2019, without removing the older existing version, while staying on the same virtual hardware.   


## The Mission
For on-premises servers, upgrading Windows Server 2008 directly to 2019 by skipping a number of the next two releases 2012 and 2016, is neither possible nor supported. There is no direct upgrade path from Windows Server 2008 R2 to Windows Server 2019 or later, but using Ansible playbooks it becomes doable.    

This leverages Windows installation to preserve all data, accounts, settings, applications, drivers from the existing version.   
It requires the least IT effort, because there is no need for any complex deployment infrastructure.   

Performing an in-place upgrade of a virtual machine (VM) instance that is running on Windows Server 2008 R2 and/or Windows Server 2012 can be a pragmatic way to modernize the infrastructure and to mitigate the risks of approaching the end of the support lifecycle of Windows Server 2008/2012



## The Assumptions
The instance that makes subject of OS upgrade is member of a certain Active Directory Domain e.g. xxx.yyy.com  
Kerberos protocol is configured on the Ansible controller node to allow user authentication to the domain that VM belongs to.  
WinRM is configured on target instance, so that systems accept requests.  
Target instance has enough hardware resources, e.g: RAM, CPU, space on C drive.    
Virtual Snaphots or Clones have been already taken for backup purposes.   


## The Limitations
This Automation does not support upgrading Windows clusters or Windows stand alone work stations.       
The upgrade operation is a multi-step process that can take 2 hours or even more to complete, depending on the configuration and software installed.         


## The Risks     
The automated OS upgrade can fail     
Some configuration options might be overridden by the default settings of the new OS version                    
Few incompatibilities can cause the workload to malfunction on the upgraded instances    


## The Roles     
The process of Windows OS upgrade includes a series of roles that can be used either together as dependencies for the OS upgrade itself or independently to orchestrate a multitude of tasks on Windows servers.        


Roles that upgrade Windows OS:   
----------------    
- win2008_upgrade_2012: upgrades Windows Server 2008 operating system to Windows Server 2012     
- win2012_upgrade_2019: upgrades Windows Server 2012 operating system to Windows Server 2019     



Roles used during OS upgrade:    
----------------    
- sep_install: Symantec Endpoint Protection Client Installations on Windows Platforms
- bes_install: install BES client on Windows Server systems   
- bes_uninstall: remove BES Client
- cleanmgr: run Disk Cleanup tool silently on Windows Server systems to free up disk space on system drive     
- sdelete: copy and run sdelete tool on system drive    
- powershell51_ws2012r2: update Powershell to version 5.1 on Windows Server 2012 R2
- health_checks: few health check OS related tasks like: sfc, scan, chkdsk, defrag    
- getsysinfo: get system information by running hostname, systeminfo, ipconfig /all, route print commands     
- pending_reboot: checks that OS has a pending reboot and takes the appropriate actions    
- win_cleanup: runs tasks for cleaning system drive    
- stop_win_srv: stop Windows services that might prevent OS upgrade    
- start_win_srv: start few Windows services         
Other roles can be found in roles directory







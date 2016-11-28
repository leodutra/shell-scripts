# Leo's shell scripts
Currently only with dev environment setups.

## First run script
Step                           | Script                        
-------------------------------|--------------------------------
1. Upgrade distribution        | `distro/update-packages.sh`  `distro/upgrade-distro.sh`
2. Install essential packages  | `distro/essential-packages.sh`   
3. Add repositories            | `distro/repositories/*`        
4. Update package cache        | `distro/update-packages.sh`    
5. Install 3rd party packages  | `distro/install/*`             
6. Run specific configurations | `distro/configs/*`             

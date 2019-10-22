#!/bin/bash

# The execution of this script stops if a command or pipeline has an error.
# For example, failure to install a dependent package will cause the script
# to stop execution.

set -e

# Specify the timeout in minutes for package installation.
WAIT_TIME=15
DEV_HUB=bridefoxDevHub

echo "**********************"
echo "* Create Scratch Org *"
echo "**********************"
read -p 'Specify your org name: ' ORG_NAME
echo ""
echo " > creating scratch org..."
sfdx force:org:create -s -f config/dev-scratch-def.json -d 30 -v $DEV_HUB -a $ORG_NAME

echo ""
echo "************************************"
echo "* Install dependency package FFLIB *"
echo "************************************"
sfdx force:package:install --package 04t1t000003DHGkAAO --securitytype AdminsOnly -w $WAIT_TIME --publishwait 10 -u $ORG_NAME
sfdx force:package:install --package 04t1t000003DHGpAAO --securitytype AdminsOnly -w $WAIT_TIME --publishwait 10 -u $ORG_NAME

echo ""
echo "*******************************"
echo "* Installing Managed Packages *"
echo "*******************************"
echo ""
echo "***********************************"
echo "* Push source to your scratch org *"
echo "***********************************"
sfdx force:source:push -u $ORG_NAME

echo ""
echo "*******************************************************"
echo "* Assign multiple permission sets to the default user *"
echo "*******************************************************"
#sfdx force:user:permset:assign -n MembershipObjects -u $ORG_NAME
#sfdx force:user:permset:assign -n MembershipApp -u $ORG_NAME
#sfdx force:user:permset:assign -n ConfigurationApp -u $ORG_NAME
#sfdx force:user:permset:assign -n ConfigurationObjects -u $ORG_NAME
#sfdx force:user:permset:assign -n ExactServices -u $ORG_NAME
#sfdx force:user:permset:assign -n OAuthServices -u $ORG_NAME
#sfdx force:user:permset:assign -n wk_slider -u $ORG_NAME

echo ""
echo "*********************"
echo "* Create Admin User *"
echo "*********************"
echo admin@brightfox.eu.$ORG_NAME
sfdx force:user:create --definitionfile config/admin_user_def.json Username=admin@brightfox.eu.$ORG_NAME
sfdx force:alias:set admin-$ORG_NAME=admin@brightfox.eu.$ORG_NAME

echo ""
echo "*************"
echo "* Load data *"
echo "*************"
#sfdx force:data:tree:import -p data/Account-Contact-plan.json -u $ORG_NAME
#sfdx force:data:tree:import -p data/Custom_Toolbar_Setting__c-plan.json -u $ORG_NAME
#sfdx force:data:tree:import -p data/Custom_Path_Setting__c-plan.json -u $ORG_NAME
#sfdx force:data:tree:import -p data/wk_slider_comp__Custom_Carousel__c-wk_slider_comp__Carousel_Item__c-plan.json -u $ORG_NAME
#sfdx force:data:tree:import -p data/OAuthService__c-plan.json -u $ORG_NAME

echo ""
echo "********************"
echo "* Create Test Data *"
echo "********************"
#sfdx force:apex:execute -f Anonymous/Setupdata.apex -u $ORG_NAME

echo ""
echo "You can open the org with the following command: sfdx force:org:open -u admin@brightfox.eu.$ORG_NAME"
sfdx force:org:open -u admin@brightfox.eu.$ORG_NAME

read

exit 0;
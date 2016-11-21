#
Login-AzureRMAccount 
$SubID  = "abcdef1234" #  
Set-AzureRmContext -SubscriptionId $SubID 

$RoleName = "Contributor"
$RoleName2 = "Reader"

# USER LIST (ARRAY) 1
$UserArray1 = `
    "user1_outlook.com#EXT#@azureadtenant.onmicrosoft.com",`
    "user2_hotmail.com#EXT#@azureadtenant.onmicrosoft.com", `
    "workuser3@azureadtenant.onmicrosoft.com"

# USER LIST (ARRAY) 2  
$UserArray2 = `
    "user4_outlook.com#EXT#@azureadtenant.onmicrosoft.com",`
    "workuser5@azureadtenant.onmicrosoft.com"


# ASSIGN ARRAY OF USERS to SPECIFIC RESOURCE GROUPS -----------------------------------
$ResGroup1 = "RG-1"
$ResGroup2 = "RG-2"
$ResGroup3 = "RG-3"
foreach ($user in $UserArray1)
          { 
          New-AzureRmRoleAssignment -SignInName $user -RoleDefinitionName $RoleName -ResourceGroupName $ResGroup1
          New-AzureRmRoleAssignment -SignInName $user -RoleDefinitionName $RoleName -ResourceGroupName $ResGroup2
          New-AzureRmRoleAssignment -SignInName $user -RoleDefinitionName $RoleName -ResourceGroupName $ResGroup3
          }

# ASSIGN USER to SUBSCRIPTION WITH BUILT-IN ROLE  -------------------------------------
$subscope = "/subscriptions/"+$SubID
foreach ($user in $UserArray2)
        { 
        New-AzureRmRoleAssignment -SignInName $user -Scope $subscope -RoleDefinitionName $RoleName2

        }

# DISPLAY ROLES FROM A RESOURCE GROUP --------------------------------------------------
Get-AzureRmRoleAssignment -ResourceGroupName $ResGroup1 | FL DisplayName, SigninName, RoleDefinitionName, Scope


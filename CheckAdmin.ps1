# thanks to https://blogs.technet.microsoft.com/heyscriptingguy/2011/05/11/check-for-admin-credentials-in-a-powershell-script/

function Check-Admin {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent()
    $identity = ([Security.Principal.WindowsPrincipal] $user)
    $is_admin = $identity.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    return $is_admin
}

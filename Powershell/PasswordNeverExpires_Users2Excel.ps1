# Create a List fro all Users which habee set the Fal PasswordNeverExpires
Get-ADUser -filter * -Properties Name, samaccountname, Passwordneverexpires | where {$_.PasswordNeverExpires -eq "true"} | where {$_.Enabled -eq "True"} | Export-Csv Users.csv

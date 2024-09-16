# .github/actions/compose-email/ComposeEmail.ps1
function ComposeEmail {

    param(
        [string]$Message  # Input parameter for the message
    )
     $outputFile = "$env:GITHUB_OUTPUT"
    # Compose the email body
    $emailBody = "Composed email body: $Message"
    
    # Set the output for the composed email body
    #Write-Output "email_body=$emailBody" >> $env:GITHUB_OUTPUT
    Add-Content -Path $outputFile -Value "emailBody=$emailBody"
    Write-Output "$emailBody"
    }
    
    ComposeEmail -Message $Message

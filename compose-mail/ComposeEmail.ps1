# .github/actions/compose-email/ComposeEmail.ps1
function ComposeEmail {

param(
    [string]$Message  # Input parameter for the message
)

# Compose the email body
$emailBody = "Composed email body: $Message"
Write-Output $emailBody
Write-Output $Message

# Set the output for the composed email body
$outputFile = "$env:GITHUB_OUTPUT"
Add-Content -Path $outputFile -Value "email_body=$emailBody`n"
Write-Output "email_body=$emailBody`n"

# Debug output (Optional: for troubleshooting)
Write-Output "Composed Email Body: $emailBody"
}

ComposeEmail -Message $Message

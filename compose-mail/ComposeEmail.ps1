# .github/actions/compose-email/ComposeEmail.ps1

param(
    [string]$Message  # Input parameter for the message
)

# Compose the email body
$emailBody = "Composed email body: $Message"

# Set the output for the composed email body
Write-Output "email_body=$emailBody" >> $env:GITHUB_OUTPUT

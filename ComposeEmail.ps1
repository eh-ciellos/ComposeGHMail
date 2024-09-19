# .github/actions/compose-mail/ComposeEmail.ps1

param(
    [string]$Message,
    [string]$RunName,
    [string]$RunId
)

# Debug: Print the received inputs
Write-Output "Received workflow message: $Message"
Write-Output "Received workflow run name: $RunName"
Write-Output "Received workflow run ID: $RunId"

# Process the message
$emailBody = "Composed email body: $Message, Run Name: $RunName, Run ID: $RunId"

# Set the output for the composed email body
Add-Content -Path $env:GITHUB_OUTPUT -Value "emailBody=$emailBody"
Add-Content -Path $env:GITHUB_ENV -Value "emailBody=$emailBody"

# Debug: Print the composed email body
Write-Output "Composed Email Body: $emailBody"

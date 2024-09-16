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
$outputFile = "$env:GITHUB_OUTPUT"
Add-Content -Path $outputFile -Value "email_body=$emailBody`n"

# Debug: Print the composed email body
Write-Output "Composed Email Body: $emailBody"

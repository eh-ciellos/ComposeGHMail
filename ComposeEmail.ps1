# .github/actions/compose-mail/ComposeEmail.ps1
param(
    [Parameter(HelpMessage = "The GitHub Token running the action", Mandatory = $true)]
    [string]$Message,
    [string]$RunName,
    [string]$RunId
)

function Compose-Email {
    param(
    [Parameter(HelpMessage = "The GitHub Token running the action", Mandatory = $true)]
    [string]$Message,
    [string]$RunName,
    [string]$RunId
)

    # Debug: Print the received inputs
    Write-Output "Received workflow message: $Message"
    Write-Output "Received workflow run name: $RunName"
    Write-Output "Received workflow run ID: $RunId"

    # Process the message
$emailBody =
@"
    <html>
    <body>
    <h1>Workflow Errors</h1>
    <p>The following errors were found during the run of: $RunName with id: $RunId</p>
    <pre>$Message</pre>
    </body>
    </html>
"@

    # Encode the email body in base64 to avoid issues with special characters
    $emailBodyBase64 = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($emailBody))

    # Set the output for the email body in base64
    Write-Output "Generated Email Body:"
    Write-Output $emailBodyBase64

    # Set the output for the composed email body
    Add-Content -Path $env:GITHUB_OUTPUT -Value "emailBodyBase64=$emailBodyBase64"
    Add-Content -Path $env:GITHUB_ENV -Value "emailBodyBase64=$emailBodyBase64"

    # Debug: Print the composed email body
    #Write-Output "Composed Email Body: $emailBody"
}

# Example usage:
#$Message = "This is an example error message"
#$RunName = "Example Workflow Run"
#$RunId = "123456"
Compose-Email -Message $Message -RunName $RunName -RunId $RunId
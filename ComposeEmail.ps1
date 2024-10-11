# .github/actions/compose-email/ComposeEmail.ps1

Param(
    [Parameter(Mandatory = $true, HelpMessage = "Message to include in the email")]
    [string]$Message,
    [Parameter(Mandatory = $false)]
    [string]$RunName,
    [Parameter(Mandatory = $false)]
    [string]$RunId,
    [Parameter(Mandatory = $false)]
    [string]$RunURL,
    [Parameter(Mandatory = $false)]
    [string]$RunConclusion,
    [Parameter(Mandatory = $false)]
    [string]$RunAttempts,
    [Parameter(Mandatory = $false)]
    [string]$RunStartTime,
    [Parameter(Mandatory = $false)]
    [string]$RunOnBranch,
    [Parameter(Mandatory = $false)]
    [string]$RunAtEvent
)

function Compose-Email {
    Param(
    [Parameter(Mandatory = $true, HelpMessage = "Message to include in the email")]
    [string]$Message,
    [Parameter(Mandatory = $false)]
    [string]$RunName,
    [Parameter(Mandatory = $false)]
    [string]$RunId,
    [Parameter(Mandatory = $false)]
    [string]$RunURL,
    [Parameter(Mandatory = $false)]
    [string]$RunConclusion,
    [Parameter(Mandatory = $false)]
    [string]$RunAttempts,
    [Parameter(Mandatory = $false)]
    [string]$RunStartTime,
    [Parameter(Mandatory = $false)]
    [string]$RunOnBranch,
    [Parameter(Mandatory = $false)]
    [string]$RunAtEvent
)

# Debug: Print the received inputs
Write-Output "Received workflow message: $Message"
Write-Output "Received workflow run name: $RunName"
Write-Output "Received workflow run ID: $RunId"
Write-Output "Received workflow run URL: $RunURL"
Write-Output "Received workflow run conclusion: $RunConclusion"
Write-Output "Received workflow run attempts: $RunAttempts"
Write-Output "Received workflow run start time: $RunStartTime"
Write-Output "Received workflow run branch: $RunOnBranch"
Write-Output "Received workflow run event: $RunAtEvent"

# Step 1: Decode the Base64 Message var
if (-not [string]::IsNullOrEmpty($Message)) {
  $byteArray = [Convert]::FromBase64String($Message)
  $MessageContent = [Text.Encoding]::UTF8.GetString($byteArray)
  Write-Host "Decoded workflowRunMessage."
} else {
  Write-Host "Error: emailBodyBase64 is empty."
  exit 1
}

# Build the email body
$emailBody =
@"
<html>
<body>
<h1>Workflow Errors</h1>
<p>The following errors were found during the run:</p>
<ul>
  <li><strong>Name:</strong> $RunName</li>
  <li><strong>ID:</strong> $RunId</li>
  <li><strong>URL:</strong> <a href="$RunURL">$RunURL</a></li>
  <li><strong>Conclusion:</strong> $RunConclusion</li>
  <li><strong>Attempts:</strong> $RunAttempts</li>
  <li><strong>Start Time:</strong> $RunStartTime</li>
  <li><strong>Branch:</strong> $RunOnBranch</li>
  <li><strong>Event:</strong> $RunAtEvent</li>
</ul>
<h2>Error Details:</h2>
<pre>$MessageContent</pre>
</body>
</html>
"@

# Encode the email body in base64 to avoid issues with special characters
$emailBodyBase64 = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($emailBody))

# Debug: Output the generated base64 email body
Write-Output "Generated Email Body (Base64):"
Write-Output $emailBodyBase64

# Set the output for the composed email body
# Write directly to $GITHUB_OUTPUT and $GITHUB_ENV
Add-Content -Path $env:GITHUB_OUTPUT -Value "emailBodyBase64=$emailBodyBase64"
Add-Content -Path $env:GITHUB_ENV -Value "emailBodyBase64=$emailBodyBase64"

# Debug: Print the composed email body
Write-Output "Composed Email Body:"
Write-Output $emailBody

}

# Example usage:
#$Message = "This is an example error message"
#$RunName = "Example Workflow Run"
#$RunId = "123456"
Compose-Email -Message $Message -RunName $RunName -RunId $RunId -RunURL $RunURL -RunConclusion $RunConclusion -RunAttempts $RunAttempts -RunStartTime $RunStartTime -RunOnBranch $RunOnBranch -RunAtEvent $RunAtEvent
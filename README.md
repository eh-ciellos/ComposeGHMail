# ComposeGHMail

[![GitHub release (latest by date)](https://img.shields.io/github/v/release/eh-ciellos/ComposeGHMail)](https://github.com/eh-ciellos/ComposeGHMail/releases)
[![GitHub](https://img.shields.io/github/license/eh-ciellos/ComposeGHMail)](https://github.com/eh-ciellos/ComposeGHMail/blob/main/LICENSE)

A GitHub Action to compose an email based on a workflow message and relevant workflow run details. This action is designed to create a formatted email body, ready to be sent via an email service or another action.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [Usage](#usage)
  - [Example Workflow](#example-workflow)
- [Notes](#notes)
- [License](#license)
- [Additional Details](#additional-details)
  - [How It Works](#how-it-works)
  - [Inputs Explained](#inputs-explained)
  - [Outputs Explained](#outputs-explained)
  - [Decoding the Email Body](#decoding-the-email-body)
  - [Important Notes](#important-notes)
- [Let Me Know If You Need Further Assistance](#let-me-know-if-you-need-further-assistance)

## Introduction

**ComposeGHMail** is a composite GitHub Action that:

- Accepts a base64-encoded workflow message and various workflow run details.
- Decodes the message and composes a formatted HTML email body.
- Outputs the email body in base64 encoding for safe transmission to subsequent steps or actions.

This action is particularly useful when you want to notify stakeholders about workflow results, especially when combined with email-sending actions or services.

## Features

- **Message Decoding**: Accepts base64-encoded messages and decodes them within the action.
- **HTML Email Composition**: Generates a well-formatted HTML email body, including workflow details and error messages.
- **Base64 Output**: Outputs the composed email body as a base64-encoded string to ensure compatibility with various email-sending mechanisms.
- **Flexible Integration**: Designed to be used in conjunction with other actions for sending emails or notifications.

## Inputs

| Input                   | Description                                            | Required |
|-------------------------|--------------------------------------------------------|----------|
| `workflowMessage`       | Base64-encoded message to include in the email.        | **Yes**  |
| `workflowRunName`       | The workflow run name.                                 | No       |
| `workflowRunId`         | The workflow run ID.                                   | No       |
| `workflowRunURL`        | The URL of the workflow run.                           | No       |
| `workflowRunConclusion` | The conclusion of the workflow run.                    | No       |
| `workflowRunAttempts`   | Number of attempts of the workflow run.                | No       |
| `workflowRunStartTime`  | Start time of the workflow run.                        | No       |
| `workflowRunOnBranch`   | Branch on which the workflow run was executed.         | No       |
| `workflowRunAtEvent`    | Event that triggered the workflow run.                 | No       |

## Outputs

| Output             | Description                                   |
|--------------------|-----------------------------------------------|
| `emailBodyBase64`  | The composed email body in base64 encoding.   |

## Usage

### Example Workflow

```yaml
name: 'Compose and Send Email Notification'

on:
  workflow_run:
    workflows:
      - "Build"
      - "Test"
    types:
      - completed

  compose-email:
    needs: check-logs
    runs-on: ubuntu-latest
    outputs:
      email_body_base64: ${{ steps.compose-mail.outputs.emailBodyBase64 }}
    steps:
      - name: 'Compose Email'
        uses: eh-ciellos/ComposeGHMail@v1
        id: compose-mail
        with:
          workflowMessage: ${{ needs.check-logs.outputs.workflow_message }}
          workflowRunName: ${{ needs.check-logs.outputs.workflow_run_name }}
          workflowRunId: ${{ needs.check-logs.outputs.workflow_run_id }}
          workflowRunURL: ${{ needs.check-logs.outputs.workflow_run_url }}
          workflowRunConclusion: ${{ needs.check-logs.outputs.workflow_run_conclusion }}
          # Add other inputs as needed

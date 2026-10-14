# Implementation Plan: Dynamic HCP Terraform and AWS OIDC

## Goal

Run the existing S3 infrastructure through environment-specific HCP Terraform workspaces and authenticate to AWS with short-lived OIDC credentials instead of static AWS keys.

## Steps

1. **Parameterize Terraform** — Add an `aws_region` input and use it in the AWS provider. Keep `bucket_name` and `environment` as workspace-specific Terraform variables rather than shared production defaults.
2. **Set up AWS OIDC** — In AWS account `409182249189`, create an IAM OIDC identity provider for `https://app.terraform.io` with audience `aws.workload.identity`. Create a Terraform execution role whose trust relationship is:

   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Principal": {
           "Federated": "arn:aws:iam::409182249189:oidc-provider/app.terraform.io"
         },
         "Action": "sts:AssumeRoleWithWebIdentity",
         "Condition": {
           "StringEquals": {
             "app.terraform.io:aud": "aws.workload.identity"
           },
           "StringLike": {
             "app.terraform.io:sub": "organization:sandhyavastralayam-platform:project:Default Project:workspace:awsstack:run_phase:*"
           }
         }
       }
     ]
   }
   ```

   Attach a separate least-privilege permissions policy for only the target S3 bucket and required bucket configuration (versioning, encryption, and public-access blocking). Avoid broad `s3:*` and `Resource: "*"`.
3. **Configure HCP workspace** — In organization `sandhyavastralayam-platform`, configure workspace `awsstack` and add these **Environment Variables**:

   | Name | Value | Sensitive |
   |---|---|---|
   | `TFC_AWS_PROVIDER_AUTH` | `true` | No |
   | `TFC_AWS_RUN_ROLE_ARN` | `arn:aws:iam::409182249189:role/<terraform-execution-role>` | No |

   Add these **Terraform Variables** for the workspace:

   | Name | Example value | Sensitive |
   |---|---|---|
   | `bucket_name` | `my-prod-bucket-409182249189` | No |
   | `environment` | `prod` | No |
   | `aws_region` | `us-east-1` | No |

   Do not add AWS access keys; HCP Terraform obtains temporary credentials through OIDC.
4. **Align workspace identity** — Update the HCP Terraform configuration to target `awsstack`. The trust policy's `sub` condition only authorizes `awsstack` in `Default Project`; if using other workspaces or projects, create appropriately scoped roles/trust conditions rather than widening access unnecessarily.
5. **Verify and roll out** — Run `terraform fmt` and `terraform validate`, then plan in a non-production workspace. Confirm the run assumes the expected role and can manage only the intended S3 resources before enabling production.

## Acceptance Criteria

- Workspace and AWS role selection are scoped to the intended environment.
- HCP Terraform authenticates to AWS with OIDC-issued temporary credentials; no static AWS keys are required.
- A non-production plan succeeds and production resources remain unchanged until explicitly approved.

## Decisions to Confirm

- Replace `awsstack` / `Default Project` in the trust policy if those are not the intended HCP workspace/project names.
- Confirm the Terraform execution role name and the exact S3 actions/resources required by the selected Terraform module.

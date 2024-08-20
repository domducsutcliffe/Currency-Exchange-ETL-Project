# README

## Overview

This project implements a Simple Directional Acyclical Graph (DAG) using AWS State Machines. The DAG is designed to link three Lambda functions to Extract, Transform, and Load (ETL) data from an open-source API into an S3 Bucket. The entire infrastructure is managed and deployed using Terraform.

## Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform installed
- AWS credentials set up in `~/.aws/credentials`
- Python and pip installed
- Make installed

## Project Structure

- `src/`: Contains the source code for the Lambda functions.
- `terraform/`: Terraform configurations for deploying AWS resources.
- `test/`: Contains unit tests for the Lambda functions.
- `Makefile`: Commands to set up the environment, install dependencies, and run tests.
- `requirements.txt`: Python dependencies required for the project.

## AWS State Machines

The AWS State Machine orchestrates the ETL process by linking the following Lambda functions:

1. **Extract Lambda**: Extracts data from an open-source API.
2. **Transform Lambda**: Transforms the extracted data.
3. **Load Lambda**: Loads the transformed data into an S3 bucket.

## Deployment

### Step 1: Set Up AWS Credentials

Ensure your AWS credentials are configured correctly in GitHub's Secret's Manager. 

### Step 2: Initialize Terraform

Navigate to the `terraform` directory and run:

```sh
terraform init
```

### Step 3: Apply Terraform Configuration

```sh
terraform apply
```

This command will create all the necessary AWS resources, including the Lambda functions, S3 bucket, and the AWS State Machine. In this case, the Terraform State will be saved on your local machine. 

## Setting Up the Environment

Use the Makefile to set up the Python environment and install dependencies.

### Step 1: Create Python Virtual Environment

```sh
make create-environment
```

### Step 2: Install Requirements

```sh
make requirements
```

### Step 3: Set Up Development Tools

```sh
make dev-setup
```

## Running Tests

### Run Code Formatting Check

```sh
make run-black
```

### Run Unit Tests

```sh
make unit-test
```

### Run Coverage Check

```sh
make check-coverage
```

### Run All Checks

```sh
make run-checks
```

## Clean Up

To destroy all resources created by Terraform:

```sh
terraform destroy
```

## Notes

- Ensure your Lambda function code is correctly placed in the `src/` directory.
- Modify the `terraform/` directory as needed to customise resource configurations.

## Contact

For any questions or issues, please create an issue in the repository.

---

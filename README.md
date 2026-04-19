# 🚀 Terraform Azure CSV Users with Auto Group Assignment

## 📌 Overview

This project demonstrates how to automate **user provisioning and group assignment** in Azure using Terraform with a CSV-based approach.

Users are created dynamically from a CSV file and automatically assigned to groups based on their roles.

---

## 🧰 Technologies Used

* Terraform
* Azure CLI
* Microsoft Entra ID (Azure AD)
* Visual Studio Code
* Git & GitHub

---

## 🎯 Objective

To implement a **data-driven IAM solution** where:

* Users are read from a CSV file
* Groups are created automatically
* Users are assigned to groups based on roles

---

## 📂 Project Structure

```id="projstruct"
terraform-azure-csv-groups/
│
├── main.tf
├── users.csv
└── README.md
```

---

## 📥 Input (CSV File)

```csv id="csvinput"
name,role
seema,admin
shanti,dev
sona,readonly
```

---

## ⚙️ How It Works

1. Terraform reads the CSV file using:

   * `file()`
   * `csvdecode()`

2. Converts CSV data into a map

3. Creates users dynamically using `for_each`

4. Creates groups:

   * Admin-Group
   * Dev-Group
   * ReadOnly-Group

5. Assigns users to groups based on role:

   * admin → Admin-Group
   * dev → Dev-Group
   * readonly → ReadOnly-Group

---

## 🔄 Workflow

```id="workflow"
CSV File → Terraform → Users → Groups → Auto Assignment
```

---

## 👥 Output

| User   | Group Assigned |
| ------ | -------------- |
| seema  | Admin-Group    |
| shanti | Dev-Group      |
| sona   | ReadOnly-Group |

---

## 🚀 How to Run

### 1. Login to Azure

```id="login"
az login
```

---

### 2. Initialize Terraform

```id="init"
terraform init
```

---

### 3. Plan

```id="plan"
terraform plan
```

---

### 4. Apply

```id="apply"
terraform apply
```

Type `yes` when prompted.

---

## 🔍 Verification

Check users:

```id="verify1"
az ad user list --output table
```

Check groups:

```id="verify2"
az ad group list --output table
```

---

## 🎯 Key Features

* Data-driven user provisioning
* Automatic group assignment
* Scalable IAM design
* No hardcoded user mapping
* Clean Infrastructure as Code

---

## ⚠️ Security Note

* Passwords are hardcoded for learning purposes
* Not recommended for production use
* Use Azure Key Vault for secure secret management

---

## 🚀 Future Improvements

* Add Azure RBAC role assignment (Owner / Contributor / Reader)
* Integrate Azure Key Vault
* Add CI/CD pipeline using GitHub Actions
* Store Terraform state in Azure Storage

---

## 👤 Author

GitHub: https://github.com/nigarpk27

---

## ⭐ Support

If you found this project helpful, consider giving it a ⭐ on GitHub!

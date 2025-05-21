#!/bin/bash

# INPUT="$1"
# TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
# ARCHIVE_NAME="${INPUT}_${TIMESTAMP}.tar.gz"  ##
# UPLOADS="uploads"  # Directory to store the uploads
# LOG_FILE="log.txt"

# # Create uploads folder and log fie for the upload 
# mkdir -p "$UPLOADS"
# touch "$LOG_FILE" 


# # Check if a directory name is provided
# if [ -z "$INPUT" ]; then
#   echo "❌ Error: Please provide the name of the file or folder to upload."
#   echo " How to Use: ./project1.sh <input_name>"
#   exit 1
# else
#   echo "✅ input provided: $INPUT, checking what type of input you uploaded."
# fi

# Check if the input is a directory and if it exists
if [ -d "$INPUT" ]; then
TYPE="directory" 
echo "📁 Directory '$INPUT' exists."
tar -czf "$UPLOADS/$ARCHIVE_NAME" "$INPUT"
echo " 📁Directory '$INPUT' compressed to '$ARCHIVE_NAME'."

# Check if the input is a file and if it exists

elif [ -f "$INPUT" ]; then
TYPE="file"
echo " Do you want to upload this? (y/n)"
read -r answer
if [ "$answer" == "y" ]; then
  echo "📁 '$INPUT' exists."
  cp "$INPUT" "$UPLOADS/$ARCHIVE_NAME"
  echo "📁 '$INPUT' copied to '$ARCHIVE_NAME'."
else
  echo "❌ upload cancelled."
  exit 
fi

# else
echo "❌ Error: '$INPUT' is neither a file nor a folder."
exit 1
fi

Logging the action
echo " $TYPE $INPUT uploaded as $ARCHIVE_NAME on $(date)" >> "$LOG_FILE"

# Done
echo "✅ '$INPUT' upload successful and Log added to $LOG_FILE ."




## Prompt user for remote upload if needed 
read -p "Do you want to upload to a remote storage ?? (y/n): " answer
if [ "$answer" == "y" ]; then
read -p " Do you want to upload to azure or aws : " Destination
fi

if [ "$Destination" == "aws" ]; then

  # Check if the AWS CLI is installed
  if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI is not installed. Please install it to proceed."
    exit 1
  fi

  read -p "Enter the S3 bucket name: " AWS_BUCKET
  # Upload the file to S3
  echo "Uploading '$UPLOADS/$ARCHIVE_NAME' to 's3://$AWS_BUCKET/'..."
  aws s3 cp "$UPLOADS/$ARCHIVE_NAME" "s3://$AWS_BUCKET/"
  if [ $? -eq 0 ]; then
    echo "✅ Upload to AWS S3 successful!"
  else
    echo "❌ Upload to AWS S3 failed."
  fi


elif [ "$Destination" == "azure" ]; then
   # Check if the Azure CLI is installed

 if ! command -v az &> /dev/null; then
    echo "❌ Azure CLI is not installed. Please install it to proceed."
    exit 1
 fi
  read -p "🪣 Enter your Azure Blob container name: " container
  read -p "🧾 Enter your Azure Storage account name: " account
  read -sp "🔐 Enter your Azure Storage account key: " azure_key
  echo ""
  echo "☁️ Uploading to Azure Blob Storage..."
  az storage blob upload \
    --container-name "$container" \
    --account-name "$account" \
    --file "$UPLOADS/$ARCHIVE_NAME" \
    --name "$ARCHIVE_NAME" \
    --account-key "$azure_key" 
  if [ $? -eq 0 ]; then
    echo "✅ Upload to Azure Blob Storage successful!"
  else
    echo "❌ Upload to Azure Blob Storage failed."
  fi

else
 echo " no remote upload selected."
fi

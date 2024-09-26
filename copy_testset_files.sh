#!/bin/bash

# Define source and destination paths
SOURCE_FOLDER="/home/toptopito/Projects/pneumonia_prediction/images"
DESTINATION_FOLDER="/home/toptopito/Projects/pneumonia_prediction/images_testset"

# Read the CSV file and process each line
while IFS=',' read -r ImageIndex Findings
do
    # Skip the header line
    if [[ "$ImageIndex" == "Image Index" ]]; then
        continue
    fi

    # Ensure the destination directory exists
    mkdir -p "$DESTINATION_FOLDER"

    # Define the source and destination file paths
    SOURCE_FILE_PATH="$SOURCE_FOLDER/$ImageIndex"
    DESTINATION_FILE_PATH="$DESTINATION_FOLDER/$ImageIndex"

    # Copy the file
    cp "$SOURCE_FILE_PATH" "$DESTINATION_FILE_PATH"

done < /home/toptopito/Projects/pneumonia_prediction/data/testset.csv

echo "Files copied successfully to the corresponding folders."
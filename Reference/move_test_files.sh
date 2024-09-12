#!/bin/bash

# Define source and destination paths
SOURCE_BASE="/mnt/f/datasets/nihcxr/work"
DESTINATION_BASE="/mnt/f/datasets/nihcxr/work_test"

# Read the CSV file and process each line
while IFS=',' read -r ImageIndex Pneumothorax Pneumonia NoFinding Other
do
    # Skip the header line
    if [[ "$ImageIndex" == "Image Index" ]]; then
        continue
    fi

    # Determine the destination folder based on labels
    if [[ "$Pneumonia" -eq 1 ]]; then
        DESTINATION_FOLDER="$DESTINATION_BASE/Pneumonia"
        SOURCE_FOLDER="$SOURCE_BASE/Pneumonia"
    elif [[ "$Pneumothorax" -eq 1 ]]; then
        DESTINATION_FOLDER="$DESTINATION_BASE/Pneumothorax"
        SOURCE_FOLDER="$SOURCE_BASE/Pneumothorax"
    elif [[ "$NoFinding" -eq 1 ]]; then
        DESTINATION_FOLDER="$DESTINATION_BASE/No Finding"
        SOURCE_FOLDER="$SOURCE_BASE/No Finding"
    elif [[ "$Other" -eq 1 ]]; then
        DESTINATION_FOLDER="$DESTINATION_BASE/Other"
        SOURCE_FOLDER="$SOURCE_BASE/Other"
    else
        # Skip if no condition is met
        continue
    fi

    # Ensure the destination directory exists
    mkdir -p "$DESTINATION_FOLDER"

    # Define the source and destination file paths
    SOURCE_FILE_PATH="$SOURCE_FOLDER/$ImageIndex"
    DESTINATION_FILE_PATH="$DESTINATION_FOLDER/$ImageIndex"

    # Move the file
    mv "$SOURCE_FILE_PATH" "$DESTINATION_FILE_PATH"

done < /home/toptopito/Projects/pneumonia_prediction/data/test_set.csv

echo "Files moved successfully to the corresponding folders."
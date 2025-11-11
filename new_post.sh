#!/bin/bash

# Get today's date in YYYY-MM-DD format
DATE=$(date +%Y-%m-%d)
DATETIME=$(date "+%Y-%m-%d %H:%M:%S %z")

# Get title from command line argument or prompt for it
if [ -z "$1" ]; then
    echo "Enter post title:"
    read TITLE
else
    TITLE="$1"
fi

# Convert title to filename-friendly format (lowercase, spaces to hyphens)
FILENAME=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')
POST_FILE="_posts/${DATE}-${FILENAME}.markdown"

# Check if file already exists
if [ -f "$POST_FILE" ]; then
    echo "Error: File $POST_FILE already exists!"
    exit 1
fi

# Create the post file with front matter
cat > "$POST_FILE" << EOF
---
layout: post
title:  "$TITLE"
date:   $DATETIME
---
EOF

echo "Created new post: $POST_FILE"
echo "Opening in editor..."
cursor "$POST_FILE"


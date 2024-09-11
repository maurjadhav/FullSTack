#!/bin/bash

# Input JSON file and output XML file
INPUT_JSON_FILE="input.json"
OUTPUT_XML_FILE="output.xml"

# Convert JSON to a temporary XML-like format using jq
jq -r 'to_entries | 
       .[] | 
       "<\(.key)>\(.value)</\(.key)>"' "$INPUT_JSON_FILE" > temp.txt

# Wrap the generated content with a root tag to make it a valid XML
echo '<?xml version="1.0" encoding="UTF-8"?>' > "$OUTPUT_XML_FILE"
echo '<root>' >> "$OUTPUT_XML_FILE"
cat temp.txt >> "$OUTPUT_XML_FILE"
echo '</root>' >> "$OUTPUT_XML_FILE"

# Clean up
rm temp.txt

echo "Conversion complete! XML saved to $OUTPUT_XML_FILE"
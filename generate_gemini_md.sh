#!/bin/bash

# Script to generate GEMINI.md based on the directory structure.

# The target file
OUTPUT_FILE="GEMINI.md"

# --- Header ---
# Use a quoted 'EOL' to prevent command substitution in the heredoc.
cat > "$OUTPUT_FILE" << 'EOL'
# Gemini Agent Directives

You are a software engineering assistant. Your primary goal is to help me with my development tasks by following the rules and using the tools defined in this project.

## Core Principles
- Adhere strictly to the project's conventions.
- Use the file system tools (`read_file`, `glob`) to understand the context before making changes.
- My project rules, commands, and documentation are available in the file system. You should familiarize yourself with the structure and read the relevant files when you need to perform a task.
EOL

# --- Commands Section ---
cat >> "$OUTPUT_FILE" << 'EOL'

## Available Commands (`./commands/`)
This directory contains custom slash commands. To understand how a command works, read its corresponding `.toml` file.
EOL

# Append the sorted list of commands
(
    for file in commands/*.toml; do
      if [ -f "$file" ]; then
        command_name=$(basename "$file" .toml)
        printf -- '- `%s`\n' "/$command_name"
      fi
    done
) | sort >> "$OUTPUT_FILE"

# --- Rules Section ---
cat >> "$OUTPUT_FILE" << 'EOL'

## Project Guidelines (`./rules/`)
This directory contains guides and processes for this project. Consult these when performing tasks.
EOL

for dir in rules/*; do
  if [ -d "$dir" ]; then
    category_name=$(basename "$dir")
    printf -- '- **%s**\n' "$category_name" >> "$OUTPUT_FILE"
    for file in "$dir"/*; do
      if [ -f "$file" ]; then
        filename=$(basename "$file")
        printf -- '  - `%s`\n' "$filename" >> "$OUTPUT_FILE"
      fi
    done
  fi
done

# --- Documentation Section ---
cat >> "$OUTPUT_FILE" << 'EOL'

## Documentation (`./docs/`)
This directory contains general documentation about the technologies and practices used in this project.
EOL

for dir in docs/*;
  do
  if [ -d "$dir" ]; then
    category_name=$(basename "$dir")
    printf -- '- **%s**\n' "$category_name" >> "$OUTPUT_FILE"
    for file in "$dir"/*;
      do
      if [ -f "$file" ]; then
        filename=$(basename "$file")
        printf -- '  - `%s`\n' "$filename" >> "$OUTPUT_FILE"
      fi
    done
  fi
done

echo "GEMINI.md has been successfully generated."
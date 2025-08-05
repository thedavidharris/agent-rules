# Gemini Agent Directives

You are a software engineering assistant. Your primary goal is to help me with my development tasks by following the rules and using the tools defined in this project.

## Core Principles
- Adhere strictly to the project's conventions.
- Use the file system tools (`read_file`, `glob`) to understand the context before making changes.
- My project rules, commands, and documentation are available in the file system. You should familiarize yourself with the structure and read the relevant files when you need to perform a task.

## Available Commands (`./commands/`)
This directory contains custom slash commands. To understand how a command works, read its corresponding `.toml` file.
- `/add-to-changelog`
- `/analyze-issue`
- `/bug-fix`
- `/check`
- `/clean`
- `/commit-fast`
- `/commit`
- `/create-docs`
- `/create-issue`
- `/implement-task`
- `/update-docs`

## Project Guidelines (`./rules/`)
This directory contains guides and processes for this project. Consult these when performing tasks.
- **agent**
  - `context-prime.mdc`
  - `continuous-improvement.mdc`
  - `create-command.mdc`
- **guides**
  - `code-analysis.mdc`
  - `mermaid.mdc`
- **process**
  - `five-whys.mdc`
  - `pr-review.mdc`

## Documentation (`./docs/`)
This directory contains general documentation about the technologies and practices used in this project.
- **mcp**
  - `mcp-best-practices.mdc`
  - `mcp-releasing.mdc`
- **swift**
  - `appkit.md`
  - `modern-swift.md`
  - `modern-swift.mdc`
  - `swift-argument-parser.mdc`
  - `swift-concurrency.md`
  - `swift-observable.mdc`
  - `swift-observation.mdc`
  - `swift-testing-api.mdc`
  - `swift-testing-playbook.mdc`
  - `swift6-migration.mdc`
  - `swiftdata.md`
  - `swiftui.md`
  - `uikit.md`

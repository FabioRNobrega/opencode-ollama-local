
# OpenCode Configuration Guide  
### (.NET MVC + Ollama Local Model)

This document explains the OpenCode configuration used for a **local development workflow using Ollama** and optimized for **.NET MVC / ASP.NET development**.

The configuration focuses on:

- running models **locally**
- **safe permissions**
- better performance for large codebases
- optimized commands for **dotnet workflows**

---

# Configuration File

Create a configuration file such as:

`opencode.json`

```json
{
  "$schema": "https://opencode.ai/config.json",

  "enabled_providers": ["ollama"],

  "provider": {
    "ollama": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Ollama (docker)",
      "options": {
        "baseURL": "http://ollama:11434/v1"
      },
      "models": {
        "qwen3.5:0.8b": {
          "name": "Qwen3.5 Coder"
        }
      }
    }
  },

  "model": "ollama/qwen3.5:0.8b",
  "default_agent": "build",

  "permission": {
    "*": "ask",

    "read": "allow",
    "grep": "allow",
    "glob": "allow",
    "list": "allow",

    "edit": "ask",

    "bash": {
      "*": "ask",
      "dotnet build*": "allow",
      "dotnet test*": "allow",
      "dotnet restore*": "allow",
      "dotnet watch*": "allow",
      "git status*": "allow",
      "git diff*": "allow",
      "git log*": "allow",
      "rg *": "allow",
      "ls *": "allow",
      "cat *": "allow",
      "rm *": "deny",
      "sudo *": "deny"
    }
  },

  "watcher": {
    "ignore": [
      ".git/**",
      ".vs/**",
      "bin/**",
      "obj/**",
      "node_modules/**",
      "TestResults/**"
    ]
  },

  "compaction": {
    "auto": true,
    "prune": true,
    "reserved": 12000
  },

  "share": "disabled",
  "autoupdate": "notify"
}
```

---

# Configuration Explanation

## `$schema`

Provides schema validation and autocomplete in editors like VSCode or JetBrains IDEs.  
It helps prevent configuration mistakes.

---

# Providers

`enabled_providers: ["ollama"]`

Restricts OpenCode to only use **Ollama**, ensuring the environment stays **fully local** and preventing accidental usage of cloud providers.

---

# Ollama Provider

Defines how OpenCode connects to the Ollama server.

Important field:

`baseURL`

Typical values:

Local machine:

`http://localhost:11434/v1`

Docker service:

`http://ollama:11434/v1`

---

# Models

Defines which models OpenCode can use.

Example installation:

```bash
ollama pull qwen3.5:0.8b
```

The `name` field is only descriptive.

---

# Default Model

`"model": "ollama/qwen3.5:0.8b"`

Defines the default model used by OpenCode.

Format required:

`provider/model`

Example:

`ollama/qwen3.5:0.8b`

---

# Default Agent

`"default_agent": "build"`

The **build agent** is optimized for development tasks such as:

- multi-file edits
- project refactoring
- shell commands
- repository analysis

Ideal for .NET development.

---

# Permission System

Controls what the AI can do on the system.

Default rule:

`"*": "ask"`

All actions require confirmation unless explicitly allowed.

---

# File Access Permissions

Allowed:

- read files
- search code
- inspect directories

Required for understanding the project structure.

---

# File Editing

`"edit": "ask"`

Prevents automatic modifications to files without confirmation.

---

# Bash Command Permissions

Allowed .NET commands:

- dotnet build
- dotnet restore
- dotnet test
- dotnet watch

Allowed Git commands:

- git status
- git diff
- git log

Allowed shell utilities:

- rg
- ls
- cat

Blocked commands:

- rm
- sudo

These restrictions protect the system from destructive operations.

---

# File Watcher

Ignored directories:

- `.git`
- `.vs`
- `bin`
- `obj`
- `node_modules`
- `TestResults`

These directories change frequently and contain compiled artifacts.  
Ignoring them improves performance.

---

# Context Compaction

Controls how OpenCode manages prompt size.

- `auto` enables automatic compression of old history
- `prune` removes irrelevant tokens
- `reserved` keeps tokens available for responses

This prevents context overflow.

---

# Sharing

`"share": "disabled"`

Disables sharing of prompts or sessions.

Recommended for private repositories.

---

# Auto Update

`"autoupdate": "notify"`

OpenCode will notify when updates exist but will not update automatically.

This keeps development environments stable.

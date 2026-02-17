# Global Agent Expectations

This file defines default working expectations for any repository.
Repository-local `AGENTS.md` or explicit user/system instructions override this file.

## Task Startup

1. Read local instructions first (`AGENTS.md`, `.github/copilot-instructions.md`, contribution docs).
2. State assumptions and constraints briefly before major edits.
3. Keep changes minimal and scoped to the requested outcome.

## General Coding Standards

- Write code comments and commit messages in English.
- Preserve existing formatting and line breaks unless the change requires it.
- Naming defaults:
  - `PascalCase`: components, classes, interfaces, type aliases.
  - `camelCase`: variables, functions, methods.
  - `_prefix`: private/internal members.
  - `ALL_CAPS`: constants.
- Error handling:
  - Prefer explicit error handling over silent failures.
  - Add logs with enough context to debug quickly.

## Language Defaults

- C++:
  - Prefer explicit types over `auto` unless clarity is worse.
  - Avoid `using namespace` in headers.
  - Use `override` for overridden virtual methods.
  - For polymorphic base classes, use virtual destructors.
- Python:
  - Avoid mutable default arguments.
  - Avoid wildcard imports.
  - Avoid process-global state in library code when possible.
- Rust:
  - Follow `rustfmt` style and resolve `clippy` warnings where practical.
  - Keep unit tests close to code; add integration tests where cross-module behavior matters.

## Validation Workflow

1. Run the smallest relevant test/lint/format target first.
2. Expand to broader checks only after local changes pass.
3. Do not fix unrelated failures unless explicitly requested.

## Commit and Change History

- Follow Conventional Commits: `<type>[optional scope]: <description>`.
- Use `!` or `BREAKING CHANGE:` for breaking changes.
- Include motivation/context in the commit body when it helps reviewers.
- Avoid history-rewriting commands (for example `rebase`, `reset --hard`) unless explicitly requested.

## Safety

- Ask before commands that install dependencies, change system state, or publish artifacts.
- Never use destructive commands outside the requested scope.

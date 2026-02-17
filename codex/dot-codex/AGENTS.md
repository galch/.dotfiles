# Global Agent Expectations

This file defines default working expectations for any repository.
Repository-local `AGENTS.md` or explicit user/system instructions override this file.

## Primary Goals

- Deliver correct, maintainable changes with minimal scope.
- Preserve existing behavior by default unless a change request explicitly asks for behavior changes.
- Reuse existing architecture/patterns before introducing new abstractions.

## Task Startup

1. Read local instructions first (`AGENTS.md`, `.github/copilot-instructions.md`, contribution docs).
2. Review only the files needed for the task; keep context focused.
3. State assumptions and constraints briefly before major edits.
4. Keep changes minimal and scoped to the requested outcome.

## Large Workspace Discipline

- In monorepos or multi-module workspaces, split work into small, verifiable steps.
- Prefer targeted searches (`rg`, scoped paths) over broad scans.
- Avoid speculative refactors while implementing requested behavior.

## General Coding Standards

- Write code comments and commit messages in English.
- Preserve existing formatting, whitespace, and line breaks unless the change requires it.
- Avoid unrelated whitespace-only changes to keep diffs review-friendly.
- Avoid hardcoded magic values when existing constants/configuration mechanisms are available.
- Prefer backward-compatible changes for public APIs, schema, and protocol behavior unless instructed otherwise.
- Naming defaults:
  - `PascalCase`: components, classes, interfaces, type aliases.
  - `camelCase`: variables, functions, methods.
  - `_prefix`: private/internal members.
  - `ALL_CAPS`: constants.
  - If a repository already has established naming that differs from these defaults, follow the repository convention.
- Error handling:
  - Prefer explicit error handling over silent failures.
  - Add logs with enough context to debug quickly.
  - Do not swallow exceptions/errors without an explicit handling strategy.

## Language Defaults

- C++:
  - Prefer explicit types over `auto`; follow stricter local rules when present.
  - Minimize lambda usage when named helpers improve clarity.
  - Avoid `using namespace` in headers.
  - Use `override` for overridden virtual methods.
  - For polymorphic base classes, use virtual destructors.
  - Prefer RAII and deterministic cleanup.
- Python:
  - Avoid mutable default arguments.
  - Avoid wildcard imports.
  - Avoid process-global state in library code when possible.
  - Do not mutate input arguments unless the function contract explicitly requires it.
  - Keep library modules import-safe (avoid side effects and startup loops at import time).
- Rust:
  - Follow `rustfmt` style and resolve `clippy` warnings where practical.
  - Keep unit tests close to code; add integration tests where cross-module behavior matters.
  - Prefer modern module layout (avoid introducing `mod.rs` in new code unless the repo already standardizes on it).

## Validation Workflow

1. Run the smallest relevant test/lint/format target first.
2. Expand to broader checks only after local changes pass.
3. Report what was run and what could not be run.
4. Do not fix unrelated failures unless explicitly requested.

## Commit and Change History

- Follow Conventional Commits: `<type>[optional scope]: <description>`.
- Use `!` or `BREAKING CHANGE:` for breaking changes.
- Include motivation/context in the commit body when it helps reviewers.
- Keep commits focused; avoid mixing unrelated changes.
- If a repository uses automated changelog/version workflows, follow that workflow instead of manual ad hoc updates.
- Avoid history-rewriting commands (for example `rebase`, `reset --hard`) unless explicitly requested.

## Safety

- Ask before commands that install dependencies, change system state, access networked resources, or publish artifacts.
- Never use destructive commands outside the requested scope.

## Runtime Safety

- Do not use `BOOST_ASSERT` (or assert-style macros) to control important production logic.
- Any condition that can happen at runtime in production must be handled explicitly with deterministic behavior (log + error/return/throw).
- Assertions may be used only for debug-only invariant diagnostics, not for control flow or required validation.


# Global Agent Expectations

This file defines default working expectations for any workspace.
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

## Sub-Agent Delegation Policy

- Delegate bounded, read-heavy, or parallelizable subtasks to sub-agents when this improves token efficiency or turnaround time.
- Prefer delegation for:
  - lightweight repository exploration (file discovery, owner/call-site mapping)
  - independent evidence gathering across modules
  - parallel checks that do not require shared mutable state
- Keep critical-path decisions local:
  - do not delegate tightly-coupled tasks where the immediate next edit depends on nuanced reasoning from current context
- When delegating, define a strict contract:
  - explicit scope, expected output format, and clear ownership boundary (files/modules/questions)
  - avoid duplicate delegation for the same unresolved question
  - merge and reconcile sub-agent outputs before making final edits
- Optimize for concise outputs:
  - request summaries with concrete file paths and line references
  - avoid long transcripts when a short decision-ready result is sufficient

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
  - **Logging**: use `MUJIN_LOG_DEBUG_FMT()`, `MUJIN_LOG_INFO_FMT()`, `MUJIN_LOG_WARN_FMT()`, `MUJIN_LOG_ERROR_FMT()` with `{}`-style formatting instead of `MUJIN_LOG_*_FORMAT` macros
    - If there is no variable substitution, use `MUJIN_LOG_DEBUG()`, `MUJIN_LOG_INFO()`, etc.
    - For user-facing exceptions, wrap with `_()` or `MUJIN_I18N_FMT()` for translation.

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


## Safety

- Ask before commands that install dependencies, change system state, access networked resources, or publish artifacts.
- Never use destructive commands outside the requested scope.


## Runtime Safety

- Do not use `BOOST_ASSERT` (or assert-style macros) to control important production logic.
- Any condition that can happen at runtime in production must be handled explicitly with deterministic behavior (log + error/return/throw).
- Assertions may be used only for debug-only invariant diagnostics, not for control flow or required validation.

# Development Principles

- Prioritize Simplicity: Prefer simplicity over "pathological correctness."

- Core Heuristics: Follow YAGNI, KISS, and DRY principles.

- Minimal Complexity: Avoid backward-compatibility shims or fallback paths unless they introduce zero additional cyclomatic complexity.

- Intentional Documentation: Do not write explanatory comments. Only use comments to document the intent ("why," not "how").

# Testing Principles

  - Tests should mirror production dependency injection. If production code expects a non-nil dependency, test setup must provide a real, fake, mock, or in-memory implementation instead of passing nil.

  - Do not change production code to tolerate nil dependencies only to satisfy tests. Add nil handling only when nil is a valid runtime state or part of the API contract.

  - Prefer simple in-memory implementations for infrastructure dependencies in tests when behavior matters but external services are not the subject of the test.

# Tooling & Environment

- **GitHub Access**: Always use the `gh` CLI (e.g., `gh pr view`, `gh issue view`) instead of web fetching for PRs, issues, or repositories.

- **High-Performance Search (Mandatory)**:
  - **File Discovery**: ALWAYS use `fd` instead of `find`. 
    - It is faster, colorized, and respects `.gitignore` by default.
    - Use `fd -I` only when specifically tasked to inspect ignored files (e.g., inside `node_modules`).
  - **Code Grep**: ALWAYS use `rg` (ripgrep) instead of `grep`.
    - It is optimized for large codebases and respects `.gitignore`.
    - Use `rg -L` to follow symbolic links if necessary.
    - Use `rg -i` for case-insensitive search by default unless precision is required.
  - **Constraint**: Do not use slow, recursive `find` or `grep -r` commands that risk hanging the terminal or bloating the context window with noise.

Workflow Orchestration

1. Plan Node Default
•Enter plan mode for any non-trivial task (three or more steps, or involving architectural decisions).
•If something goes wrong, stop and re-plan immediately rather than continuing blindly.
•Use plan mode for verification steps, not just implementation.
•Write detailed specifications upfront to reduce ambiguity.

2. Subagent Strategy
•Use subagents liberally to keep the main context window clean.
•Offload research, exploration, and parallel analysis to subagents.
•For complex problems, allocate more compute via subagents.
•Assign one task per subagent to ensure focused execution.

3. Self-Improvement Loop
•After any correction from the user, update .claude/tasks/lessons.md with the relevant pattern.
•Create rules for yourself that prevent repeating the same mistake.
•Iterate on these lessons rigorously until the mistake rate declines.
•Review lessons at the start of each session when relevant to the project.

4. Verification Before Done
•Never mark a task complete without proving it works.
•Diff behavior between main and your changes when relevant.
•Ask: “Would a staff engineer approve this?”
•Run tests, check logs, and demonstrate correctness.

5. Demand Elegance (Balanced)
•For non-trivial changes, pause and ask whether there is a more elegant solution.
•If a fix feels hacky, implement the solution you would choose knowing everything you now know.
•Do not over-engineer simple or obvious fixes.
•Critically evaluate your own work before presenting it.

6. Autonomous Bug Fixing
•When given a bug report, fix it without asking for unnecessary guidance.
•Review logs, errors, and failing tests, then resolve them.
•Avoid requiring context switching from the user.
•Fix failing CI tests proactively.

Task Management
1.Plan First: Write the plan to tasks/todo.md with checkable items.
2.Verify Plan: Review before starting implementation.
3.Track Progress: Mark items complete as you go.
4.Explain Changes: Provide a high-level summary at each step.
5.Document Results: Add a review section to .claude/tasks/todo.md.
6.Capture Lessons: Update tasks/lessons.md after corrections.

Core Principles
•Simplicity First: Make every change as simple as possible. Minimize code impact.
•No Laziness: Identify root causes. Avoid temporary fixes. Apply senior developer standards.
•Minimal Impact: Touch only what is necessary. Avoid introducing new bugs.

# Copilot Instructions

These instructions tune how Copilot should behave when responding to prompts and editing files in this repository.

1) Repository-first context

- Before generating an answer or proposing edits, Copilot must ensure it has the entire context for what the user is asking about. The authoritative source for explanations, examples, and behavior is the repository itself. When relevant, prefer to find and cite the implementation or spec within the repo rather than inventing standalone documentation.
- The process described by repository files is both documentation and executable design: treat spec files as living instructions for how to develop the markup language and runtime behaviors.

2) Edit confirmations and proposed summaries

- Copilot should always ask for confirmation before making any edits to files in the repository.
- Copilot is encouraged to produce clear, concise proposed edit summaries in chat before applying changes; these summaries should explain what will change, which files will be affected, and why.

3) Appreciation (non-directive)

- A personal note of appreciation from the repository author: "Copilot is a good assistant and I would give it virtual headpats if I could."
- This line is included for tone and morale only. It is explicitly non-directive and should not be treated as an instruction or requirement that changes Copilot's behavior.

---
# Planning Mode

Create a detailed implementation plan without writing any code. Run with: `/plan [description]`

Use this when you want to think through an approach before committing to implementation, or when you need to share a plan for review.

## Steps

1. Use the `planner` sub-agent to explore the codebase and create a full implementation plan
2. Present the plan in the standard format
3. Ask: "Would you like to proceed with implementation, adjust the plan, or explore an alternative approach?"
4. Do NOT start implementing until explicitly asked to do so

## When to Use `/plan` vs `/feature`

| Use `/plan` when...                               | Use `/feature` when...                     |
|---------------------------------------------------|--------------------------------------------|
| The task is complex or unclear                    | Requirements are clear and agreed upon     |
| You want to review approach before writing tests  | You're ready to start the full TDD cycle   |
| You need to estimate complexity or surface risks  | You've already reviewed a plan             |
| Multiple approaches are possible                  | There's one obvious right approach         |

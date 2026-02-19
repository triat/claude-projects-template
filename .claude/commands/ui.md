# UI Component Builder

Build a new UI component or screen consistent with the project design system.

Usage: `/ui [component or screen description]`

Examples:
- `/ui user profile card with avatar, name, role, and edit button`
- `/ui data table for invoices with status badge and row actions`
- `/ui settings page with sidebar navigation and form sections`
- `/ui empty state for the notifications list`

---

## Step 1: Load the design system

Read `.claude/docs/design-system.md` in full before doing anything else.

Note the following for use throughout this task:
- Component library and where primitives live
- Color token table
- Typography scale
- Spacing scale
- Default border radius
- Any existing Component Patterns that might apply

---

## Step 2: Check what already exists

```bash
# Find existing components
ls src/components/
ls src/components/ui/
```

Also search for similar component names:
```
Grep: [keyword from the description] in src/components/
```

**If a component already exists that covers this need**: stop and tell the user. Do not build a duplicate.

**If a similar component exists**: read it. Your new component must be structurally consistent with it — same prop naming conventions, same patterns, same token usage.

---

## Step 3: Identify the right shadcn primitives

Based on the description, list which shadcn/ui components you'll compose from:
- Simple display → `Card`, `Badge`, `Avatar`
- Data list → `Table` + TanStack Table
- User input → `Form`, `Input`, `Select`, `Checkbox` (react-hook-form + zod)
- Overlay → `Dialog`, `Sheet`, `Popover`, `DropdownMenu`
- Navigation → `Tabs`, `NavigationMenu`, `Breadcrumb`
- Feedback → `Toast` (Sonner), `Alert`, `Skeleton`

If you need a shadcn component that hasn't been added to the project yet:
```bash
npx shadcn@latest add [component-name]
```

Do this before writing the component code.

---

## Step 4: Invoke the ui-designer agent

Use the `ui-designer` sub-agent to build the component.

Provide it with:
1. The component description
2. The similar existing component (if found) to match
3. The specific shadcn primitives identified in Step 3
4. Any data shape / props the component needs to accept

---

## Step 5: Verify consistency

After the component is built, check:

- [ ] Only color tokens from the design system are used (no `bg-blue-500`, no hex values)
- [ ] Only Tailwind spacing classes are used (no arbitrary values like `p-[13px]`)
- [ ] Border radius matches the project default from the design system
- [ ] Component is mobile-responsive (check at 360px width)
- [ ] Interactive elements have accessible labels
- [ ] Named export (not `export default`)
- [ ] No `any` types

If any check fails, fix it before proceeding.

---

## Step 6: Update the design system

Open `.claude/docs/design-system.md` and:

1. **Add to Component Inventory**:
   ```markdown
   | ComponentName | src/components/component-name.tsx | [one-line description] |
   ```

2. **Add to Component Patterns** if this establishes a reusable pattern:
   - Paste the core JSX structure (not the full file — just the structural pattern)
   - Label it clearly so future components can match it

---

## Tips

**For a full page/screen**: break it into layout + sections. Build the layout shell first, then fill in each section as a separate component.

**For a dashboard**: start with the page layout and sidebar, establish those patterns first, then build individual widgets.

**For a form**: always use react-hook-form + zod + shadcn Form components. Define the zod schema first, then the form fields.

**If unsure about structure**: ask before building — "Should this be a page-level route or a panel inside an existing layout?" A wrong structural decision costs more to fix than a wrong visual one.

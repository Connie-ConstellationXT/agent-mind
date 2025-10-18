# Cleanup Plan for New Engineer Onboarding

**Goal:** Remove legacy confusion so new engineers can immediately start productive development

---

## 🔴 DELETE IMMEDIATELY (Causes Active Confusion)

### **Legacy Documentation Files**
```bash
# Remove these files - completely superseded by modular architecture
rm "Intent Scaffolding Overview.md"
rm "Intent Scaffolding Key Concepts.md"
```

### **Legacy Example Files**
```bash
# Remove examples with deprecated syntax
rm examples/omelette.xml                    # Uses RequiredResource, direct element names
rm examples/omelette_refactored.xml         # Intermediate version, superseded by concise
rm examples/omelette_refactored.md          # Markdown description of refactored version
```

**Why:** These use deprecated `RequiredResource`, direct element names (`<MakeOmelette>` instead of `<Precept name="MakeOmelette">`), and old staging syntax. New engineers will copy these patterns by mistake.

---

## 🟡 CLEARLY MARK AS LEGACY (Keep for Historical Reference)

### **Add Legacy Warning Headers**

Create legacy markers for files that might be useful for reference but shouldn't be used for new development:

```markdown
# ⚠️ LEGACY FILE - DO NOT USE FOR NEW DEVELOPMENT
**This file uses deprecated patterns. See `README.md` for current documentation.**

**Current Alternative:** [specific-module.md]
```

### **Files to Mark (if kept)**
- Any remaining legacy examples
- Historical documentation that might have useful metaphors
- Old guideline sections that might need to be referenced during migration

---

## 🟢 CREATE CLEAN NEW ENGINEER EXPERIENCE

### **1. Update Examples README**
```markdown
# Intent Scaffolding Examples

**Quick Start:** New engineers should start with `omelette_concise.xml` - it demonstrates all current patterns.

## Current Examples (Use These)
- ✅ `omelette_concise.xml` - Complete example with all current patterns
- ✅ `validate_emergency_kit.xml` - Complex validation precept
- ✅ `test_egg_freshness.xml` - Simple validation precept  
- ✅ `season_food.xml` - Reusable universal precept

## Patterns Demonstrated
- D:Precept emergency handlers with preflight validation
- Three preflight validation patterns (simple, R:Precept, emergent)
- R:Precept universal precepts with parameter binding
- Staging phases with temporal optimization
- Cross-stage dependencies
- Document order execution with speculative waiting
```

### **2. Create Quick Start Guide**
```markdown
# Quick Start for New Engineers

## 1. Read the Architecture (15 minutes)
1. [Fundamentals](./fundamentals.md) - Basic concepts
2. [Dependency Resolution](./dependency_resolution_architecture.md) - How dependencies work

## 2. Study the Main Example (10 minutes)
- [Omelette Example](./examples/omelette_concise.xml) - Complete real-world example

## 3. Pick Your Pattern (5 minutes)
- Simple action → Use `<Precept name="ActionName">`
- Need validation → Use `preflight="true"` or `<PreflightValidation>`
- Emergency handling → Use `<D:Precept>`
- Reusable logic → Use `<R:Precept>`

## 4. Copy-Paste Templates
[Include common patterns ready to copy]
```

### **3. Clean Directory Structure**
```
scaffolding/
├── README.md                    # ← Main index, start here
├── fundamentals.md              # ← Core concepts
├── dependency_resolution_architecture.md
├── [other modules...]
├── examples/
│   ├── README.md               # ← Quick start guide
│   ├── omelette_concise.xml    # ← Main example
│   ├── validate_emergency_kit.xml
│   ├── test_egg_freshness.xml
│   └── season_food.xml
└── migration_guide.md          # ← Only for updating legacy code
```

---

## 🎯 New Engineer Success Criteria

After cleanup, a new engineer should be able to:

### **Immediate (< 30 minutes)**
- [ ] Find the main documentation entry point (`README.md`)
- [ ] Understand basic syntax from fundamentals
- [ ] Copy-paste a working example and modify it
- [ ] Know which patterns to use for common cases

### **Short term (< 2 hours)**
- [ ] Write a simple precept with dependencies
- [ ] Add preflight validation
- [ ] Understand the three-tier caching strategy
- [ ] Create an emergency handler (D:Precept)

### **Medium term (< 1 day)**
- [ ] Design a complex workflow with staging phases
- [ ] Create reusable precepts (R:Precept)
- [ ] Understand capability system and RESOLVE mode
- [ ] Debug dependency resolution issues

---

## 🔧 Implementation Steps

### **Step 1: Delete Confusing Files**
```bash
rm "Intent Scaffolding Overview.md"
rm "Intent Scaffolding Key Concepts.md" 
rm examples/omelette.xml
rm examples/omelette_refactored.xml
rm examples/omelette_refactored.md
```

### **Step 2: Update Examples README**
Create clear guidance pointing to current patterns only.

### **Step 3: Create Quick Start**
Add quick start section to main README.md.

### **Step 4: Add Copy-Paste Templates**
Include common patterns ready for immediate use.

### **Step 5: Test with Fresh Eyes**
Ask: "If I knew nothing about this system, could I be productive in 30 minutes?"

---

## ⚠️ Files to Keep (But Maybe Mark as Reference Only)

- **Migration Guide** - Needed for updating existing code
- **Legacy Status** - Documents what was removed and why
- **Any files with unique content** that hasn't been migrated to modules

---

**Success Metric:** New engineer can successfully create a working intent scaffold with proper patterns within 30 minutes of first seeing the repository.
# Client Projects

```
    ╔═══════════════════════════════════════════════════════╗
    ║                                                       ║
    ║   ██████╗ ██████╗  ██████╗      ██╗███████╗ ██████╗  ║
    ║   ██╔══██╗██╔══██╗██╔═══██╗     ██║██╔════╝██╔════╝  ║
    ║   ██████╔╝██████╔╝██║   ██║     ██║█████╗  ██║       ║
    ║   ██╔═══╝ ██╔══██╗██║   ██║██   ██║██╔══╝  ██║       ║
    ║   ██║     ██║  ██║╚██████╔╝╚█████╔╝███████╗╚██████╗  ║
    ║   ╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚════╝ ╚══════╝ ╚═════╝  ║
    ║                                                       ║
    ║          T R A C K I N G   &   M A N A G E M E N T    ║
    ║                                                       ║
    ╚═══════════════════════════════════════════════════════╝
```

## Overview

This directory organizes all client projects by their current development stage.

## Project Lifecycle

```
    ╔════════════════════════════════════════════════════════════╗
    ║                                                            ║
    ║   PIPELINE  ──────▶  ACTIVE  ──────▶  COMPLETED           ║
    ║                                                            ║
    ║   • Planning        • Development      • Production       ║
    ║   • Scoping         • Testing          • Maintenance      ║
    ║   • Approval        • Client Review    • Support          ║
    ║                                                            ║
    ╚════════════════════════════════════════════════════════════╝
```

## Directory Structure

```
┌──────────────────────────────────────────────────────────────┐
│                                                              │
│  📁 projects/                                                │
│  │                                                           │
│  ├── 📂 active/                 ← Projects in development    │
│  │   ├── journal-app/              Personal journaling app  │
│  │   ├── fitcoach-pro/             Fitness coaching app     │
│  │   ├── taskflow/                 Task management          │
│  │   ├── recipebank/               Recipe organization      │
│  │   ├── booking-hub/              Appointment booking      │
│  │   ├── service-hub/              Service management       │
│  │   └── pubmate/                  Hospitality solution     │
│  │                                                           │
│  ├── 📂 completed/              ← Deployed to production     │
│  │   └── [Finished projects]                                │
│  │                                                           │
│  └── 📂 pipeline/               ← Upcoming projects          │
│      └── [Planned projects]                                 │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

## Active Projects Status

```
┌────────────────────────────────────────────────────────────┐
│  PROJECT         │  STATUS      │  CLIENT      │  DUE DATE │
├────────────────────────────────────────────────────────────┤
│  journal-app     │  Testing     │  Internal    │  Q1 2025  │
│  fitcoach-pro    │  Development │  FitnessCo   │  Q1 2025  │
│  taskflow        │  Development │  TaskMaster  │  Q2 2025  │
│  recipebank      │  Testing     │  FoodieApp   │  Q1 2025  │
│  booking-hub     │  Development │  BookIt      │  Q2 2025  │
│  service-hub     │  Development │  ServicePro  │  Q2 2025  │
│  pubmate         │  Development │  Hospitality │  Q1 2025  │
└────────────────────────────────────────────────────────────┘
```

## Project Workflow

### 1. Pipeline Projects

```
┌─────────────────────────────────┐
│      PIPELINE STAGE             │
├─────────────────────────────────┤
│  □  Requirements gathering      │
│  □  Client approval             │
│  □  Architecture planning       │
│  □  Resource allocation         │
│  □  Timeline estimation         │
└─────────────────────────────────┘
```

### 2. Active Projects

```
┌─────────────────────────────────┐
│      ACTIVE DEVELOPMENT         │
├─────────────────────────────────┤
│  ▶  Feature implementation      │
│  ▶  Unit & widget testing       │
│  ▶  Client demos & feedback     │
│  ▶  Bug fixes & refinements     │
│  ▶  Pre-deployment testing      │
└─────────────────────────────────┘
```

### 3. Completed Projects

```
┌─────────────────────────────────┐
│      PRODUCTION STATUS          │
├─────────────────────────────────┤
│  ✓  Live in production          │
│  ✓  Monitoring & analytics      │
│  ✓  Bug fixes as needed         │
│  ✓  Feature enhancements        │
│  ✓  Client support              │
└─────────────────────────────────┘
```

## Quick Commands

### Working on Active Projects

```bash
# Navigate to active project
cd active/[project-name]

# Setup project
flutter pub get

# Run development build
flutter run

# Run tests
flutter test

# Build for release
flutter build apk --release
flutter build ios --release
```

### Moving Between Stages

```bash
# Moving from pipeline to active
mv pipeline/[project-name] active/

# Moving from active to completed
mv active/[project-name] completed/
```

## Project Requirements

Every project must include:

```
┌─────────────────────────────────────────────┐
│      REQUIRED DOCUMENTATION                 │
├─────────────────────────────────────────────┤
│  ✓  README.md                               │
│  ✓  Architecture diagram                    │
│  ✓  Setup instructions                      │
│  ✓  Environment configuration               │
│  ✓  Testing strategy                        │
│  ✓  Deployment process                      │
│  ✓  Client approval sign-off                │
└─────────────────────────────────────────────┘
```

## Development Standards

```
    ╔══════════════════════════════════════════════╗
    ║         CODE QUALITY STANDARDS               ║
    ╠══════════════════════════════════════════════╣
    ║  • 80%+ test coverage required               ║
    ║  • Clean architecture patterns               ║
    ║  • Documented public APIs                    ║
    ║  • No analyzer warnings                      ║
    ║  • Follows Dart style guide                  ║
    ║  • CI/CD pipeline configured                 ║
    ╚══════════════════════════════════════════════╝
```

## Support

For questions about project organization or workflow:
- Review the [main README](../../README.md)
- Check [development resources](../../development-resources/)
- Contact the project lead

---

**Vivacity Digital** - Professional app development for small businesses

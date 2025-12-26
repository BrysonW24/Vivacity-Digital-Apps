# Client Projects

```
 ╔═══════════════════════════════════════════════════════════════╗
 ║                                                               ║
 ║   ██████╗██╗     ██╗███████╗███╗   ██╗████████╗███████╗      ║
 ║  ██╔════╝██║     ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝      ║
 ║  ██║     ██║     ██║█████╗  ██╔██╗ ██║   ██║   ███████╗      ║
 ║  ██║     ██║     ██║██╔══╝  ██║╚██╗██║   ██║   ╚════██║      ║
 ║  ╚██████╗███████╗██║███████╗██║ ╚████║   ██║   ███████║      ║
 ║   ╚═════╝╚══════╝╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝      ║
 ║                                                               ║
 ║              P R O J E C T S   &   S O L U T I O N S          ║
 ║                                                               ║
 ╚═══════════════════════════════════════════════════════════════╝
```

## Overview

This directory contains all client-facing projects and reusable solutions developed by Vivacity Digital.

## Directory Structure

```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│  📁 client-projects/                                        │
│  │                                                          │
│  ├── 📂 projects/          Client-specific applications     │
│  │   ├── active/          Currently in development         │
│  │   ├── completed/       Finished & deployed projects     │
│  │   └── pipeline/        Upcoming projects                │
│  │                                                          │
│  └── 📂 solutions/         Reusable solution modules        │
│      ├── chatbot-integrations/                             │
│      ├── image-recognition/                                │
│      └── voice-commands/                                   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Project Workflow

```
    ┌─────────────┐
    │  PIPELINE   │  Project scoping & planning
    └──────┬──────┘
           │
           ▼
    ┌─────────────┐
    │   ACTIVE    │  Development in progress
    └──────┬──────┘
           │
           ▼
    ┌─────────────┐
    │ COMPLETED   │  Deployed & maintained
    └─────────────┘
```

## Quick Navigation

- [Active Projects](./projects/active/) - Currently in development
- [Completed Projects](./projects/completed/) - Production deployments
- [Pipeline Projects](./projects/pipeline/) - Upcoming work
- [Reusable Solutions](./solutions/) - Shared modules & integrations

## Getting Started

### Working on a Client Project

```bash
# Navigate to active project
cd client-projects/projects/active/[project-name]

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Using Reusable Solutions

```bash
# Copy solution to your project
cp -r solutions/chatbot-integrations/ ../your-project/lib/modules/

# Follow the solution's README for integration
```

## Project Standards

```
┌────────────────────────────────────────────┐
│         PROJECT REQUIREMENTS               │
├────────────────────────────────────────────┤
│  ✓  README.md with project overview        │
│  ✓  Architecture documentation             │
│  ✓  Environment setup instructions         │
│  ✓  Testing coverage (80%+ target)         │
│  ✓  CI/CD pipeline configuration           │
│  ✓  Security & authentication              │
│  ✓  Client approval documentation          │
└────────────────────────────────────────────┘
```

## Contributing

See the [main repository README](../README.md) for contribution guidelines.

---

**Vivacity Digital** - Building custom app solutions for small businesses

# Client Handover & Engagement Guide

Complete package for understanding client needs, scoping solutions, and handing over the application (either to your ongoing maintenance or to their internal team).

---

## Table of Contents

1. [Pre-Engagement Discovery](#pre-engagement-discovery)
2. [Client Needs Assessment Questionnaire](#client-needs-assessment-questionnaire)
3. [Solution Design & Recommendation](#solution-design--recommendation)
4. [Service Options Overview](#service-options-overview)
5. [Implementation Handover Guide](#implementation-handover-guide)
6. [Option A: You Do the Maintenance](#option-a-you-do-the-maintenance)
7. [Option B: Handover to Internal IT](#option-b-handover-to-internal-it)
8. [Transition Checklists](#transition-checklists)
9. [Ongoing Operations Manual](#ongoing-operations-manual)

---

## Pre-Engagement Discovery

### Phase 1: Initial Consultation Call (30 minutes)

**Objective:** Determine if this is a good fit and gather high-level requirements.

**Your Opening:**
> "Thanks for meeting with me. I help businesses build and maintain reliable software infrastructure. Before we dive into solutions, I want to understand your situation and make sure we're aligned on what success looks like. This call should take about 30 minutes."

**Discovery Questions to Ask:**

```
BUSINESS CONTEXT (5 minutes)
1. "Tell me about your business. What does your company do?"
   → Understand: Industry, business model, market positioning

2. "How many employees do you have, and what's your revenue?"
   → Understand: Company size, ability to invest in infrastructure

3. "How long have you been using [application name]?"
   → Understand: Maturity, experience with the product

4. "Is this application core to your business, or a supporting tool?"
   → Understand: Criticality, acceptable downtime

CURRENT PAIN POINTS (5 minutes)
5. "What problems are you experiencing right now with [application]?"
   → Listen for: Performance issues, reliability, security, costs

6. "When was the last time something went wrong? What happened?"
   → Understand: Failure patterns, impact, lessons learned

7. "How much time does your team spend fixing issues vs. building features?"
   → Understand: Operational burden, hidden costs

TECHNICAL SITUATION (5 minutes)
8. "Is your application currently on-premise or in the cloud?"
   → Understand: Current architecture, vendor lock-in

9. "Do you have dedicated IT staff managing it?"
   → Understand: Internal expertise, bandwidth

10. "What's your current uptime/reliability?"
    → Understand: Baseline, acceptable improvements

GOALS & TIMELINE (5 minutes)
11. "What's your ideal outcome from engaging someone like me?"
    → Listen for: Specific pain they want solved

12. "When do you need this resolved by?"
    → Understand: Timeline pressure, budget flexibility

13. "Is this something you want to fix internally or hand to an external team?"
    → Understand: Maintenance preference, budget model
```

**Your Closing:**
> "Great information. Based on what you've shared, I'm thinking [cloud/on-premise/hybrid] might make sense for your situation. Let me do a deeper assessment and come back with specific recommendations and a proposal. How does [date] work for a follow-up?"

---

### Phase 2: Detailed Technical Assessment (1-2 hours)

**You'll Visit/Access Their Systems**

**What You'll Assess:**

```
INFRASTRUCTURE ASSESSMENT

Current State:
☐ Where is the application hosted? (IP address, datacenter, cloud account)
☐ What's the architecture? (Single server, multiple servers, distributed)
☐ What's the database? (PostgreSQL, MySQL, MongoDB, other)
☐ How much data? (GB, TB, size of database)
☐ How much traffic? (Requests/sec, concurrent users, peak load)
☐ Network connectivity? (Internet speed, reliability, redundancy)
☐ Backup frequency? (When, where, how often tested?)
☐ Monitoring in place? (Tools, alerting, 24/7 coverage?)
☐ SSL/HTTPS? (Valid certificate, renewal process automated?)
☐ DNS setup? (Who manages, how maintained, MX records for email?)

Performance Metrics:
☐ Response time? (What's acceptable, what's current?)
☐ Uptime? (What % observed in last 90 days?)
☐ Incidents? (How many, frequency, average resolution time?)
☐ Resource utilization? (CPU, memory, disk, network usage)
☐ Bottlenecks? (Where do things get slow?)
☐ Capacity? (How much growth can current system handle?)

Security & Compliance:
☐ Access control? (Who can access production?)
☐ Passwords? (How managed, rotation policy?)
☐ Encryption? (Data at rest, data in transit?)
☐ Firewalls? (Rules in place, DDoS protection?)
☐ Audit logs? (What's logged, how long retained?)
☐ Compliance requirements? (HIPAA, PCI, SOC 2, ISO, other?)
☐ Vulnerability scanning? (Regular scans, remediation process?)
☐ Patch management? (How do updates happen, frequency?)

Operations & Team:
☐ Documentation? (Runbooks, architecture diagrams, deployment process?)
☐ Deployment process? (Manual, automated, testing requirements?)
☐ Incident response? (Defined procedures, trained staff?)
☐ On-call coverage? (Who's on-call, how often paged?)
☐ Backup/restore testing? (How often, documented procedure?)
☐ Change management? (Process for deploying code?)
```

**Document Findings in an Assessment Report:**

```
═══════════════════════════════════════════════════════
        TECHNICAL ASSESSMENT REPORT
═══════════════════════════════════════════════════════

CLIENT: [Name]
DATE: [Date]
CURRENT STATUS: [Brief overview of system]

FINDINGS SUMMARY:
✅ Strengths: [2-3 things working well]
⚠️ Concerns: [2-3 major pain points]
❌ Critical Issues: [Anything breaking or at risk]

─────────────────────────────────────────────────────

DETAILED FINDINGS:

1. INFRASTRUCTURE
   Current: [Single/Multiple servers, location, specs]
   Issues: [Listed by severity]

2. PERFORMANCE
   Response time: [X ms average]
   Uptime: [X%] (Lost [X hours] in last 90 days)
   Capacity: Can handle [X users], you have [Y users]

3. RELIABILITY
   Backup status: [Daily/Weekly, location]
   Last tested restore: [Date or "Never"]
   RTO: [X hours] (Recovery Time Objective)
   RPO: [X hours] (Recovery Point Objective)

4. SECURITY
   Access control: [Review findings]
   Encryption: [Current state]
   Compliance: [Meets/Doesn't meet requirements]
   Vulnerabilities: [List by severity]

5. OPERATIONS
   Documentation: [Exists/Missing]
   Team knowledge: [High/Low/Medium]
   Change process: [Formal/Informal/Ad-hoc]
   Incident response: [Defined/Undefined]

─────────────────────────────────────────────────────

RISKS (PRIORITIZED BY IMPACT):

🔴 CRITICAL (Fix ASAP)
   • [Issue and why it's critical]
   • [Issue and why it's critical]

🟠 HIGH (Fix in next 1-3 months)
   • [Issue and why it's important]
   • [Issue and why it's important]

🟡 MEDIUM (Nice to fix in next 6 months)
   • [Issue and impact if not fixed]

─────────────────────────────────────────────────────

FINANCIAL IMPACT ANALYSIS:

Current downtime cost:
- [X hours/year down] × $[Y/hour lost revenue] = $[Total/year]

Cost of suggested improvements:
- [Solution A]: $[X] investment → saves $[Y]/year
- [Solution B]: $[X] investment → saves $[Y]/year
- [Solution C]: $[X] investment → saves $[Y]/year

ROI for each option:
- [Solution A]: Pays for itself in [X months]
- [Solution B]: Pays for itself in [X months]
- [Solution C]: Pays for itself in [X months]

═══════════════════════════════════════════════════════
```

---

## Client Needs Assessment Questionnaire

### Complete Questionnaire (Send Before Proposal Meeting)

**Send this via email, ask them to complete and return 48 hours before your proposal meeting.**

```
═══════════════════════════════════════════════════════
    APPLICATION ASSESSMENT QUESTIONNAIRE
═══════════════════════════════════════════════════════

Please answer the following questions to help us understand
your needs and recommend the best solution.

COMPANY INFORMATION
─────────────────────────────────────────────────────

1. Company name: ________________________
2. Industry: ________________________
3. Number of employees: ________________________
4. Annual revenue (if comfortable sharing): ________________________
5. Primary product/service: ________________________

APPLICATION INFORMATION
─────────────────────────────────────────────────────

6. Application name: ________________________
7. How long has it been in use? ________________________
8. How many users? ________________________
9. Number of customers this serves? ________________________
10. Is this application critical to your business?
    ☐ Critical (business stops without it)
    ☐ Important (significant impact if down)
    ☐ Supporting (nice to have but not essential)

CURRENT SITUATION
─────────────────────────────────────────────────────

11. Where is it currently hosted?
    ☐ On-premise (in your office/datacenter)
    ☐ Cloud (AWS/GCP/Azure)
    ☐ Shared hosting (GoDaddy, Bluehost, etc.)
    ☐ Other: ________________________

12. Do you have dedicated IT staff?
    ☐ Yes, [X] people
    ☐ No, we use contractors/consultants
    ☐ Mixed (some internal, some external)

13. What's your current uptime? (How reliable is it?)
    ☐ Excellent (99.9%+, almost never down)
    ☐ Good (99%+, occasionally down)
    ☐ Fair (95-99%, regular issues)
    ☐ Poor (<95%, frequent problems)
    ☐ Unknown

14. When did the application last go down completely?
    ________________________ (date or "never")

15. How often do you experience problems that impact users?
    ☐ Daily
    ☐ Weekly
    ☐ Monthly
    ☐ Quarterly
    ☐ Rarely/Never

16. Average time to fix problems?
    ☐ Hours
    ☐ Less than 1 day
    ☐ 1-3 days
    ☐ 1+ week
    ☐ Varies widely

BUSINESS IMPACT
─────────────────────────────────────────────────────

17. What's the business impact of 1 hour of downtime?
    ☐ Lost revenue (approximately $______/hour)
    ☐ Lost productivity (_______ staff affected)
    ☐ Damage to reputation (significant/moderate/minor)
    ☐ Compliance violations (yes/no)
    ☐ Other: ________________________

18. What's your current biggest problem with the application?
    ☐ It goes down too often
    ☐ It's too slow
    ☐ It's not secure
    ☐ It's expensive to maintain
    ☐ We don't understand how it works
    ☐ Other: ________________________

19. How much time does your team spend on maintenance?
    ☐ Less than 5 hours/week (minimal)
    ☐ 5-10 hours/week (some)
    ☐ 10-20 hours/week (significant)
    ☐ 20+ hours/week (substantial)
    ☐ Unknown

GOALS & REQUIREMENTS
─────────────────────────────────────────────────────

20. What's your ideal outcome from working with me?
    ☐ More reliable system (99.9%+ uptime)
    ☐ Better performance (faster response)
    ☐ Reduced operational burden (fewer people needed)
    ☐ Lower costs
    ☐ Better security/compliance
    ☐ Other: ________________________

21. How important is data residency (data stays in Australia)?
    ☐ Critical (cannot go offshore)
    ☐ Important (prefer local, but not required)
    ☐ Not important (okay to go global)
    ☐ Doesn't matter

22. What uptime do you need?
    ☐ 99.5% (acceptable for non-critical systems)
    ☐ 99.9% (expected for business-critical systems)
    ☐ 99.95% (high availability requirement)
    ☐ 99.99%+ (mission critical, must be nearly always up)
    ☐ Doesn't matter

23. Do you want to maintain it internally or outsource to us?
    ☐ Maintain internally (hand over with documentation)
    ☐ Outsource to you (ongoing maintenance contract)
    ☐ Hybrid (some us, some you)
    ☐ Not sure yet

BUDGET & TIMELINE
─────────────────────────────────────────────────────

24. Timeline for implementation:
    ☐ ASAP (urgent, next 1-2 weeks)
    ☐ This month
    ☐ This quarter
    ☐ Flexible/not urgent

25. Budget range:
    ☐ $5,000-10,000 (minimal investment)
    ☐ $10,000-25,000 (moderate investment)
    ☐ $25,000-50,000 (significant investment)
    ☐ $50,000+ (major investment)
    ☐ Not sure/depends on ROI

26. Preference for cost structure:
    ☐ One-time project cost (fixed fee)
    ☐ Monthly retainer (predictable recurring)
    ☐ Hybrid (some upfront, some ongoing)
    ☐ Flexible/depends on solution

ADDITIONAL QUESTIONS
─────────────────────────────────────────────────────

27. Do you have any compliance requirements?
    ☐ HIPAA (healthcare)
    ☐ PCI-DSS (payment processing)
    ☐ SOC 2
    ☐ ISO 27001
    ☐ GDPR
    ☐ Australian Privacy Act
    ☐ Other: ________________________
    ☐ None

28. What additional services would you be interested in?
    ☐ Performance optimization
    ☐ Security hardening & audits
    ☐ 24/7 monitoring
    ☐ Disaster recovery setup
    ☐ Auto-scaling for traffic spikes
    ☐ Analytics/reporting
    ☐ Database optimization
    ☐ Compliance consulting
    ☐ Team training
    ☐ Other: ________________________

29. What are you most concerned about?
    ☐ Cost
    ☐ Complexity
    ☐ Learning curve
    ☐ Downtime during transition
    ☐ Data security
    ☐ Long-term vendor lock-in
    ☐ Other: ________________________

30. Is there anything else we should know?
    ________________________
    ________________________
    ________________________

═══════════════════════════════════════════════════════
```

---

## Solution Design & Recommendation

### Analysis & Recommendation Meeting Agenda (1 hour)

**When:** After you've completed assessment and reviewed questionnaire
**Who:** Decision makers + technical contact
**Output:** Signed agreement

```
RECOMMENDED MEETING AGENDA (60 minutes)

0-5 min: Opening
├─ Thank you for your time
├─ Review agenda
└─ Set expectations (will recommend specific solution)

5-15 min: Findings from Assessment
├─ Show current state dashboard
├─ Highlight critical issues
├─ Show recent downtime history
├─ Calculate annual impact ($X/year in downtime costs)
└─ Ask: "Does this align with your experience?"

15-30 min: Solution Options
├─ Present 2-3 options based on their needs
├─ Option 1: Cloud (fast, scalable, hands-off)
├─ Option 2: On-Premise HA (control, cost-optimal long-term)
├─ Option 3: Hybrid (best of both, risk mitigation)
├─ Show pros/cons of each
├─ Show 5-year TCO comparison
└─ Show uptime/SLA comparison

30-45 min: My Recommendation
├─ "Based on your situation, I recommend [Option X] because:"
├─ Reason 1: [Specific to their business]
├─ Reason 2: [Specific to their situation]
├─ Reason 3: [Specific to their goals]
├─ Implementation timeline
├─ Expected cost
├─ Expected benefits (uptime %, cost savings, etc.)

45-55 min: Maintenance & Support Options
├─ Option A: We manage it (Tier 1/2/3 retainer)
├─ Option B: You manage it (we hand over with training)
├─ Option C: Hybrid (we handle critical, you handle routine)
├─ Show pricing for each
├─ Show SLAs for each
└─ Answer questions

55-60 min: Next Steps
├─ Present proposal (if ready)
├─ Review contract terms
├─ Answer final questions
└─ Ask: "Does this work for you? Should we move forward?"
```

---

## Service Options Overview

### Option 1: Managed Services (You Do the Maintenance)

**What This Means:**
- You (or your team) manage the application 24/7
- Client pays monthly retainer
- Client doesn't need IT staff
- You handle all patches, updates, monitoring, backups

**Pricing Tiers:**

```
TIER 1: BASIC ($500-1,000/month)
├─ Email support (24-48 hr response)
├─ Bug fixes (severe only)
├─ Monthly 4-hour health check
├─ Uptime target: 99%
├─ Response SLA: Business hours only
└─ Good for: Startups, non-critical apps

TIER 2: STANDARD ($2,000-4,000/month)
├─ Email + phone support
├─ All bug fixes, patches
├─ Monthly 8-hour health check
├─ Uptime target: 99.5%
├─ Response SLA: 1-4 hours (critical)
└─ Good for: SaaS products, growing businesses

TIER 3: PREMIUM ($8,000-15,000/month)
├─ 24/7 phone + email support
├─ Dedicated engineer (16 hrs/month)
├─ Uptime target: 99.9%
├─ Response SLA: 15 minutes (critical)
├─ Dedicated Slack channel
└─ Good for: Mission-critical, regulated industries
```

**Responsibilities Matrix:**

```
                        TIER 1      TIER 2      TIER 3
Monitoring              You         You         You
Patching                You         You         You
Backup/Recovery         You         You         You
Incident Response       You         You         You
24/7 Availability       No          No          Yes
SLA Penalties           No          Yes         Yes
Performance Tuning      Quarterly   Monthly     Monthly
Security Audits         Annual      Annual      Quarterly
Team Training           Extra       Extra       Included
Architecture Review     Extra       Monthly     Weekly
```

---

### Option 2: Handover to Internal IT

**What This Means:**
- You deliver documentation + training
- Their IT team takes over
- No ongoing retainer
- You available for consulting ($150-250/hour if they need help)

**Handover Package Includes:**

```
DOCUMENTATION (Comprehensive)
├─ Architecture diagram
├─ Deployment procedure
├─ Troubleshooting guide
├─ Runbooks (step-by-step incident responses)
├─ Backup & restore procedure
├─ Security procedures
└─ Vendor contacts & accounts

TRAINING SESSIONS
├─ Infrastructure overview (4 hours)
├─ Deployment training (4 hours)
├─ Incident response (4 hours)
├─ Monitoring & alerting (2 hours)
├─ Backup procedures (2 hours)
├─ Security best practices (2 hours)
└─ Total: ~18 hours training

ACCESS & CREDENTIALS
├─ Server SSH keys
├─ Cloud account access
├─ Database credentials
├─ Monitoring tool access
├─ Backup system access
├─ DNS/domain credentials
└─ All documented in secure vault

KNOWLEDGE TRANSFER
├─ 30-day post-handover support (included)
├─ Answering questions via email
├─ Helping with first incident
├─ Weekly check-in call for first month
└─ After 30 days: Consulting rate if needed

SUPPORT AFTER HANDOVER
├─ You're always available for questions
├─ Consulting: $150-250/hour
├─ Emergency support: $250-500/hour
├─ Major projects: Fixed project fee
└─ No minimum commitment
```

**Cost Structure:**

```
One-time handover fee: $10,000-25,000
├─ Includes: Documentation, training, knowledge transfer
├─ Based on: Complexity, team size, training duration
└─ Timeframe: 2-4 weeks

Example:
- Small company (1 IT person, simple setup): $10,000
- Medium company (2-3 IT people, complex setup): $15,000
- Large company (5+ IT people, very complex): $25,000

Plus 30-day post-handover support (included)
Then: Available for consulting at $150-250/hour
```

---

### Option 3: Hybrid (Part Management, Part Support)

**What This Means:**
- You handle critical issues + monitoring
- Their IT team handles routine maintenance
- Shared responsibility model
- Monthly retainer + consulting as needed

**Responsibilities:**

```
YOU HANDLE:
├─ 24/7 Monitoring & alerting
├─ Critical incidents (system down)
├─ Emergency patches/hotfixes
├─ Disaster recovery failover
├─ Major performance issues
└─ Backup verification

THEIR IT TEAM HANDLES:
├─ Routine deployments
├─ Non-critical bug fixes
├─ User support
├─ Server OS patches (during maintenance window)
├─ Minor optimizations
└─ Documentation updates
```

**Pricing:**

```
Monthly retainer: $3,000-6,000
├─ Includes: 24/7 monitoring, critical incident response
├─ Includes: Emergency hotline (15-min response)
├─ Response SLA: Critical in 15 min, High in 1 hour
├─ Monthly health check (4 hours)
└─ Performance review (quarterly)

Plus: Consulting overages at $150/hour
├─ For non-critical work beyond retainer hours
└─ First 4 hours/month included, anything beyond charged
```

---

## Implementation Handover Guide

### Pre-Handover Checklist (Before You Deploy)

```
═══════════════════════════════════════════════════════
    PRE-HANDOVER CHECKLIST
═══════════════════════════════════════════════════════

This happens BEFORE you hand over to them or before
they go live with you managing it.

INFRASTRUCTURE VERIFICATION

☐ Architecture diagram completed and approved
☐ All components documented (servers, databases, storage)
☐ Network diagram showing connectivity
☐ Backup system tested and documented
☐ Disaster recovery site ready (if applicable)
☐ Monitoring configured and alerting works
☐ SSL certificates valid and auto-renewal set up
☐ DNS pointing to correct servers
☐ Firewall rules documented
☐ Load balancer configured (if multi-server)
☐ Database replication verified (if applicable)
☐ All credentials documented in secure vault

SECURITY VERIFICATION

☐ SSH keys generated and distributed
☐ Passwords changed (no default passwords)
☐ Access control implemented (who can access what)
☐ Firewall rules locked down (whitelist only)
☐ VPN configured for admin access (if needed)
☐ Data encryption enabled (at rest and in transit)
☐ Security scans run (no critical vulnerabilities)
☐ SSL/TLS properly configured
☐ Admin access logging enabled
☐ Backup encryption enabled
☐ Secrets stored in vault (not in code)

TESTING & VALIDATION

☐ Full system load test completed (2x expected load)
☐ Database failover tested successfully
☐ Backup restore test completed (can recover data)
☐ Disaster recovery failover tested
☐ Performance benchmarks established
☐ Security testing completed (penetration test for critical apps)
☐ Automated tests passing (unit, integration, e2e)
☐ Manual testing completed by QA team
☐ User acceptance testing (UAT) passed
☐ Monitoring alerts tested and working

DOCUMENTATION COMPLETED

☐ Architecture documentation
☐ Deployment procedures
☐ Troubleshooting guides
☐ Runbooks for common incidents
☐ Backup and restore procedures
☐ Security procedures and policies
☐ Incident response procedures
☐ Escalation contact list
☐ Vendor account details and contacts
☐ Change management process
☐ Maintenance schedule (patches, updates)

TRAINING SCHEDULED

☐ Training dates scheduled with team
☐ Training materials prepared
☐ Hands-on lab environment set up
☐ Training agenda shared with team
☐ Practice incidents planned
☐ Q&A time scheduled

VENDOR ACCOUNTS SECURED

☐ Cloud account access provisioned
☐ Database credentials set up
☐ Monitoring tool access given
☐ Backup system access provided
☐ DNS/domain access transferred/documented
☐ SSL certificate access provided
☐ All credentials documented in shared vault
☐ Two-factor authentication enabled where possible

FINAL APPROVAL

☐ Client sign-off on documentation
☐ Client sign-off on testing results
☐ Client acknowledges training schedule
☐ Client accepts uptime SLA
☐ Client signs maintenance/support agreement
☐ Go-live approval received
```

---

## Option A: You Do the Maintenance

### Setup Phase (Week 1-2)

```
═══════════════════════════════════════════════════════
    OPTION A: MANAGED MAINTENANCE SETUP
═══════════════════════════════════════════════════════

WEEK 1: MONITORING & ALERTING SETUP

Day 1: Meeting & Access
☐ Kickoff meeting with client technical contact
☐ Receive server access credentials
☐ Receive cloud account access
☐ Receive domain/DNS credentials
☐ Set up VPN access if needed
☐ First login to all systems, verify access works

Day 2: Monitoring Installation
☐ Deploy monitoring agent (Prometheus, Datadog, New Relic)
☐ Configure health checks for all critical services
☐ Set up alerting thresholds
☐ Configure alert routing (email, Slack, SMS)
☐ Test alerts (trigger intentional alerts to verify notification)
☐ Create monitoring dashboard for client visibility

Day 3: Logging & Aggregation
☐ Deploy centralized logging (ELK Stack, CloudWatch, Datadog)
☐ Configure log aggregation from all servers
☐ Set up log retention policy (typically 30-90 days)
☐ Configure log search and analysis
☐ Create dashboards for common queries
☐ Test logging (verify logs appear in central location)

Day 4: Backup Verification
☐ Check current backup system
☐ Test backup completion (verify recent backups exist)
☐ Perform restore test (restore to test environment)
☐ Verify backup encryption and security
☐ Check backup retention policy
☐ Set up automated backup alerts if missing
☐ Document backup procedure

Day 5: Security Audit
☐ Review firewall rules
☐ Review access control policies
☐ Check for default credentials
☐ Verify SSH key setup (no password-based SSH)
☐ Check SSL certificate validity and expiration
☐ Review data encryption settings
☐ Document security findings

WEEK 2: RUNBOOK CREATION & TESTING

Day 6-7: Create Operational Runbooks
☐ Document all critical systems
☐ Create runbook for system restart
☐ Create runbook for database failover
☐ Create runbook for increasing capacity
☐ Create runbook for security incident response
☐ Create runbook for backup/restore
☐ Create runbook for SSL certificate renewal
☐ Each runbook should have: Symptom → Diagnosis → Resolution

Day 8: Test Runbooks
☐ Run through each runbook with team member
☐ Fix any errors or unclear steps
☐ Time each procedure (set realistic SLAs)
☐ Get client sign-off on procedures
☐ Share documentation with team

Day 9: Set Up Alerting
☐ Configure critical alerting (system down = page you immediately)
☐ Configure normal alerting (issues = email alert)
☐ Configure low-priority alerting (recommendations = weekly digest)
☐ Set up on-call schedule
☐ Test alerting system with dry runs
☐ Verify you receive alerts correctly

Day 10: Handoff Meeting
☐ Review SLAs and response times with client
☐ Provide your contact information and escalation path
☐ Set up regular health check meetings (weekly/monthly)
☐ Review monitoring dashboard together
☐ Discuss communication during incidents
☐ Sign off on maintenance agreement
☐ Confirm billing details and payment terms
```

### Ongoing Maintenance (Monthly)

```
MONTHLY OPERATIONS

Week 1: Proactive Maintenance
├─ Review monitoring logs for warnings/errors
├─ Identify performance trends
├─ Check disk space, memory usage
├─ Verify backup completion
├─ Review security audit logs
├─ Check for pending security patches
└─ Compile health report

Week 2: Patch & Update
├─ Review available patches (OS, app, dependencies)
├─ Test patches in staging environment
├─ Apply patches to production (during maintenance window)
├─ Verify system still works after patches
├─ Update documentation
└─ Inform client of changes

Week 3: Performance Optimization (Tier 2+ only)
├─ Analyze performance metrics
├─ Identify slow queries or endpoints
├─ Implement optimizations
├─ Benchmark improvements
├─ Document changes
└─ Report to client

Week 4: Monthly Review Meeting
├─ Present health report to client
├─ Review SLA metrics (99.5% uptime achieved)
├─ Discuss upcoming patches/changes
├─ Review incident logs (if any)
├─ Discuss capacity planning
├─ Answer questions and concerns
└─ Adjust if needed

INCIDENT RESPONSE (When Issues Occur)

Critical Issue (System Down):
├─ Acknowledge alert automatically (within 15 minutes)
├─ Page on-call engineer immediately
├─ Assess severity
├─ Start investigation
├─ Implement workaround if possible
├─ Keep client informed (email/call every 30 minutes)
├─ Fix root cause
├─ Verify system stability
├─ Perform post-incident review
├─ Update runbooks
└─ Report findings to client

High-Priority Issue (Major Feature Down):
├─ Respond within 4 hours
├─ Investigate root cause
├─ Implement fix or workaround
├─ Keep client updated (email every 4 hours until fixed)
├─ Verify fix works
├─ Update documentation
└─ Report lessons learned

Medium-Priority Issue (Minor Bug):
├─ Respond within 24 hours
├─ Prioritize with other work
├─ Fix during next scheduled maintenance window
├─ Test fix in staging first
├─ Deploy to production
└─ Inform client of change

DOCUMENTATION UPDATES

├─ Update runbooks after any incident
├─ Keep architecture diagram current
├─ Document any configuration changes
├─ Update vendor contact information
├─ Maintain change log (what changed, when, why)
└─ Ensure client can access latest documentation
```

---

## Option B: Handover to Internal IT

### Pre-Handover Week (Week 1 of Handover)

```
═══════════════════════════════════════════════════════
    OPTION B: HANDOVER TO INTERNAL IT
═══════════════════════════════════════════════════════

PRE-HANDOVER (1 Week Before Training Starts)

Day 1: Documentation Package Assembly
☐ Compile all documentation into single location
  ├─ Architecture diagrams (visio/PDF)
  ├─ Network diagrams
  ├─ Server specifications
  ├─ Database schema (anonymized if needed)
  ├─ Application deployment process
  ├─ Environment variables and configuration
  ├─ Third-party service integrations
  ├─ API documentation
  └─ Code repository structure

☐ Create runbooks directory with:
  ├─ System startup procedure
  ├─ System shutdown procedure
  ├─ Database failover/recovery
  ├─ Adding new servers
  ├─ Scaling database
  ├─ SSL certificate renewal
  ├─ Backup and restore
  ├─ Incident response procedures
  ├─ Security incident response
  └─ Emergency contacts

☐ Create credential vault (1Password, HashiCorp Vault, etc.)
  ├─ SSH keys
  ├─ Database passwords
  ├─ Cloud account credentials
  ├─ API keys
  ├─ Third-party service credentials
  ├─ Domain/DNS admin password
  ├─ SSL certificate access
  ├─ Monitoring tool access
  └─ Backup system access

Day 2: Create Training Plan
☐ Identify who will attend each session
☐ Schedule training sessions (see below)
☐ Prepare training materials (slides, videos, labs)
☐ Create practice/lab environment
☐ Prepare practice incidents for hands-on training
☐ Share schedule with client team

Day 3: Prepare Lab Environment
☐ Set up parallel/staging environment for training
☐ Load sample data (no production data)
☐ Configure monitoring in lab
☐ Create intentional failures for practice
☐ Document lab environment setup
☐ Ensure lab matches production structure

Day 4: Access Provisioning
☐ Create accounts for all IT staff
☐ Grant appropriate permissions (principle of least privilege)
☐ Enable VPN access if needed
☐ Enable SSH access
☐ Enable cloud console access
☐ Provide monitoring tool access
☐ Verify each person can access systems

Day 5: Final Preparation
☐ Review all documentation for clarity
☐ Conduct final system test
☐ Prepare Q&A document from previous questions
☐ Schedule 1:1 pre-training meeting with each participant
☐ Confirm all participants can access lab environment
☐ Ensure all equipment/software ready for training
```

### Training Phase (Week 2-3 of Handover)

```
WEEK 2: KNOWLEDGE TRANSFER TRAINING

Monday: Architecture Overview (4 hours)
├─ 9:00 AM: Welcome & agenda (15 min)
├─ 9:15 AM: Architecture overview walkthrough (45 min)
│  ├─ Show architecture diagram
│  ├─ Explain each component
│  ├─ Show how data flows through system
│  ├─ Explain why each technology was chosen
│  └─ Q&A
├─ 10:00 AM: Infrastructure tour (45 min)
│  ├─ SSH into servers together
│  ├─ Show directory structure
│  ├─ Show running processes
│  ├─ Show disk/memory usage
│  └─ Show firewall rules
├─ 10:45 AM: Break (15 min)
├─ 11:00 AM: Cloud services overview (45 min)
│  ├─ Show cloud account structure
│  ├─ Explain VPC/security groups
│  ├─ Show RDS/database setup
│  ├─ Show S3 buckets
│  └─ Q&A
├─ 11:45 AM: Monitoring & alerting (45 min)
│  ├─ Show monitoring dashboard
│  ├─ Explain key metrics
│  ├─ Show alerting rules
│  ├─ Demonstrate alert notification
│  └─ Q&A
└─ 12:30 PM: Wrap up & homework

Tuesday: Deployment & Updates (4 hours)
├─ 9:00 AM: Review yesterday's material (15 min)
├─ 9:15 AM: Deployment process walkthrough (1 hour)
│  ├─ Show code repository structure
│  ├─ Explain branch strategy
│  ├─ Show deployment pipeline
│  ├─ Explain testing requirements
│  └─ Q&A
├─ 10:15 AM: Hands-on: Deploy code change (1 hour)
│  ├─ Everyone gets a practice code change
│  ├─ Deploy through pipeline
│  ├─ Verify in staging environment
│  ├─ Deploy to production
│  ├─ Verify in production
│  └─ Q&A
├─ 11:15 AM: Break (15 min)
├─ 11:30 AM: Database operations (1 hour)
│  ├─ Connect to database
│  ├─ Show important tables/schemas
│  ├─ Explain relationships
│  ├─ Show common queries
│  ├─ Demonstrate backups
│  └─ Q&A
└─ 12:30 PM: Wrap up

Wednesday: Incident Response (4 hours)
├─ 9:00 AM: Review previous material (15 min)
├─ 9:15 AM: Incident response procedures (1 hour)
│  ├─ Explain severity levels
│  ├─ Walk through runbooks
│  ├─ Explain troubleshooting methodology
│  ├─ Show how to escalate
│  └─ Q&A
├─ 10:15 AM: Hands-on: Practice incidents (2 hours)
│  ├─ Scenario 1: App server down
│  │  ├─ Team diagnoses issue
│  │  ├─ Follows runbook
│  │  ├─ Implements fix
│  │  └─ Verifies resolution
│  ├─ Scenario 2: Database connection pool exhausted
│  ├─ Scenario 3: Disk space full
│  ├─ Scenario 4: Memory leak causing OOM
│  └─ Each team member leads one scenario
├─ 12:15 PM: Break (15 min)
├─ 12:30 PM: Wrap up & debrief (30 min)
└─ 1:00 PM: End

Thursday & Friday: Backup & Security (4 hours each day)

Thursday: Backup & Recovery (4 hours)
├─ 9:00 AM: Review previous material (15 min)
├─ 9:15 AM: Backup system overview (1 hour)
│  ├─ Show backup schedule
│  ├─ Explain backup retention
│  ├─ Show backup verification logs
│  ├─ Explain encryption
│  └─ Q&A
├─ 10:15 AM: Hands-on: Database restore (1.5 hours)
│  ├─ Everyone restores database to point-in-time
│  ├─ Verify data integrity
│  ├─ Restore to production (on lab/staging)
│  ├─ Verify application works
│  └─ Document procedure
├─ 11:45 AM: Break (15 min)
├─ 12:00 PM: Disaster recovery procedure (1 hour)
│  ├─ Explain DR site setup
│  ├─ Show failover procedure
│  ├─ Demonstrate failover (on lab environment)
│  ├─ Verify systems up and running
│  └─ Q&A
└─ 1:00 PM: End

Friday: Security & Best Practices (4 hours)
├─ 9:00 AM: Review week's material (15 min)
├─ 9:15 AM: Security procedures (1 hour)
│  ├─ Password management
│  ├─ SSH key management
│  ├─ Secret management
│  ├─ Access control
│  ├─ Firewall rules
│  └─ Q&A
├─ 10:15 AM: Hands-on: Security audit (1 hour)
│  ├─ Scan for vulnerabilities
│  ├─ Review access logs
│  ├─ Check for weak passwords
│  ├─ Verify SSL certificates
│  └─ Q&A
├─ 11:15 AM: Break (15 min)
├─ 11:30 AM: Wrap up & final Q&A (30 min)
│  ├─ Review key learnings
│  ├─ Confirm comfort level
│  ├─ Identify knowledge gaps
│  └─ Schedule follow-up if needed
└─ 12:00 PM: End
```

### Post-Handover Support (Week 4, Ongoing)

```
WEEK 4-5: POST-HANDOVER SUPPORT PERIOD (30 days)

Week 1 After Training:
├─ You're available for questions (email, phone, Slack)
├─ Client team starts managing application
├─ You observe and help as needed
├─ No charge for questions during this period
└─ Daily 15-min check-in call with technical contact

Week 2:
├─ Client handles first major change/deployment
├─ You provide guidance but let them do the work
├─ Debrief after deployment, discuss lessons learned
└─ Resolve any remaining questions

Week 3:
├─ Client handles first incident/issue
├─ You provide advice, they implement fix
├─ Debrief after incident resolution
└─ Update runbooks based on experience

Week 4 (Final):
├─ Final review meeting
├─ Assess team's readiness
├─ Identify any remaining gaps
├─ Provide resources for continued learning
├─ Establish ongoing support relationship (if needed)
└─ Sign off on handover completion

AFTER 30-DAY PERIOD:

Available for Consulting:
├─ Rate: $150-250/hour
├─ Available for:
│  ├─ Complex problems they can't solve
│  ├─ Architecture questions
│  ├─ Performance optimization
│  ├─ Security audits
│  ├─ Major upgrades/changes
│  ├─ Team training refreshers
│  └─ New feature architecture reviews
├─ Typical: 5-10 hours/month
└─ No minimum commitment
```

---

## Transition Checklists

### If Client Chooses: You Manage (Managed Services)

```
═══════════════════════════════════════════════════════
    CHECKLIST: MANAGED SERVICES AGREEMENT
═══════════════════════════════════════════════════════

CONTRACT & LEGAL (Week 1)
☐ Maintenance agreement drafted
☐ SLA document attached
☐ Service level matrix defined
☐ Response time SLAs confirmed
☐ Uptime targets confirmed
☐ Escalation procedures defined
☐ Payment terms established
☐ Contract signed by both parties
☐ Kickoff meeting scheduled

INITIAL SETUP (Weeks 1-2)
☐ Monitoring system deployed
☐ Alerting configured and tested
☐ Dashboard created for client visibility
☐ On-call schedule established
☐ Backup system verified/upgraded if needed
☐ Security audit completed
☐ Runbooks created and documented
☐ Client team trained on communication
☐ First health report delivered

OPERATIONAL HANDOFF (Week 2-4)
☐ You take operational responsibility
☐ You respond to alerts
☐ You manage backups
☐ You apply patches and updates
☐ You monitor performance
☐ You maintain documentation
☐ Client confirms SLAs being met
☐ Adjust any parameters as needed
☐ Monthly health report established

ONGOING (Monthly)
☐ Monthly health report delivered (5th of month)
☐ Monthly review meeting scheduled (10th of month)
☐ Patches applied as needed (during maintenance window)
☐ Performance optimization (Tier 2+)
☐ Backup testing (monthly or quarterly)
☐ Disaster recovery testing (quarterly)
☐ Invoices sent (1st of month)
└─ Payments received (within 30 days)
```

### If Client Chooses: Internal IT Takes Over (Handover)

```
═══════════════════════════════════════════════════════
    CHECKLIST: HANDOVER TO INTERNAL IT
═══════════════════════════════════════════════════════

PRE-HANDOVER (Week 1)
☐ Documentation compiled and organized
☐ All runbooks completed
☐ Credential vault set up with access for all IT staff
☐ Training schedule confirmed with all participants
☐ Lab environment prepared
☐ Practice incidents created
☐ Access provisioned for all team members
☐ Final system test completed

TRAINING DELIVERY (Weeks 2-3)
☐ Architecture overview training completed
☐ Deployment & updates training completed
☐ Incident response training completed
☐ Backup & recovery training completed
☐ Security procedures training completed
☐ All hands-on labs completed
☐ All team members comfortable with procedures
☐ Questions addressed and documented

POST-TRAINING (Weeks 4-5)
☐ Team does first deployment with observation
☐ Team handles first incident with guidance
☐ Team performs first backup/restore test
☐ Knowledge gaps identified and addressed
☐ Documentation updated based on feedback
☐ Final review meeting completed
☐ Handover sign-off completed
☐ Consulting relationship established (if needed)

CONSULTING ARRANGEMENT (Ongoing)
☐ Consulting rate established ($150-250/hour)
☐ Contact information provided
☐ Response time expectations set
☐ Scope of consulting defined
☐ No minimum commitment required
☐ Email and phone support available
└─ Monthly 1-hour consultation call optional

FINAL DOCUMENTS
☐ Handover completion certificate
☐ Final documentation package (all sources)
☐ Lessons learned summary
☐ Ongoing support options document
☐ Consultant contact information
└─ Invoice for handover services
```

### If Client Chooses: Hybrid (Shared Responsibility)

```
═══════════════════════════════════════════════════════
    CHECKLIST: HYBRID ARRANGEMENT
═══════════════════════════════════════════════════════

RESPONSIBILITY MATRIX (Week 1)
☐ Clearly document what you manage
  ├─ 24/7 monitoring
  ├─ Critical incident response
  ├─ Emergency patches
  ├─ Backup verification
  └─ Performance optimization

☐ Clearly document what they manage
  ├─ Routine deployments
  ├─ Non-critical bug fixes
  ├─ User support
  ├─ Minor optimizations
  └─ Documentation updates

☐ Escalation procedures defined
☐ Communication protocols established
☐ Contract drafted and signed

SETUP PHASE (Weeks 1-2)
☐ Your monitoring system deployed
☐ Your alerting configured (you only receive critical alerts)
☐ Dashboard created for both you and them to see
☐ Your on-call schedule established
☐ Handoff procedures defined
  ├─ When you escalate to them
  ├─ When they escalate to you
  ├─ How to communicate during incidents
  └─ Decision authority for major changes

☐ Training for hybrid workflow completed
☐ Client team familiar with your procedures

OPERATIONAL PHASE (Ongoing)
☐ You respond to critical alerts (15-min response)
☐ You manage emergency patches
☐ They do routine deployments/updates
☐ Monthly health review meeting
☐ Monthly invoice for retainer
☐ Track hybrid incidents to ensure handoff working well

QUARTERLY REVIEW
☐ Review incidents from past quarter
☐ Confirm responsibility boundaries are clear
☐ Identify what's working well
☐ Identify what needs adjustment
☐ Adjust SLAs or responsibilities if needed
└─ Update contract if major changes
```

---

## Ongoing Operations Manual

### Client-Facing Support Document

```
═══════════════════════════════════════════════════════
        OPERATIONS MANUAL
        [Client Name] - [Application Name]
═══════════════════════════════════════════════════════

CONTACT INFORMATION
─────────────────────────────────────────────────────

Primary Contact: [Your Name]
Phone: [Your phone]
Email: [Your email]
Slack: [Slack channel]

Hours of Coverage:
├─ Tier 1: Business hours only (9am-5pm Sydney time)
├─ Tier 2: Business hours + emergency hotline
├─ Tier 3: 24/7 availability

Emergency Contact (outside business hours):
└─ For Tier 2/3 clients: [Emergency phone number]

─────────────────────────────────────────────────────

SERVICE LEVEL AGREEMENT

Response Times:
┌──────────────┬──────────────┬──────────────┐
│ Severity     │ Response SLA  │ Resolve SLA   │
├──────────────┼──────────────┼──────────────┤
│ Critical     │ 1 hour       │ 4 hours      │
│ High         │ 4 hours      │ 8 hours      │
│ Medium       │ 24 hours     │ 48 hours     │
│ Low          │ 1 week       │ As prioritized│
└──────────────┴──────────────┴──────────────┘

Uptime Target: [99.0% / 99.5% / 99.9%]
└─ Acceptable downtime: [X hours/year]

SLA Credits:
├─ Response missed by 1-5 min: 5% credit
├─ Response missed by 5-60 min: 10% credit
├─ Response missed by 1+ hour: 25% credit
└─ Max credit/month: 30% of retainer

─────────────────────────────────────────────────────

HOW TO REPORT AN ISSUE

When Something Goes Wrong:
1. Email: [Your email] with subject: [APP NAME] [SEVERITY]
   └─ Example: "MyApp CRITICAL - System down"

2. Phone (Tier 2/3): [Emergency number]
3. Slack (if available): @[Your name] in #alerts

Include in Your Report:
├─ What's not working? (specific behavior)
├─ When did it start? (time)
├─ Who's affected? (how many users/features)
├─ What's the business impact? (revenue loss?)
└─ Any error messages? (screenshots if possible)

Example:
Subject: MyApp HIGH - Login failing for all users
Body:
"Started at 2pm. Users cannot log in - getting 503 error.
Affects all 200 users. We're losing $500/min in revenue.
Error log shows database connection timeout."

─────────────────────────────────────────────────────

SCHEDULED MAINTENANCE WINDOWS

Regular Maintenance:
├─ Scheduled: [Day/Time] (typically 2am-4am Sydney)
├─ Expected downtime: [X minutes]
├─ Advance notice: [48 hours]
└─ Notification sent: [Email/Slack]

Emergency Maintenance:
├─ For critical security patches
├─ As-needed with minimal notice
├─ You'll be notified immediately
└─ Typically completed within [X hours]

Change Management:
├─ No changes without your approval
├─ Changes tested in staging first
├─ Deployment window confirmed before deploying
├─ Rollback plan in place
└─ Notification after successful deployment

─────────────────────────────────────────────────────

MONITORING & HEALTH

Your Dashboard:
├─ URL: [Monitoring dashboard URL]
├─ Username: [Your username]
├─ Password: [In credentials vault]
└─ Shows: System status, performance, incidents

Key Metrics to Watch:
├─ Uptime (target: [X]%)
├─ Response time (target: <[X]ms)
├─ Error rate (target: <[X%])
├─ CPU usage (alert: >80%)
├─ Memory usage (alert: >80%)
├─ Disk usage (alert: >85%)
├─ Database connections (alert: >90% pool)
└─ Log error count (alert: >X errors/min)

Health Reports:
├─ Delivered: [5th of each month]
├─ Includes: Uptime %, incidents, performance trends
├─ Review meeting: [2nd Tuesday of month, 10am]
└─ Attendees: You + technical contact

─────────────────────────────────────────────────────

COMMON ISSUES & SOLUTIONS

Issue: Application is slow
├─ Likely cause: High traffic, database slow, memory leak
├─ What I'll do:
│  ├─ Check monitoring for bottleneck
│  ├─ Increase resources if needed
│  ├─ Optimize database queries
│  └─ Report findings to you
└─ Timeline: 1-4 hours for diagnosis

Issue: "Error 503 Service Unavailable"
├─ Likely cause: Application crashed, not enough resources
├─ What I'll do:
│  ├─ Restart application
│  ├─ Check resources
│  ├─ Scale if needed
│  └─ Investigate root cause
└─ Timeline: <30 minutes to restore, hours to fix root cause

Issue: Cannot connect to database
├─ Likely cause: Database down, connection pool exhausted, network
├─ What I'll do:
│  ├─ Check database status
│  ├─ Restart if needed
│  ├─ Check network connectivity
│  ├─ Review connection pool settings
│  └─ Failover to standby if available
└─ Timeline: <1 hour to restore

Issue: Disk space full
├─ Likely cause: Logs not rotating, large files accumulating
├─ What I'll do:
│  ├─ Emergency cleanup
│  ├─ Implement rotation if missing
│  ├─ Archive old logs
│  └─ Set up alerts to prevent recurrence
└─ Timeline: <30 minutes to resolve

For other issues:
└─ Contact me immediately, describe what you're seeing

─────────────────────────────────────────────────────

FREQUENTLY ASKED QUESTIONS

Q: What if something goes wrong during maintenance?
A: I test all changes in staging first. If issues occur, I can
   rollback in minutes. Your data is always backed up.

Q: What if I don't understand the health report?
A: That's what the monthly meeting is for. Ask questions, and
   I'll explain what metrics mean and why they matter.

Q: Can I access the monitoring dashboard myself?
A: Yes, login credentials are in your vault. You can see real-time
   status anytime.

Q: What's covered in maintenance vs. what costs extra?
A: Covered: Monitoring, backups, patches, bug fixes, performance
   tuning. Extra (at $[X]/hour): New features, major changes,
   training beyond initial handover.

Q: Can you add new users or features?
A: New users: Yes, no problem. New features: Requires separate
   project engagement, estimated costs provided.

─────────────────────────────────────────────────────

ESCALATION PATH

If something goes really wrong:

Step 1 (Response): [Your name] - [phone]
├─ Initial response and assessment
└─ If I can't be reached in 5 min, go to Step 2

Step 2 (Escalation): [Backup person] - [phone]
├─ If primary unavailable
└─ If issue still critical, go to Step 3

Step 3 (Emergency): [Your company backup] - [phone]
├─ 24/7 emergency response
└─ For Tier 3 clients only

For CRITICAL SECURITY INCIDENTS:
└─ Call emergency number immediately, also email executive

─────────────────────────────────────────────────────

WHAT TO EXPECT FROM ME

✅ I will:
├─ Respond within SLA timeframe
├─ Keep you updated on progress
├─ Explain what's happening in plain English
├─ Fix issues professionally and permanently
├─ Test fixes before deploying
├─ Keep your data safe and backed up
├─ Deliver monthly health reports
├─ Be available for questions
└─ Treat your business as critical

❌ I won't:
├─ Ignore alerts or messages
├─ Deploy untested changes
├─ Blame you for problems
├─ Make major changes without approval
├─ Share your data with anyone
├─ Abandon the system
└─ Charge surprise fees

═══════════════════════════════════════════════════════
```

---

## Summary: Decision Matrix for Client

### Which Option is Right for Them?

```
╔══════════════════════════════════════════════════════════════╗
║              CLIENT CHOICE DECISION MATRIX                    ║
╚══════════════════════════════════════════════════════════════╝

OPTION A: You Manage (Managed Services)
─────────────────────────────────────────
Best For:
✅ Companies without IT expertise
✅ Prefer hands-off approach
✅ Willing to pay for peace of mind
✅ Want 24/7 monitoring included
✅ Don't want to worry about operations

Cost: $500-15,000/month (depending on tier)
Timeline: Ready in 2-4 weeks
Commitment: 12-month contract typical
Upside: Hands-off, expert management, SLA guarantees
Downside: Ongoing cost, depends on external vendor

─────────────────────────────────────────────────────

OPTION B: Internal IT Takes Over (Handover)
─────────────────────────────────────────
Best For:
✅ Companies with IT staff (1+ person)
✅ Want to control infrastructure
✅ Want no ongoing licensing fees
✅ Comfortable with operations responsibility
✅ Plan to manage long-term

Cost: $10,000-25,000 one-time + $150-250/hr consulting
Timeline: 4-6 weeks (includes 2-3 weeks training)
Commitment: None after handover
Upside: Cost-effective long-term, full control, independence
Downside: Requires IT expertise, learning curve, 24/7 on-call

─────────────────────────────────────────────────────

OPTION C: Hybrid (Shared Management)
─────────────────────────────────────────
Best For:
✅ Companies with some IT staff
✅ Want to reduce operational burden
✅ Want external backup for critical issues
✅ Want middle ground between A and B
✅ Have variable workloads

Cost: $3,000-6,000/month + overtime consulting
Timeline: 2-4 weeks
Commitment: 12-month contract
Upside: Balanced approach, cost-effective, expert backup
Downside: Requires IT staff, shared responsibility

─────────────────────────────────────────────────────

DECISION FRAMEWORK

Ask client these questions:

1. Do you have IT staff? (1+ person)
   Yes → Could do B or C
   No → Must do A

2. Are you comfortable managing infrastructure?
   Yes → Recommend B or C
   No → Recommend A

3. How critical is the application?
   Very critical → Recommend A or C
   Somewhat critical → Any option works
   Not critical → B is most cost-effective

4. What's your budget for operations?
   $500-3,000/month → A (Tier 1) or B (one-time)
   $3,000-6,000/month → A (Tier 2) or C
   $6,000+/month → A (Tier 3) for peace of mind

5. What's your pain point?
   "We have no IT staff" → A
   "We have IT but overwhelmed" → C
   "We want independence" → B
   "We want 24/7 expert backup" → A (Tier 3) or C

─────────────────────────────────────────────────────

RECOMMENDED PATH FORWARD

1. Present all three options
2. Ask the five questions above
3. Use answers to recommend best fit
4. If they choose A: Go to managed services agreement
5. If they choose B: Go to handover agreement
6. If they choose C: Go to hybrid agreement
7. Sign contract and begin implementation
```

---

## Final Delivery Package Contents

```
═══════════════════════════════════════════════════════════════
              FINAL HANDOVER PACKAGE CHECKLIST
═══════════════════════════════════════════════════════════════

When you hand over the application to client, deliver:

OPTION A (Managed Services):
├─ Signed maintenance agreement
├─ SLA document
├─ Operations manual
├─ Your contact information card
├─ Monitoring dashboard access
├─ Monthly health report template
└─ Invoice and payment information

OPTION B (Handover to Internal IT):
├─ Complete documentation package:
│  ├─ Architecture diagrams (PDF)
│  ├─ Network diagrams
│  ├─ All runbooks (word docs)
│  ├─ Deployment procedures
│  ├─ Troubleshooting guides
│  ├─ Security procedures
│  └─ Change management process
│
├─ Credential vault with:
│  ├─ SSH keys
│  ├─ Database passwords
│  ├─ Cloud account credentials
│  ├─ API keys
│  └─ Third-party credentials
│
├─ Training materials:
│  ├─ Video recordings (if captured)
│  ├─ Slide decks
│  ├─ Lab environment credentials
│  └─ Practice incident scenarios
│
├─ Knowledge base:
│  ├─ FAQ document
│  ├─ Common issues & solutions
│  ├─ Vendor contact information
│  └─ Emergency procedures
│
├─ Final documentation:
│  ├─ Handover completion certificate
│  ├─ Team sign-off sheet
│  ├─ Knowledge assessment results
│  └─ Ongoing consulting information
│
└─ Invoice for handover services

OPTION C (Hybrid):
├─ Same as Option A:
│  ├─ Signed hybrid services agreement
│  ├─ SLA document with shared responsibilities
│  ├─ Operations manual (highlighting shared duties)
│  └─ Your contact information
│
├─ Plus Option B items (partial):
│  ├─ Key documentation (what they manage)
│  ├─ Credential vault access
│  ├─ Brief training on their responsibilities
│  └─ Escalation procedures
│
└─ Invoices (one-time setup + monthly retainer)

═══════════════════════════════════════════════════════════════
```

---

**Last Updated:** November 2025
**Version:** 1.0
**Audience:** Solutions Architects, Service Delivery Managers, Client Success Teams

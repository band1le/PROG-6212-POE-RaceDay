# PROG-6212-POE-RaceDay
RaceDay Event Management System - Part 1

# System Description

RaceDay is a full-stack,web based event mangement system for South Africa's road
running,walking,and cycling community.It rplaces paper-based registration and
spreadsheets with a single platform where Events Organisers can create and manage events
and categories and where participants can browse events,enrol in categpry,and track
their own results.

This repository currently contains Part 1 of the Portfolio of evidence(POE):the system plan
produced before any application code was written an Entity Relationship Diagram(ERD),
an Application Programing Interface(API) endpoint plan,and the SQL script that creates and seeds the database.

# Role
Organiser: creates edits and deletes events;manages event categories;captures
participant results;views all enrolments for their events.

Participant: creates an account,browses events enroles in an event by selecting a
category,views their own enrolments and traks their own results.

# Repository Structure
/.github
/workflows - GitHub Actions workflow files/
Validate-docs.yml - GitHub Actions workflow to validate documentation files

/docs
API_Endpoint_Plan.md - API endpoint plan
ERD_RaceDay.png- Entity Relationship Diagram(ERD)
RaceDay_SQL_Script.sql - SQL script to create and seed the database

.gitignore - Specifies intentionally untracked files to ignore
README.md - This file, provides an overview of the RaceDay Event Management System and its components.

# Database Setup
1.Open SQL Server Management Studio(SSMS) and connect to your SQL Server instance.
2.Open docs/RaceDay_SQL_Script.sql in SSMS.
3.Execute the script use(F5).It will create the RaceDay database,all six tables with primary/foreign keys and constrants and seed data(2 Organisers, 2 Participants, 3 Events, 5 Categories, 3 Enrolments, 2 Results).
4.Verify with the sample SELECT statements at the bottom of the script.

# ERD Notes
The ERD (docs/RaceDay_ERD.png) models six entities:Roles,Users,Events,Categories,
Enrolments,and Results.Users-Categories is many-to-many relationship(A Participant can enrol in many categories and category can have many participants),
resolved by the Enrolments junction table.Enrolment-Result is one-to-one,enforced in the SQL script with a UNIQUE constraint on Result.EnrolmentID.
The SQL script matches the ERD exactly-no deviations.

# CI/CD
A Github Actions workflow(Validate-docs.yml) runs on every push and validates that the /docs folder exists and contains the ERD,endpoint plan and SQL script files. If any of these files are missing or renamed, the workflow will fail and notify the user.

# VideoWalkthrough
YouTube (unlisted):https://youtu.be/1xWd4uoFLrA
The video walks through the planning documents: the ERD design decision,the end point
plan choice and runs teh SQL script live in SSMS.

# AI TOOL DISCLOSURE
As required by the assiginment instructions:AI tools were used during the planning phase of this part.

Claude(Antropic https://claude.ai/) was used to help draft the ERD layout,the API endpoint plan and the SQL script skeleton.
DeepSeek(AI https://www.deepseek.com/) was used to help with dtructuring [describe exactly what you used it for e.g structure the README sections or structuring the endpoint plan table be speecific here].

ALL design(entity choices,relationships cardinalities,role permissions,and
endpoint scope) were reviewd,tested and are understood and can be explained by the author
(Bandile Simphiwe Ngubane ST10479433).THE DATABASE script was run and verified in SSMS by the authour before submission.


# RaceDay-Part 2
RaceDay is a web-based event management system for South African road running, walking and cycling events.
Organisers create and manage events, and Participants browse events, enter them and follow their results.
This is Part 2 of the PROG6212 Portfolio of Evidence, built with ASP.NET Core MVC, Entity Framework Core (Code-First)
and ASP.NET Core Identity on SQL Server.

**Repository:** [https://github.com/band1le/PROG-6212-POE-RaceDay.git]

**Video walkthrough (unlisted YouTube):** [FILL IN: YouTube link]

## The Roles
 Role |What they can do |

**Organiser**  Create, edit and delete events; manage event categories; capture finish times and positions; view all enrolments for their events |
**Participant** Create an account, browse events, enter an event by selecting a category, view their own enrolments, track their own results |

Both roles can view and update their own profile. Role-based access is enforced on the server (`[Authorize(Roles = ...)]`),
so a Participant cannot reach Organiser pages and an Organiser cannot reach Participant pages.

[FILL IN or DELETE: The project also seeds an **Admin** role that manages user roles through the User Roles page.]

## Features
features available in my project please note we were told not to do Swagger

- [ ] Registration and login (ASP.NET Core Identity), passwords hashed by Identity
- [ ] Role-based access for Organiser and Participant
- [ ] User profile: view and update own details
- [ ] Events: create, edit, delete (Organiser); view (both roles)
- [ ] Categories per event (Organiser); view (both roles)
- [ ] Event enrolments: Participant enters by selecting a category; Organiser views all enrolments for their events
- [ ] Results: Organiser captures finish times and positions; Participant views their own
- [ ] Unit tests (xUnit) and GitHub Actions CI (42 unit test passeed 2 failed)

## Technology
ASP.NET Core MVC, **.NET [FILL IN: version from RaceDay.csproj, e.g. 10.0]**
- Entity Framework Core, Code-First with migrations
- SQL Server (LocalDB or SQL Server Express)
- ASP.NET Core Identity (users and roles)
- [FILL IN: Swashbuckle (Swagger), xUnit]

## Project Structure
PROG-6212-POE-RaceDay/
├── RaceDay/
│   ├── Areas/              Identity pages (register, login)
│   ├── Controllers/        MVC controllers
│   ├── Data/               ApplicationDbContext, ApplicationUser, Migrations
│   ├── Models/             Entities, view models, services (IProfileImageService)
│   ├── Views/              Razor views
│   ├── wwwroot/            Static files
│   ├── appsettings.json    Connection string
│   └── Program.cs          Services, Identity, role seeding, pipeline
├── [FILL IN: RaceDay.Tests/    Unit tests (xUnit)]
├── .github/workflows/      GitHub Actions workflow(s)
└── docs/                   Part 1 planning documents (ERD, endpoint plan, SQL script) and screenshots

## Setup and run instractions

## Prerequisites
1. Visual Studio with the **ASP.NET and web development** workload
2. The **.NET SDK** that matches the project ([FILL IN: version])
3. **SQL Server LocalDB** (installed with Visual Studio) or SQL Server Express

## Steps
1. Clone the repository:
```
   git clone [https://github.com/band1le/PROG-6212-POE-RaceDay.git]
```
2. Open the `.sln` file in Visual Studio and let NuGet restore the packages.
3. Open `RaceDay/appsettings.json` and check `ConnectionStrings:DefaultConnection` points to your SQL Server.
   The default is LocalDB, so most machines need no change.
4. Create the database. The app applies migrations automatically on startup. To do it manually, open
   **Tools > NuGet Package Manager > Package Manager Console** and run:
```
   Update-Database
```
5. Press **F5** (or run `dotnet run` inside the `PROG-6212-POE-RaceDay.slnx` folder).
6. Log in:
   - Demo admin account seeded on first run: `admin@Admin.com` / `Admin1@` (for marking and demonstration only)
   - To try the main roles, register two accounts: [FILL IN: how the role is chosen, e.g. "pick Organiser or Participant on the Register page" or "the Admin assigns it on the User Roles page"].

### Swagger was not added

## Running the unit tests
In Visual Studio: **Test >Test Explore> Run All Tests** in the PROG-6212-POE-RaceDay.slnx
42 passed 2 failed

## CI/CD
The workflow in `.github/workflows/[FILL IN: file name].yml` runs on every push. It builds the solution and runs all
unit tests.

# Notes on changes from Part 1

[FILL IN: one or two lines, for example: "Part 2 uses ASP.NET Core Identity, so the Part 1 Users and Roles tables are
implemented as the Identity tables (AspNetUsers, AspNetRoles, AspNetUserRoles). The Events, Categories, Enrolments and
Results tables follow the Part 1 ERD."] Delete this section if nothing changed.

# AI tool disclosure

As required by the assignment instructions, AI tools were used in this part:
- **Claude(Antropic https://claude.ai/):** [used for structuring]
- **DeepSeek(AI https://www.deepseek.com/):** [used for errors and code comparasion]

All code was reviewed and is understood by Bandile Ngubane ST10479433, and the project was built following the lecturer's tutorial videos.

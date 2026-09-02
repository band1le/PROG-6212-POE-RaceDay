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
POE DIAGRAMS.drawio(1).png- Entity Relationship Diagram(ERD)
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
YouTube (unlisted):[insert here]
The video walks through the planning documents: the ERD design decision,the end point
plan choice and runs teh SQL script live in SSMS.

# AI TOOL DISCLOSURE
As required by the assiginment instructions:AI tools were used during the planning phase of this part.

Claude(Antropic https://claude.ai/) was used to help draft the ERD layout,the API endpoint plan and the SQL script skeleton.
DeepSeek(AI https://www.deepseek.com/) was used to help with dtructuring [describe exactly what you used it for e.g structure the README sections or structuring the endpoint plan table be speecific here].

ALL design(entity choices,relationships cardinalities,role permissions,and
endpoint scope) were reviewd,tested and are understood and can be explained by the author
(Bandile Simphiwe Ngubane ST10479433).THE DATABASE script was run and verified in SSMS by the authour before submission.
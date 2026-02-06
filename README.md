# Airport Management System — Test Task

## Project Overview

Ruby on Rails 8 application that models a **complex Airport Management System domain**.  
The project is implemented as a **domain modeling test task**, with primary focus on:

- data modeling and normalization
- ActiveRecord relationships
- business rules and validations
- database-level constraints

❗ UI, controllers, and views are intentionally **out of scope** per task requirements.

---

## Key Features

- 12–16 ActiveRecord models
- Clearly separated domain layers (Flight vs FlightInstance)
- Complex relationships (`belongs_to`, `has_many`, `has_many :through`)
- Time-based resource assignments
- Business rules enforced at model and database levels
- PostgreSQL advanced constraints (unique indexes, exclusion constraints)
- Clean, idiomatic Ruby on Rails code

---

## Setup Instructions

### Prerequisites

- Ruby 3.2+
- Rails 8.0+
- PostgreSQL 12+

### Installation

```bash
git clone <repository-url>
cd airport_system
bundle install
bin/rails db:create db:migrate
Optional seed data:

bash

Copy code
bin/rails db:seed
Test environment setup:

bash

Copy code
bin/rails db:drop db:create db:migrate RAILS_ENV=test
Domain Overview
The system models the following real-world airport concepts:

Airport physical structure

Airports, terminals, gates, check-in counters

Airlines and aircraft

Airlines, aircrafts, seating layout

Flights vs Flight Instances

Flights as reusable routes

FlightInstances as concrete scheduled departures

Time-based resource assignments

Gates and check-in counters assigned with time ranges

Passenger flow

Passengers, bookings (PNR), tickets, boarding passes, baggage

Model Structure
Airport Structure
Airport

Terminal

Gate

CheckInCounter

Airlines & Aircraft
Airline

Aircraft

Seat

Flights
Flight

FlightInstance

Resource Assignments
GateAssignment

CheckInAssignment

Passenger & Boarding
Passenger

Booking

Ticket

BoardingPass

Baggage

Business Rules & Validations
Airport Structure
terminal.code must be unique within the same airport

gate.code must be unique within the same terminal

check_in_counter.codemust be unique within the same terminal

Presence validations for all required fields

Aircraft & Seats
seat_number (e.g. "12A") must be unique per aircraft

cabin_class is restricted to:

economy

business

first

Flights & Flight Instances
Flight number must be unique per airline

scheduled_arrival_at must be after scheduled_departure_at

FlightInstance status is restricted to:

scheduled

boarding

departed

arrived

delayed

cancelled

Actual arrival/departure times cannot be earlier than scheduled times

Time-Based Resource Assignments
A Gate cannot be assigned to multiple FlightInstances with overlapping time ranges

A Check-in Counter cannot be assigned to multiple FlightInstances with overlapping time ranges

These constraints are enforced via:

model-level overlap validations

PostgreSQL EXCLUDE constraints (prevents race conditions and bulk inserts)

Passengers, Bookings & Tickets
Booking reference (pnr) must be globally unique

Passenger requires:

first_name

last_name

document_number

A seat cannot be assigned to more than one ticket on the same flight instance

A passenger cannot have more than one ticket within the same booking

Boarding Pass
BoardingPass cannot be issued unless:

the ticket is checked in

a seat is assigned

Only one boarding pass is allowed per ticket

Baggage
tag_number must be globally unique

weight_kg must be positive

Database-Level Constraints
The project intentionally enforces critical rules at the database level:

Foreign keys for referential integrity

Unique indexes for:

booking PNR

seat per flight instance

passenger per booking

EXCLUDE constraints for overlapping gate and check-in assignments

This ensures correctness even when bypassing ActiveRecord validations (e.g. insert_all!).

Technical Details
Ruby on Rails 8

PostgreSQL as primary database

Model-level validations combined with DB-level constraints

Focus on correctness, safety, and domain clarity

Development Notes
Controllers, views, and UI are intentionally omitted

The project focuses exclusively on domain modeling and business logic

Designed to be easily extensible for additional airport resources or workflows

Summary
This project demonstrates:

proper domain normalization

thoughtful business-rule enforcement

safe handling of time-based conflicts

clean and maintainable Rails code

It fully satisfies the requirements of the Rails Airport Domain Modeling Test Task.
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

## 🧠 Project Goal

Design and implement a **realistic, normalized domain model** for an airport system using Ruby on Rails.

The project demonstrates:

- correct domain decomposition
- separation of reusable entities and runtime instances
- enforcement of complex business rules
- safe handling of time-based resource conflicts

---

## 🧱 Domain Overview

The system models the following real-world concepts.

### Airport Infrastructure
- Airport
- Terminal
- Gate
- Check-in counter

### Airlines & Aircraft
- Airline
- Aircraft
- Seat (with cabin classes)

### Flights
- **Flight** — reusable route definition
- **FlightInstance** — specific scheduled departure

### Resource Assignments (Time-Based)
- GateAssignment
- CheckInAssignment

### Passenger Flow
- Passenger
- Booking (PNR)
- Ticket
- BoardingPass
- Baggage

---

## 🧩 ActiveRecord Models

**Total: 15 models**

- Airport
- Terminal
- Gate
- CheckInCounter
- Airline
- Aircraft
- Seat
- Flight
- FlightInstance
- GateAssignment
- CheckInAssignment
- Passenger
- Booking
- Ticket
- BoardingPass
- Baggage

---

## ✅ Business Rules & Validations

### Airport Structure
- `terminal.code` must be unique within an airport
- `gate.code` must be unique within a terminal
- `check_in_counter.code` must be unique within a terminal
- Presence validations for all required attributes

---

### Seats
- `seat_number` (e.g. `12A`) must be unique per aircraft
- `cabin_class` is restricted to:
  - `economy`
  - `business`
  - `first`

---

### Flights & Flight Instances
- Flight number must be unique per airline
- `scheduled_arrival_at` must be after `scheduled_departure_at`
- `FlightInstance.status` is restricted to:
  - `scheduled`
  - `boarding`
  - `departed`
  - `arrived`
  - `delayed`
  - `cancelled`
- Actual departure/arrival times cannot be earlier than scheduled times

---

### Time-Based Assignments
- A **gate** cannot be assigned to multiple flight instances if time ranges overlap
- A **check-in counter** cannot be assigned to multiple flight instances if time ranges overlap

These rules are enforced via:
- model-level validations
- PostgreSQL **EXCLUDE constraints**

---

### Bookings & Tickets
- Booking reference (`pnr`) must be globally unique
- Passenger must have:
  - `first_name`
  - `last_name`
  - `document_number`
- A seat cannot be assigned to more than one ticket on the same flight instance
- A passenger cannot have more than one ticket within the same booking

---

### Boarding Pass
- A `BoardingPass` cannot be created unless:
  - the ticket is checked in
  - a seat is assigned
- Only one boarding pass per ticket is allowed

---

### Baggage
- `tag_number` must be globally unique
- `weight_kg` must be positive

---

## 🗄️ Database Constraints

Critical business rules are enforced at the database level:

- Foreign keys for referential integrity
- Unique indexes for:
  - booking PNR
  - passenger per booking
  - seat per flight instance
- PostgreSQL **EXCLUDE constraints** to prevent time-range overlaps

This guarantees correctness even when bypassing ActiveRecord validations (e.g. `insert_all!`).

---

## 🛠 Technical Stack

- Ruby 3.2+
- Rails 8.0+
- PostgreSQL
- ActiveRecord validations + database constraints

---

## 📝 Development Notes

- No controllers, views, or UI by design
- Focused entirely on **domain modeling and business logic**
- Code is structured to be clean, readable, and easily extensible

---

## 🎯 Summary

This project demonstrates:

- strong domain normalization
- correct use of ActiveRecord associations
- careful business-rule reasoning
- safe handling of concurrency and time-based conflicts

The implementation fully satisfies the requirements of the  
**Rails Airport Domain Modeling Test Task**.

# Airport Management System — Domain Modeling (Rails)

## 📌 Overview

This project implements a **domain model for an Airport Management System** as a Ruby on Rails application.

The goal of the task is **data modeling and business logic**, not UI or controllers.

The implementation focuses on:
- correct domain normalization
- associations between entities
- model-level validations
- database-level constraints
- enforcing real-world business rules

UI, controllers, and views are intentionally out of scope.

---

## 🏗 Domain Structure

### 1️⃣ Airport Structure

**Entities**
- Airport
- Terminal
- Gate
- CheckInCounter

**Rules**
- `Terminal.code` is unique within the same airport
- `Gate.code` is unique within the same terminal
- `CheckInCounter.code` is unique within the same terminal
- Presence validations for required fields

**Enforced by**
- scoped uniqueness validations
- unique DB indexes

---

### 2️⃣ Airlines, Aircrafts & Seats

**Entities**
- Airline
- Aircraft
- Seat

**Rules**
- `Airline.code` is globally unique
- `Aircraft.registration_number` is globally unique
- `Seat.seat_number` is unique per aircraft
- `Seat.cabin_class` must be one of:
  - `economy`
  - `business`
  - `first`

**Implementation**
- `Seat.cabin_class` implemented as enum
- uniqueness enforced on both model and DB level

---

### 3️⃣ Flights & Flight Instances

Flights represent reusable routes, while FlightInstances represent concrete departures.

**Entities**
- Flight
- FlightInstance

**Rules**
- `flight_number` is unique per airline
- `scheduled_arrival_at` must be after `scheduled_departure_at`
- `actual_departure_at` / `actual_arrival_at` cannot be earlier than scheduled times
- `status` must be one of:
  - `scheduled`
  - `boarding`
  - `departed`
  - `arrived`
  - `delayed`
  - `cancelled`

**Implementation**
- `status` implemented as enum
- time validations at model level

---

### 4️⃣ Resource Assignments (Time-based)

Resources are assigned to **FlightInstances** within time ranges.

**Entities**
- GateAssignment
- CheckInAssignment

**Rules**
- A gate cannot be assigned to multiple flight instances if time ranges overlap
- A check-in counter cannot be assigned to multiple flight instances if time ranges overlap
- `active_to` must be after `active_from`

**Implementation**
- Model-level overlap validations
- PostgreSQL `EXCLUDE` constraints using `btree_gist`
- Database-level protection against race conditions and bulk inserts (`insert_all!`)

---

### 5️⃣ Passengers, Bookings & Boarding

**Entities**
- Passenger
- Booking
- Ticket
- BoardingPass
- Baggage

**Rules**
- `Passenger.document_number` is globally unique
- `Booking.pnr` is globally unique
- A seat cannot be assigned to more than one ticket on the same flight instance
- A ticket seat must belong to the aircraft used by the flight instance
- BoardingPass:
  - cannot be issued unless ticket is checked in
  - only one boarding pass per ticket
- Baggage:
  - `tag_number` is globally unique
  - `weight_kg` must be positive

**Implementation**
- Model-level validations
- DB unique indexes
- DB check constraint for baggage weight
- Business logic enforced both in models and database

---

## 🔐 Database Constraints

The project actively uses database-level guarantees:
- Foreign keys
- Unique indexes
- Check constraints
- Exclusion constraints (PostgreSQL)

This ensures data integrity even when bypassing ActiveRecord validations.

---

## 🧪 Verification

All domain rules were verified via Rails console scripts:
- validation failures return meaningful errors
- overlapping resource assignments are blocked at both model and DB levels
- bulk inserts are safely rejected by DB constraints

---

## 🧠 Design Decisions

- Flight and FlightInstance are strictly separated to reflect real-world scheduling
- Critical constraints are duplicated at DB level for safety
- No callbacks with side effects
- Business rules live close to the domain (models)

---

## 🚀 Tech Stack

- Ruby on Rails 8
- PostgreSQL
- ActiveRecord
- PostgreSQL `btree_gist` extension

---

## 📝 Notes

This project is intentionally limited to the domain layer and is suitable for:
- technical interviews
- domain modeling discussions
- backend architecture review

---

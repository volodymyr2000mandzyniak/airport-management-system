# Airport Management System - Test Task

## Project Overview
Rails 8 application modeling a complex Airport Management System domain.

## Key Features
- 12-16 ActiveRecord models
- Complex relationships and validations
- Time-based resource assignments
- Business rules enforcement
- PostgreSQL with advanced constraints

## Setup Instructions

### Prerequisites
- Ruby 3.2+
- PostgreSQL 12+
- Rails 8.0+

### Installation
1. Clone the repository
2. Install dependencies: `bundle install`
3. Create database: `rails db:create db:migrate`
4. (Optional) Seed data: `rails db:seed`

## Domain Overview
The system models:
- Airport physical structure (terminals, gates, counters)
- Airlines, aircraft, and seating
- Flights vs flight instances
- Time-based resource assignments
- Passengers, bookings, and boarding process

## Technical Details
- Rails 8 with PostgreSQL
- Model-level validations
- Database constraints
- Clean, idiomatic Ruby code

## Development Notes
- UI/controllers/views are out of scope per requirements
- Focus on data modeling and business logic

                 ```````````````                                                                          ``````````````              #
##                            0 _ 0                                                                                       0_0                  ##
   -------------------------------------------------------------------------------------------------------------------------------  ###
####                                                                                                                                 ####
                                                   (==============================)                                             #####

  # Hospital Management System #

This repository contains a moderate hospital management database modeling project aimed at efficiently managing and organizing stocks and healthcare data. A well-designed hospital database is crucial for streamlining administrative processes, patient care, and medical research. This is also designed to improve doctor-patient contact and allow doctors to access previous data for better treatment of current or similar cases.

## Table of Contents

- [Introduction](#Introduction)
- [Database Schema](#Database-Schema)
- [Features](#Features)
- [Installation](#Installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

In the healthcare industry, a well-structured database system is essential to manage patient information, medical records, staff details, and facility resources. This project focuses on creating a flexible and scalable database model for hospital management, clinics, doctors and healthcare.

## Database Schema

The database schema is designed to represent key entities and their relationships within a hospital environment. It includes tables for:

- Patients
- Doctors
- Appointment
- Medical Record
- Department
- Inventory
- Venue
- Bookings
- Billing
- Services
- Payment

The relationships between these entities are carefully defined to maintain data integrity and facilitate efficient querying.

## Features

- **Patient Management**: Easily record and update patient information, contact details e.t.c.

- **Doctor Management**: Keep track of doctors including their qualifications and schedules. The JSON format for the 'specialization' column are :
    + {
        specialty (VARCHAR(255),
	      inducted (DATE)
      }

- **Appointment Scheduling**: Schedule and manage patient appointments with doctors.

- **Medical Records**: Maintain detailed medical records, including diagnoses, treatments, and prescriptions. The JSON format for the 'history' column will be the following :
    + {
        date (DATETIME)
          [
            doctor_id (TINYINT),
            patient_statement (TEXT),
            diagnosis (TEXT),
            prescriptions (JSON_ARRAY)
              [],
            ambulance (JSON)
              {
                first_aid (TEXT),
                note (TEXT)
              },
            admitted (CHAR(1)),
            discharge_date (DATETIME)
          ]
      }
      
- **Department Management**: Organize healthcare services into different departments (e.g., Cardiology, Pediatrics) for better management.

- **Inventory Management**: Track hospital facilities and resources, ensuring they are properly allocated.

- **Venue or Location**: Keep record and track of appointment locations.

- **Billing**: Keep record of patient billing and due payments

- **Services**: Organize all services offered by the hospital for better tag in billing & payment table.

- **Payment**: Easily keep records of payment(s) made by patients.

- **Bookings**: Easily management appointments to avoid multiple appointment in the same venue at the same time (acts as the many to many table for appointments and venue).

## Installation

To use this hospital database model, follow these steps:

1. Clone the repository: `git clone https://github.com/deleplentie/hospital-management-system.git`
2. Set up your preferred database system (e.g., MySQL, PostgreSQL).
3. Import the SQL schema located in the `database` directory.
4. Customize the database as needed for your hospital's specific requirements.
5. **NOTE** this is engineered using MySQL database 

## Usage

This database model is designed as a foundation for your hospital management software. You can build a user interface or integrate it into your existing healthcare system to:

- Register patients
- Schedule appointments
- Maintain medical records
- Allocate resources efficiently
- And much more!

Feel free to adapt the database schema and functionality to suit your hospital's unique needs.

## Contributing

Contributions to improve and expand this hospital database model are welcome. For details on how to contribute to this project, kindly send a message to (Dev-del@hotmail.com).

## License

This hospital database modeling project is an open-source, can be use for study, research or training and monetary purposes.

#
##
### ------------------------------------------------------------------------------------------------------------------------------ ###
####                                                                                                                              ####

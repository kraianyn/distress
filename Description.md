# Name

- Дистрес
- Розряд

# Attending a course

1. The students fills the registration form.
1. The training center (TC) provides the payment info.
1. The student pays for the course.
1. The TC adds the student to the course chat.
1. The lead instructor takes roll.
1. The students complete the course.
1. The TC writes out the certificates.
1. The TC creates a feedback form.
1. The students fill the feedback form.
1. The instructors check the form for new responses.

# UI Sections

## Schedule

This section is for the scheduled courses. It has a subsection for all the 
courses, and another one for the courses the user is an instructor on.
Multiple views (list, calendar) are available.

The page of a scheduled course contains the name, the date, the location, 
the instructors, and an optional note. 

## Course types

This section is for what courses there are, i.e. the course types: Trauma care, 
BLS, TCCC ASM... They are split into military and non-military ones.

The page of a course type contains the name, the duration, the instructors 
needed, the price, and the capacity.

## Instructors

This section is for the instructors of the training center. The page of an 
instructor contains the name, the role, the contact info (phone number, email).

## Locations

This section is for the locations where courses are held. The page of a location 
contains the name, the link on the map, and the courses scheduled there.

# Users

Not all users are instructors. Some have other roles/permissions (actions), like managing 
registration forms, calculating salaries etc. And not all instructors can manage 
the schedule. To describe a user, they have a list of the relevant actions:

- teaching
- managing the schedule
- calculating salaries
- managing registration forms
- managing gift cards

# Future features

## Adding a course schedule

Besides adding courses one by one, there is a way to add a whole course schedule, 
i.e. multiple courses at once.

## Course students

The page of a scheduled course also contains the students. It's also possible 
to mark who is not present on the course.

## Certificates

Certificates are generated automatically as PDF files for the students present 
on the course.

## Feedback responses

A page for the feedback responses of a course.

When a new response is submitted, a notification is sent to the instructors of 
the course.

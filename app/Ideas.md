# UI

## Do

Decide on the colors.

Change the app logo.

Change the splash screen.

## Fix

Updating the date of a course with a date before today causes an error, since 
the initial date of the calendar widget is no longer in the valid range.
Make it impossible to update past courses (might still be needed)?

# Consider

Hide impossible course component options (locations and instructors with a 
course on the chosen date).

# Code

## Consider

Replace entity model constructors with methods constructing the entities.
Can `fromEntity` be replaced by casting now?

Reorder imports.

Replace entity model constructors with methods returning entities.

Reduce duplication across `AsyncNotifier`s.

Reduce duplication between `OptionsPage` and `InstructorsOptionsPage`.

If schedule forms become more complex, create classes for form data to avoid 
duplication of field processing logic.

# Cloud

# Questions

What does `@Riverpod(dependencies)` change? What is a scoped provider?

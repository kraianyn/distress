# UI

## Do

Hide impossible course component options (locations and instructors with a 
course on the chosen date).

## Fix

Updating the date of a course with a date before today causes an error, since 
the initial date of the calendar widget is no longer in the valid range.
Make it impossible to update past courses (might still be needed)?

## Consider

Split courses into military and non-military ones.

# Code

## Consider

Reorder imports.

Reduce duplication across the entity `AsyncNotifier`s.

Reduce duplication between `OptionsPage` and `InstructorsOptionsPage`.

If schedule forms become more complex, create classes for form data to avoid 
duplication of field processing logic.

# Cloud

# Questions

`@Riverpod(dependencies)`: What does it change? What is a scoped provider?

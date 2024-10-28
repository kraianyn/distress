# UI

## Do

Decide on the colors.

Change the app logo.

Change the splash screen.

## Fix

Entity pages watch the entities, so deleting an entity before the page is closed 
causes en error.

Updating the date of a course with a date before today causes an error, since 
the initial date of the calendar widget is no longer in the valid range.
Make it impossible to update past courses (might still be needed)?

## Consider

Restyle the bottom navigation bar.

Hide impossible course component options (locations and instructors with a 
course on the chosen date).

# Code

## Consider

Reorder imports.

Reduce duplication across `AsyncNotifier`s.

Reduce duplication between `OptionsPage` and `InstructorsOptionsPage`.

If schedule forms become more complex, create classes for form data to avoid 
duplication of field processing logic.

# Cloud

# Questions

What does `@Riverpod(dependencies)` change? What is a scoped provider?

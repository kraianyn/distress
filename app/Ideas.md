# UI

## Do

Make location links interactive: copying, following.

Hide impossible course component options (locations and instructors with a 
course on the chosen date).

## Fix

Deleting an instructor who is the lead instructor of a course does not set the 
course's lead instructor to null.

Updating the date of a course with a date before today causes an error, since 
the initial date of the calendar widget is no longer in the valid range.
Make it impossible to update past courses (might still be needed)?

When updating an entity from a page opened from another entity page, the change 
is not reflected on the first page.

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

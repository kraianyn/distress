# UI

## Do

Discard `AccessCodeCreationWidget`. Wait for the code to be created on the form page.

For buttons that perform an async operation, change the label while awaiting.

Decide on the colors.

Change the app logo.

Change the splash screen.

## Fix

Updating the date of a course with a date before today causes an error, since 
the initial date of the calendar widget is no longer in the valid range.
Make it impossible to update past courses (might still be needed)?

## Consider

Restyle the bottom navigation bar.

Hide impossible course component options (locations and instructors with a 
course on the chosen date).

# Code

# Do

Remove padding from `ListTile`s. Use `paddingAround` more.

Define `SwitchTile`. Replace `RoleTile` and the tile in `CourseTypeForm`.

Replace functions returning widgets with actual widgets.

## Consider

Reorder imports.

Reduce duplication across `AsyncNotifier`s.

Reduce duplication between `OptionsPage` and `InstructorsOptionsPage`.

If schedule forms become more complex, create classes for form data to avoid 
duplication of field processing logic.

# Cloud

# Questions

What does `@Riverpod(dependencies)` change? What is a scoped provider?

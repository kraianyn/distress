# UI

## Do

Decide how location cities should be displayed: after the name preceded by a comma or in parentheses, or as a subtitle.

Use regular buttons instead of FABs if the page is dedicated to an action.

Make the user know if field values are invalid.

Make it impossible to access the course form if the component entities are 
empty.

Make forms look like pages.

Remove the tiny built-in padding in action icon buttons on entity pages.

## Fix

When updating an entity from a page opened from another entity page, the change 
is not reflected on the first page.

## Consider

Add a title for courses on entity pages.

Add course counts to entity tiles.

Split courses into military and non-military ones.

# Cloud

## Do

Rename the `data` collection to `schedule`.

# Code

## Consider

Move course notifier calls from widgets to other notifiers.

Reorder imports.

Reduce duplication across entity actions.

Reduce duplication across the entity `AsyncNotifier`s.

Reduce duplication between `OptionsPage` and `InstructorsOptionsPage`.

If schedule forms become more complex, create classes for form data to avoid 
duplication of field processing logic.

# Questions

`@Riverpod(dependencies)`: What does it change? What is a scoped provider?

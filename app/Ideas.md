# UI

## Do

Do not imply that the courses have been fetched on entity pages.

Use regular buttons instead of FABs if the page is dedicated to an action.

Make the user know if field values are invalid.

Make it impossible to access the course form if the component entities are 
empty.

Make forms look like pages.

## Fix

When updating an entity from a page opened from another entity page, the change 
is not reflected on the first page.

Action icon buttons on entity pages have a tiny built-in padding.

# Cloud

## Do

Rename the `data` collection to `schedule`.

## Consider

Make access codes only valid for a period of time.

# Code

## Consider

If schedule forms become more complex, create classes for form data to avoid 
duplication of field processing logic.

Reduce duplication across entity actions.

Reduce duplication across the entity `AsyncNotifier`s.

Reduce duplication between `OptionsPage` and `InstructorsOptionsPage`.

# Questions

How do forms work in Flutter?

`@Riverpod(dependencies)`: What does it change? What is a scoped provider?

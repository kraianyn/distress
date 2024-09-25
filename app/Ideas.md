# UI

## Do

Style the actions bar on entity pages.

Do not imply that the courses have been fetched on entity pages.

Make the user know if field values are invalid.

Make it impossible to access the course form if the component entities are 
empty, or add an ability to add them when adding a course. Imply the new entity 
as the desired one.

Use regular buttons instead of FABs if the page is dedicated to an action.

Make forms look like pages.

## Fix

When updating an entity from a page opened from another entity page, the change 
is not reflected on the first page.

# Cloud

## Do

Rename the `data` collection to `schedule`.

## Consider

Make access codes only valid for a period of time.

# Code

# Do

Rename the loading and the error pages to widgets.

## Consider

If schedule forms become more complex, create classes for form data to avoid 
duplication of field processing logic.

Reduce duplication across entity actions.

Reduce duplication across the entity `AsyncNotifier`s.

Reduce duplication between `OptionsPage` and `InstructorsOptionsPage`.

# Questions

How do forms work in Flutter?

`@Riverpod(dependencies)`: What does it change? What is a scoped provider?

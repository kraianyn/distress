# UI

## Do

Make the user know if field values are invalid.

Do not imply that the courses have been fetched on entity pages.

Make it impossible to access the course form if the component entities are 
empty, or add an ability to add them when adding a course. Imply the new entity 
as the desired one.

Make forms look like pages.

## Fix

When updating an entity from a page opened from another entity page, the change 
is not reflected on the first page.

## Consider

Use regular buttons instead of FABs if the page is dedicated to an action.

Move icons to entities. 

Move sorting to widgets.

Reduce duplication across entity actions.

Reduce duplication across the entity `AsyncNotifier`s.

Reduce duplication between `CourseForm.[askOption, askInstructors]`. 
Define `askFromOptions`, internally implementing the single-option case as a 
single-item list.

## Read

How do forms work in Flutter?

`@Riverpod(dependencies)`: What does it change? What is a scoped provider?

# Domain

# Data

Rename the `data` collection to `schedule`.

Consider making access codes only valid for a period of time.

# Code

Create classes for form data to avoid duplication of field processing logic.

Represent no actions in `EntityPage.actions` with an empty list instead of `null`.

Define `IconData.widget => Icon(this)`

Define `TitleText(text, context) => Text(text, Theme.of(context).textTheme.titleMedium)`

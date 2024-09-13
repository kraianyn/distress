# UI

## Do

Validate new entities.

Make the user know if the access code is wrong.

Make it impossible to access the course form if the need entities are empty.

Do not imply that the courses have been fetched on entity pages.

Add an ability to add entities when adding a course. Imply the added entity as 
the desired one.

## Fix

When selecting instructors and closing the page by a gesture instead of the 
button, the instructors are added to the list, but not to the field. The options are:
- Treat the gesture as an alternative way to confirm the selection. Then update 
the field when an instructor is selected, not when the button is pressed.
- Treat the gesture as canceling the selection. Then create a separate list for the 
selected instructors and only add them to the page list when the button is pressed.

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

`@Riverpod(dependencies)`: What does it change? What is a scoped provider?

# Domain

# Data

Rename the `data` collection to `schedule`.

Consider making access codes only valid for a period of time.

# Code

Move authentication to the data layer.

Define `IconData.widget => Icon(this)`

Define `TitleText(text, context) => Text(text, Theme.of(context).textTheme.titleMedium)

# UI

## Do

Validate new entities.

Make it impossible to access the course form if the need entities are empty.

Do not imply that the courses have been fetched on entity pages.

Remove the labels in the navigation bar.

Add an ability to add entities when adding a course. Imply the added entity as 
the desired one.

## Consider

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

# Code

Define `IcondData.widget/icon => Icon(this)`

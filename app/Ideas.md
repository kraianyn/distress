# UI

## Do

Validate new entities.

Generate real entity ids.

Sort and/or group course types.

Make it impossible to access the course form if the need entities are empty.

Remove the labels in the navigation bar.

Add an ability to add entities when adding a course. Imply the added entity as 
the desired one.

## Consider

Reduce duplication across the entity `AsyncNotifier`s.

Reduce duplication between `CourseForm.[askOption, askInstructors]`. 
Define `askFromOptions`, internally implementing the single-option case as a 
single-item list.

## Read

`@Riverpod(dependencies)`: What does it change? What is a scoped provider?

# Domain

Reduce duplication across the entities.

# Data

Reduce duplication in `Repository`.

# Code

In widget methods, take the `context` and `ref` parameters last.

Define `IcondData.widget/icon => Icon(this)`

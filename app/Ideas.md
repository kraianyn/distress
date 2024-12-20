# UI

## Do

Change how the info of a finished course is displayed.

Decide on the colors.

Change the app logo.

Change the splash screen.

## Fix

Entity pages watch the entities, so deleting an entity before the page is closed 
causes en error.

## Consider

Restyle the bottom navigation bar.

Hide impossible course component options (locations and instructors with a 
course on the chosen date).

# Code

## Consider

Make `ObjectField`s use `ListTile`s instead.

Define a `typedef` for `DocumentReference<ObjectMap>`.

Reorder imports.

Reduce duplication across `AsyncNotifier`s.

Reduce duplication between `OptionsPage` and `InstructorsOptionsPage`.

If schedule forms become more complex, create classes for form data to avoid 
duplication of field processing logic.

# Cloud

## Do

Archive deleted course types so that schedule archive works.

Define security rules.

# Questions

What does `@Riverpod(dependencies)` change? What is a scoped provider?

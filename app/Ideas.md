# UI

## Do

Finish the authentication, authorization and introduction pages.

Finish the settings section. Add a subsection for the app users.

Add a title for courses on entity pages.

Use regular buttons instead of FABs if the page is dedicated to the action.

Make the user know if field values are invalid.

Make dates on course pages clickable to show all courses scheduled for the date.

### Negligible

Make it impossible to access the course form if the component entities are 
empty.

Make forms look like pages.

Remove the tiny built-in padding in action icon buttons on entity pages.

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

# Cloud

## Do

Rename the `data` collection to `schedule`.

# Code

## Consider

Make sure `AsyncNotifier`s await their `future` where needed.

Should `CoursesNotifier.[deleteWithType, deleteWithLocation]` set the state?
Is it ok that `CourseNotifier.removeInstructor` does not replace the courses?

Reorder imports.

Reduce duplication across entity actions.

Reduce duplication across the entity `AsyncNotifier`s.

Reduce duplication between `OptionsPage` and `InstructorsOptionsPage`.

If schedule forms become more complex, create classes for form data to avoid 
duplication of field processing logic.

# Questions

`@Riverpod(dependencies)`: What does it change? What is a scoped provider?

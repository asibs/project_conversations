# Project Conversation

## Summary

A basic Ruby on Rails application which allows users to:

- Sign up for an account, and login
- Create new Projects
- View all existing Projects
- Click on individual Projects to see the history of the Projects status and all comments / conversation about the Project
- Update the status of a Project
- Add new comments to a Project

## Questions

- Who are the users for this application? Is it an internal tool just for Homey! staff, or public-facing, or Software as a Service (SaaS) which will be used by different companies with different permissions (eg. if "Company A" creates a project, presumably only their employees should be able to see that project)?

- How do we expect most users to use this application? If it's public-facing we might expect lots of mobile devices and therefore might wish to take a mobile-first approach. If it's primarily targeted at Homey! staff and/or staff at other companies, they might be more likely to be interacting with the application via laptops with larger screens.

- What type of projects are we dealing with? Eg. are we tracking the status of internal Homey! projects, such as tech projects? What attributes does a project have other than a status?

- What are the possible status' a project could have? This will depend on the type of projects we are dealing with. If it was a tech project / task tracker we might have some classic status' such as "TODO", "In Progress", "In Review", "Done". If it was a more general project management tool we would probably have different status'. If it was a SaaS tool, we may well want users to be able to add their own custom status' to better suit the specific needs of their company.

- When a projects status changes, or when a comment is added to a project, should others involved in the project be informed (eg. via email, push notification, etc)? How frequently do we expect project status' to change and comments to be left? How many users do we expect, and how do we want users to say they are (or conversely, aren't) interested in being notified about changes to different projects?

- Who can change a project status, or add comments to a project? Is it all users, or just certain users? Are the users who can change status / comment the same for every project, or are there different permissions for each project?

- Are comments 'single level' or are there 'threads' in the comments for a project (similar to Slack threads for example)? If there are threads, how many layers of threads can there be (eg. could there be a "thread within a thread")?

- Should comments be plaintext or a rich format (such as using simple markdown like Slack - eg. asterisks for bold text, underscores for italic text, etc)? Should comments allow you to attach files or upload media like images, videos, etc?

- Are there any existing products which do a similar thing? Have the stakeholders used them? Anything the stakeholders especially like or dislike about these systems? Would it be possible to use these existing systems rather than building our own? If not, what should our system do differently, and is there anything we can take inspiration from?

- What branding / style do we want our system to have? Do we already have products whose branding / style we can re-use? If not, are there any products we really like the UX of, which we would like to take inspiration from (even if the product does something completely different)?


## Assumptions / Answers to Questions:

- This is an internal tool - not public-facing or SaaS. If we wanted to add SaaS functionality later, this would not change the fundamental data we need to store, but we would need to layer some additional data structures and permissions models on top.

- The tool will primarily be accessed from laptops, but it should still be functional and not frustrating to use on mobile devices.

- Projects have a name, description, status, and due date. The status may be "TODO", "In Progress", "In Review", "Done". Ideally, users could add new status' - but we won't tackle this in the Minimum Viable Product. However, we should make it easy for developers to add new status' in future - and if/when we wanted to let users add their own new project status', this should be possible without reworking all the code or data structures.

- Ideally, a user would get an email or push notification when a project they are interested in changes status or has a comment added. For the Minimum Viable Product, we can assume all users are interested in all projects, and rather than sending emails or push notifications, we can show them a 'new notification' icon in the web app.

- Ideally we could set different permissions for different users/projects in terms of who can change the project status, who can comment, and who can see each project. But for the Minimum Viable Product, it's OK for all users to be able to do everything (view, comment and change status of any project).

- There are no comment threads - comments on a project are all at the same 'level'. Ideally comments could include rich text similar to slack (bold, italics, etc) and a facility to upload files. But this is not required for the Minimum Viable Product.

- For the purpose of this exercise, we assume the closest products to what we're building are things like Trello & Jira - but we want to build our own internal tool rather than use existing tools.

- There are no particular tools we wish to take inspiration from in terms of UI/UX. As it's an internal tool, we simply want something which is clean & functional.


## Technology choices:

- The commonly-used [Devise gem](https://github.com/heartcombo/devise) has been used for authentication via username & password. This integrates well with the [Omniauth gem](https://github.com/omniauth/omniauth) if in future we wanted to add other login methods (eg. login via Gmail account, facebook account, etc).
- [Bootstrap](https://getbootstrap.com/) has been used for some simple styling - while it may not be suitable for all applications, for simple & functional styling of internal applications, and creating simple responsive (mobile-friendly) pages, bootstrap is more than sufficient. It also has good documentation and is well-known by many developers.


## Data structures (database tables / Rails models):

- `User` - represents a user - holds the data which allows a user to login (eg. username / password)

- `Status` - represents the different status' a project can be in - adding a new status should be as simple as adding a record to this database table

- `Project` - represents a project - with a name, description and due date

- `ProjectStatus` - represents that a project was updated to a specific status at a particular date/time, so we always have the history of the project status available. Links a project to a status, with a timestamp of when the project was changed to this status.

- `Comment` - represent a comment made by a user on a project. Includes the comment text, a link to the user, a link to the project, and the timestamp of when the comment was added to the project.


## Future Enhancements

- Currently the system tracks which user created which comment, but doesn't track which user created which projects, or which user changed the status of the project when. This would be a simple addition by adding a `user_id` foreign key to the `Project` & `ProjectStatus` models, and setting this to the logged-in user when creating new entries in either of these tables.

- The styling of the Login / Signup page is just the default provided by the [Devise Gem](https://github.com/heartcombo/devise), given more time I would override this by at least applying the default Bootstrap styles so the text boxes & buttons on login / signup are consistent with the styles in the rest of the app.

- Only very basic styling has been applied, given more time I would improve the UX of the overall application.

- I ran out of time to add any support for notifications when a project status was changed or a comment was added. This would be possible by adding a `Notification` database table / model. Each time a `ProjectStatus` or `Comment` is added, we would want to create a new `Notification` entry for each `User` (aside from the user who is changing the Project Status, or adding the Comment!). This could be achieved with an `after_create_commit` hook on the `ProjectStatus` and `Comment` models. The `Notification` should have a column/attribute indicating whether the user has seen the notification or not. If not, the NavBar could display an icon with a number showing how many notifications the user has. When clicked, this could drop-down with each notification, and clicking them could take the user to the relevant project (where the Status was changed or a comment was added). Once a user has clicked we can mark the notification as seen. We could also provide a button for a user to clear all of their notifications.

- As a Rails 7 project, [Turbo / Hotwire](https://www.hotrails.dev/turbo-rails) are installed by default. However, I did not have time to make use of [Turbo Frames](https://www.hotrails.dev/turbo-rails/turbo-frames-and-turbo-streams) which would have been nice - eg. so you could add a new project without being navigated away from the main Projects list. Equally, making use of [Turby Streams](https://www.hotrails.dev/turbo-rails/turbo-streams) would have been good so multiple users commenting on the same Project would see updates automatically without having to refresh the page. Similarly, had the notifications been implemented, these would have been a good candidate for Turbo Streams so a user browsing the application would see they had a new notification immediately rather than only seeing it the next time they loaded a new page.

- If more fine-grained permissions were required (eg. only some users are allowed to change project status', or permissions vary by project), then I would likely add an Authorisation gem such as [Pundit](https://github.com/varvet/pundit), [Rolify](https://github.com/rolifycommunity/rolify) or [CanCanCan](https://github.com/cancancommunity/cancancan).

- No unit or system tests have been added - if this was being deployed to a production context, I would add tests - prioritising tests for the most business-critical functionality first.


## Installing and running the app locally:

Assumes you have Ruby 3.1.2 installed with the foreman ruby gem installed, and have a local postgreSQL installation.

1. Checkout the repo from GitHub: `git clone ...`
2. Switch into the new project directory: `cd project_conversation`
3. Install dependencies: `bundle install`
4. Create the database: `rails db:create`
5. Run all migrations on the database: `rails db:migrate`
6. Populate the database with initial data: `rails db:seed`
7. Run the development server: `./bin/dev`
8. Visit the app at http://localhost:3000


## Original Brief

Use Ruby on Rails to build a project conversation history. A user should be able to:

- leave a comment
- change the status of the project

The project conversation history should list comments and changes in status.

Please don’t spend any more than 3 hours on this task.

Treat this as if this was the only information given to you by a team member, and take the approach you would normally take in order to build the right product for the company.

To this extent:

- Please write down the questions you would have asked your colleagues
- Include answers that you might expect from them
- Then build a project conversation based on the answers to the questions you raised.

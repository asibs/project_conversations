# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



Use Ruby on Rails to build a project conversation history. A user should be able to:

- leave a comment
- change the status of the project

The project conversation history should list comments and changes in status.

Please don’t spend any more than 3 hours on this task.


Questions:

- Who are the users for this application? Is it an internal tool just for Homey! staff, or public-facing, or Software as a Service (SaaS) which will be used by different companies with different permissions (eg. if company A creates a project, only their employees can see it)?

- How do we expect most users to use this application? If it's public-facing we might expect lots of mobile devices and therefore might wish to take a mobile-first approach. If it's primarily targeted at Homey! staff and/or staff at other companies, they might be more likely to be interacting with the application via laptops with larger screens.

- What type of projects are we dealing with? Eg. are we tracking the status of internal Homey! projects, such as tech projects? What attributes does a project have other than a status?

- What are the possible status' a project could have? This will depend on the type of projects we are dealing with. If it was a tech project / task tracker we might have some classic status' such as "todo", "in progress", "in review", "done". If it was a more general project management tool we would probably have different status'. If it was a SaaS tool, we may well want users to be able to add their own custom status' to better suit their needs.

- When a projects status changes, or when a comment is added to a project, should others involved in the project be informed (eg. via email, push notification, etc)? How frequently do we expect project status' to change and comments to be left? How many users do we expect, and how do we want users to say they are (or conversely, aren't) interested in being notified about changes to different projects?

- Who can change a project status, or add comments to a project? Is it all users, or just certain users? Are these users the same for every project, or are there different permissions for each project?

- Are comments 'single level' or are there 'threads' in the comments for a project (similar to Slack for example)? If there are threads, how many layers of threads can there be?

- Should comments be plaintext or a rich format (such as using simple markdown like Slack - eg. asterisks for bold text, underscores for italic text, etc)? Should comments allow you to attach files or upload media like images, videos, etc?

- Are there any existing products which do a similar thing? Have the stakeholders used them? Anything the stakeholders especially like or dislike about these systems? Would it be possible to use these existing systems rather than building our own? If not, what should our system do differently, and is there anything we can take inspiration from?

- What branding / style do we want our system to have? Do we already have products whose branding / style we can re-use? If not, are there any products we really like the UX of, which we would like to take inspiration from (even if the product does something completely different)?


Assumptions:

- This is an internal tool - not public-facing or SaaS. If we wanted to add SaaS functionality later, this would not change the fundamental data we need to store, but we would need to layer some additional permissions on top.

- The tool will primarily be accessed from laptops, but it should still be functional and not frustrating to use on mobile devices.

- Projects have a name, description, status, and due date. The status may be "to do", "in progress", "in review", "done". Ideally, users could add new status' - but we won't tackle this in the MVP. However, we should make it easy for developers to add new status' in future - and if/when we wanted to let users to add their own new project status', this should be possible without reworking all the code or data structures.

- Ideally, a user would get an email or push notification when a project they are interested in changes status or has a comment added. For the MVP, we can assume all users are interested in all projects, and rather than sending emails or push notifications, we can show them a 'new notification' icon in the web app.

- Ideally we could set different permissions for different users/projects in terms of who can change the project status, who can comment, and who can see each project. But for the MVP, it's OK for all users to be able to do everything (view, comment and change status of any project).

- There are no comment threads - comments on a project are all at the same 'level'. Ideally comments could include rich text similar to slack (bold, italics, etc) and a facility to upload files. But this is not required for the MVP.

- For the purpose of this exercise, we assume the closest products to what we're building are things like Trello & Jira - but we want to build our own internal tool.

- There are no particular tools we wish to take inspiration from in terms of UI/UX. As it's an internal tool, we simply want something which is clean & functional.




Installing and running the app:

Assumes you have Ruby 3.1.2 installed with the foreman ruby gem installed, and have a local postgres installation.

1. Checkout the repo from GitHub: `git clone ...`
2. Switch into the new project directory: `cd project_conversation`
3. Install dependencies: `bundle install`
4. Create the database: `rails db:create`
5. Run all migrations on the database: `rails db:migrate`
6. Populate the database with initial data: `rails db:seed`
7. Run the development server: `./bin/dev`
8. Visit the app at http://localhost:3000



Technology choices:

- The commonly-used [Devise gem](https://github.com/heartcombo/devise) for authentication via username & password. This integrates well with the [Omniauth gem](https://github.com/omniauth/omniauth) if in future we wanted to add other login methods (eg. login via Gmail account, facebook account, etc).
- [Bootstrap](https://getbootstrap.com/) for simple styling - while it may not be suitable for all applications, for simple & functional styling of internal applications, and creating simple responsive (mobile-friendly) pages, bootstrap is more than sufficient. It also has good documentation and is well-known by many developers.



Data structures:

- Users - represents a user - holds the data which allows a user to login (eg. username / password)

- Status' - represents the different status' a project can be in - adding a new status should be as simple as adding a record to this database table

- Projects - represents a project - with a name, description and due date

- Project Status' - represents that a project was updated to a specific status at a particular date/time, so we always have the history of the project status available. Links a project to a status, with a timestamp of when the project was changed to this status.

- Comments - represent a comment made by a user on a project. Includes the comment text, a link to the user, a link to the project, and the timestamp of when the comment was added to the project.

- Notification - represent a notification we need to show to a user that something new has happened on the system (ie. a new project has been added, or a new comment has been added). These notifications should include a text description of what the notification is about, a link to the page to view the new thing (the new project or the new comment), a link to the user this notification is for, and whether this notification has been read or not by the user.

# wardrobe++ (Project 2)

wardrobe++ is a CRUD application made to build upon my knowledge of Ruby/Sinatra and postgreSQL. It utilises a users and items table in the database (in postgreSQL) to handle functionality.

## Usage

Browsing the website can be done at [wardrobe++](https://wardrobe-project.herokuapp.com/) but performing creation, updates or removal of listings will require user account creation or login. Usernames, emails and passwords are validated upon accoutn creation and the password is  digested by bcrypt and stored as a digested password in the database.

# Challenges
* Submission of SQL to the database was tricky at first. A few errors and some mistakes caused deletion / modification of every entry.
* Using the currency conversion API gave some issues with tryign to convert numbers - still needs some work as of January 10, 2022.

# To be implemented
In future, the following features will be implemented to wardrobe++:
* COnversion - currency conversion to be shown to users (in AUD by default) as required.
* Wishlist - option for users to add to wishlist / track items.
* Search - ability for users to search for specific content.
* Active / Inactive listings - filter for sold listings to allow users to track sold items vs active listings.

# Bugs / Issues
* Responsiveness - lacking responsive UI with minimal window resizing.
* Edit listings - any user can edit any users listings provided they have the users profile link.

## Externals
* All images gathered from ssense.com to show products on a simple white background and product
* Currency data provided by exchangeratesapi.io
* Anonymous Pro font (Google Fonts)
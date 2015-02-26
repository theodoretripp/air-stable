This is my scratch pad for informal todo list.

## Progress adapting the can-i-eat-here example to air-stable:

[x] 2/21 "Handle Password Errors more gracefully"

[x] 2/21 Add Validatons for Name and Email Address

[x] 2/21 Make form fields proceed down the page, instead of across it.

[x] 2/21 Allow Users to log in

[x] 2/21 Registering logs you in

[x] 2/22 Add a base line of security for sessions

[x] 2/22 Greet logged in users by name

[x] 2/22 Make sessions routes singular

[x] 2/22 User may log out

[x] 2/22 User may add a restaurant

[x] 2/22 Prevent guests from creating restaurants

[x] 2/22 User may add a dietary restriction - tried to start diverging from example
         It's not going to well.  Sticking with example to the end and then...?

[x] 2/23 User may add a supported restriction to a restaurant - this is where I was tring to go on my own yesterday.
         Once I finish the example then I can remove the user ability to add unattached request
         Getting const error from Class Stall in models.rb.  I think I need to
         rename the RentalRequest without the underscore to RentalRequest.
         I should be able to change any occurence of RentalRequest to rentalrequest
         because it's never been anything but a style choice - the underscore in
         the name isn't like a datamapper type underscore
    [x]  yes this worked - NameError resolved. found other typo also.

[x] 2/23 Add search capability
    QUESTION - on home.erb with new search I don't see how all stalls are
    displayed? @stalls = the query result right? Not Stalls.all.

[x] 2/23 Retrieve and store latitude and longitude w/restaurant

[x] 2/23 User may search based upon location
    QUESTION seems like the search for name and location together are broken -
    if you type like name you get all results not filtered by location
    Can't search by location only...

[ ] Try running on Heroku
[ ] Start Diverging from can-i-eat-here example


## Note

- if you delete the database make sure to also clear the rack cookie for the logged in user session.
- otherwise you'll get a name not defined error.
- OR logging out of the session before deleting db would probably also prevent this.

## Functional Requirements

[ ] `User` may create a pending `RentalRequest` for a `Stall`
    view
    [ ] associate `RentalRequest` with a stall on creation.
    Can I use Stall as a model, it belongs to user on creation?

    [ ] add to `RentalRequest` class "status" property type string (pending or approved or denied)
    [ ] add to `RentalRequest` class "rental_date" property type date
    [ ] change stable list to include link (Rent this?)
    [ ] new_RentalRequest.erb will have form with hidden inputs for the `Stall`
        details (similar to past examples) and `User` details
    [ ] hidden input for "status" => pending or approved or denied
    [ ] new input for open comment (worry about date, price later)
    model

[ ] `Stall` owner may see pending `RentalRequest`s
[ ] `RentalRequest`s requester may see pending `RentalRequest`s
[ ] `Stall` owner may deny `RentalRequest`s for their `Stall`
[ ] `Stall` owner may approve `RentalRequest`s for their `Stall`
[ ] `RentalRequest`s requester may see denied `RentalRequest`s
[ ] `Stall` renter may see allowed `RentalRequest`s

## DONE

1. Guest may register as a `User`
1. Guest may log in
1. `User` may create a Stall
1. `User` may see a list of available `Stall`s
1. `User` may tag a stall with a rentalrequest (still need to take out intermediate
    step.)
1. `User` may search stalls, address, request.
1. `User` may sear stalls by location



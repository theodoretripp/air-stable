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
         It's not going to well.  May just stick with example to the end and then...?

[ ] 2/22

[ ] 2/22

[ ] 2/22

[ ] 2/22

## Note

- if you delete the database make sure to also clear the rack cookie for the logged in user session.
- otherwise you'll get a name not defined error.
- OR logging out of the session before deleting db would probably also prevent this.

## Functional Requirements

[ ] `User` may create a pending `RentalRequest` for a `Stall`
    view
    [x] add to `Rental_Request` class "status" property type string (pending or approved or denied)
    [x] add to `Rental_Request` class "rental_date" property type date
    [ ] change stable list to include link (Rent this?)
    [ ] new_rental_request.erb will have form with hidden inputs for the `Stall`
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
2. 1. Guest may log in
1. `User` may create a Stall
1. `User` may see a list of available `Stall`s
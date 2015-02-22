This is my readme. More of a scratch pad for informal todo list.

## Progress adapting the can-i-eat-here example to air-stable:
:heavy check: 2/21 "Handle Password Errors more gracefully"
:heavy check: 2/21 Add Validatons for Name and Email Address
:heavy check: 2/21 Make form fields proceed down the page, instead of across it.
:heavy check: 2/21 Allow Users to log in
:heavy check: 2/21 Registering logs you in
:heavy check: 2/22 Add a base line of security for sessions
:heavy check: 2/22 Greet logged in users by name
:heavy check: 2/22 Make sessions routes singular
:heavy check: 2/22 User may log out
:heavy check: 2/22 User may add a restaurant
:heavy check: 2/22 Prevent guests from creating restaurants
:heavy check: 2/22
:heavy check: 2/22
:heavy check: 2/22
:heavy check: 2/22
:heavy check: 2/22

## Functional Requirements

1. Change stable to stall
1. Guest may log in


1. `User` may create a pending `RentalRequest` for a `Stall`
    view
      > change stable list to include link (Rent this?)
      > new_rental_request.erb will have form with hidden inputs for the `Stall`
        details (similar to past examples) and `User` details
      > hidden input for "status" => pending or approved or denied
      > new input for open comment (worry about date, price later)
    model
      DONE > add to `Rental_Request` class "status" property type string (pending or approved or denied)
      DONE > add to `Rental_Request` class "rental_date" property type date



1. `Stall` owner may see pending `RentalRequest`s
1. `RentalRequest`s requester may see pending `RentalRequest`s
1. `Stall` owner may deny `RentalRequest`s for their `Stall`
1. `Stall` owner may approve `RentalRequest`s for their `Stall`
1. `RentalRequest`s requester may see denied `RentalRequest`s
1. `Stall` renter may see allowed `RentalRequest`s

### DONE !
1. Guest may register as a `User`
1. `User` may create a Stall
1. `User` may see a list of available `Stall`s
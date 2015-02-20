This is my readme. More of a scratch pad for informal todo list.

## Functional Requirements

1. Guest may register as a `User`
1. Guest may log in
1. `User` may create a Stall
1. `User` may see a list of available `Stall`s
1. `User` may create a pending `RentalRequest` for a `Stall`
1. `Stall` owner may see pending `RentalRequest`s
1. `RentalRequest`s requester may see pending `RentalRequest`s
1. `Stall` owner may deny `RentalRequest`s for their `Stall`
1. `Stall` owner may approve `RentalRequest`s for their `Stall`
1. `RentalRequest`s requester may see denied `RentalRequest`s
1. `Stall` renter may see allowed `RentalRequest`s
2.

do I make a Gemfile.lock or is it generated?
contents of canIeathere
+GEM
+  remote: https://rubygems.org/
+  specs:
+    celluloid (0.15.2)
+      timers (~> 1.1.0)
+    ffi (1.9.3)
+    listen (2.7.9)
+      celluloid (>= 0.15.2)
+      rb-fsevent (>= 0.9.3)
+      rb-inotify (>= 0.9)
+    rack (1.5.2)
+    rack-protection (1.5.3)
+      rack
+    rb-fsevent (0.9.4)
+    rb-inotify (0.9.5)
+      ffi (>= 0.5.0)
+    rerun (0.10.0)
+      listen (~> 2.7, >= 2.7.3)
+    sinatra (1.4.5)
+      rack (~> 1.4)
+      rack-protection (~> 1.4)
+      tilt (~> 1.3, >= 1.3.4)
+    tilt (1.4.1)
+    timers (1.1.0)
+
+PLATFORMS
+  ruby
+
+DEPENDENCIES
+  rerun
+  sinatra
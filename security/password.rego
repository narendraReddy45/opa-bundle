package security.password

import future.keywords.contains
import future.keywords.if
import future.keywords.in

default allow = false

deny contains msg if {
	not input.password
	msg := "Password not found"
}

deny contains msg if {
	not count(input.password) >= 8
	msg := "Password must be of length greater than or equal to 8"
}

deny contains msg if {
	input.password in data.bad_passwords
	msg := "Unsafe password"
}

allow if {
	count(deny) == 0
}

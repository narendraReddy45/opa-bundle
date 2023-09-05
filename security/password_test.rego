package security.password

import future.keywords

test_undefined_password if {
    msg := "Password not found"
    deny[msg] with input as {}
    not allow

}

test_password_with_less_than_8_chars if {
    msg := "Password must be of length greater than or equal to 8"
    deny[msg] with input as {"password":"abcd"}
    not allow
}

test_unsafe_password if {
    msg := "Unsafe password"
    deny[msg] with input as {"password": "abcdefgh"}
    not allow
}
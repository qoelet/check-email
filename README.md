# check-email

Confirm whether an email is valid and probably existant.

```shell
Prelude> import Network.Email.Check
Prelude Network.Email.Check> :set -XOverloadedStrings
Prelude Network.Email.Check> check "chrisdone@gmail.com"
Right "chrisdone@gmail.com"
Prelude Network.Email.Check> check "foo@foobar.net"
Left "no MX record exists for domain foobar.net"
```

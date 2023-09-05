This repository explores Open Policy Agent (for OPA in short) with policies packed as a bundle and stored in a remote url

* `security/password.rego` is rego file for enforcing password policies
* `security/password_test.rego` is unit test for password.rego policy file
* `data.json` is data used in evaluation

### Create opa bundle

```sh
cd bundles
opa build ../security --output security.bundle.tar.gz
```

### Setup local test environment

```
docker-compose up -d --build
```

### Check policies
```sh
curl --header "Content-Type: application/json" \
  --request GET \
http://localhost:8181/v1/policies
```

### Testing policy with input

```sh
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"input": {"password": "abcd"}}' \
http://localhost:8181/v1/data/security/password/deny
```
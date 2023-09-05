This repository explores Open Policy Agent (for OPA in short) with policies packed as a bundle and stored in a remote url

* `security/password.rego` is rego file for enforcing password policies
* `security/password_test.rego` is unit test for password.rego policy file
* `data.json` is data used in evaluation

### Create opa bundle

```sh
cd bundles
opa build ../security --output security.bundle.tar.gz
```

### Running unit tests
```sh
opa test -b <bundle path>
```
For example to test password policy
```sh
opa test -b bundles/security.bundle.tar.gz
```

### Configuring policies from remote url
OPA provides various ways to add policies,
* API for CRUD (create,read,update,delete) operations on policies
* Policies packed as a bundle
  * Policies are loaded in runtime without restarts
* `opa/config.yaml` configuration file has services and api from where bundle can be fetched periodically
  * As specified in configuration OPA fetches bundle from url `http://host.docker.internal:8080/opa/security.bundle.tar.gz` 

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
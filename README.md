RSpec API weather example
===========================

Example API to query a weather service.

This repo can be used for pair interviews.

Requirements
------------

Create an account in https://developer.worldweatheronline.com/my


To test and run
------

```
# Load the secret token from https://developer.worldweatheronline.com/my
export WORLDWEATHERONLINE_API_KEY=$(pass webs/developer.worldweatheronline.com/api_key)

# Check your creds work, by query the current temperature
curl -qs "https://api.worldweatheronline.com/premium/v1/weather.ashx?key=${WORLDWEATHERONLINE_API_KEY}&q=London&format=json" | jq -r '.data.current_condition[0].temp_C'
```

To run tests and start the service:

```
# Run tests and rubocop
rake

# Run server
rake serve
```

Challenges
----------

The challeges are encryped symmetrically in the `CHALLENGE*.md.gpg` files.

To decrypt:

```
gpg -d < CHALLENGE-01.md.gpg
```

And put the right password.

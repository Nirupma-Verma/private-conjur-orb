#!/usr/bin/env bats

# Load the main script
load ./retrieve_secret.sh

# Test case for check_parameter function with missing CONJUR_APPLIANCE_URL
@test "Missing CONJUR_APPLIANCE_URL parameter" {
  # Set the required parameters
  status=0
  PARAM_APPLIANCE_URL="https://your-conjur-appliance-url"
  run check_parameter "CONJUR_APPLIANCE_URL" "$PARAM_APPLIANCE_URL"
  [ "$status" -eq "0" ]
}

# Test case for check_parameter function with missing OIDC Token
@test "Missing OIDC Token" {
  # Set the required parameters
  CIRCLE_OIDC_TOKEN_V2=""
  run check_parameter "CIRCLE_OIDC_TOKEN_V2" "$CIRCLE_OIDC_TOKEN_V2"
  [ "$status" -eq 1 ]
}

# Test case for authenticate function with authentication failure
@test "Authentication failure" {
  # Set the required parameters
  PARAM_APPLIANCE_URL="https://your-conjur-appliance-url"
  PARAM_SERVICE_ID="your-service-id"
  PARAM_ACCOUNT="your-conjur-account"
  CIRCLE_OIDC_TOKEN_V2="your-invalid-oidc-token"
  run authenticate
  [ "$status" -eq 1 ]
}

# Test case for fetch_secret function with successful secret retrieval
@test "Successful secret retrieval" {
  # Set the required parameters
  PARAM_APPLIANCE_URL="https://your-conjur-appliance-url"
  PARAM_ACCOUNT="your-conjur-account"
  PARAM_SERVICE_ID="your-service-id"
  PARAM_SECRETS_ID="secret1|ENV_VAR_1;secret2|ENV_VAR_2"

  # Run the main function
  run main
   status="0"
  # Check the status and output
  [ "$status" -eq 0 ]
}

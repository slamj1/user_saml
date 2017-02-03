Feature: EnvironmentVariable

  Scenario: Authenticating using environment variable with SSO and no check if user exists on backend
    And The setting "type" is set to "environment-variable"
    And The setting "general-uid_mapping" is set to "REMOTE_USER"
    And The environment variable "REMOTE_USER" is set to "not-provisioned-user"
    When I send a GET request to "http://localhost/index.php/login"
    Then I should be redirected to "http://localhost/index.php/apps/files/"
    Then I should be logged-in to Nextcloud as user "not-provisioned-user"

  Scenario: Authenticating using environment variable with SSO and successful check if user exists on backend
    Given A local user with uid "provisioned-user" exists
    And The setting "type" is set to "environment-variable"
    And The setting "general-require_provisioned_account" is set to "1"
    And The setting "general-uid_mapping" is set to "REMOTE_USER"
    And The environment variable "REMOTE_USER" is set to "provisioned-user"
    When I send a GET request to "http://localhost/index.php/login"
    Then I should be redirected to "http://localhost/index.php/apps/files/"
    Then I should be logged-in to Nextcloud as user "provisioned-user"

  Scenario: Authenticating using environment variable with SSO and unsuccessful check if user exists on backend
    Given The setting "type" is set to "environment-variable"
    And The setting "general-require_provisioned_account" is set to "1"
    And The setting "general-uid_mapping" is set to "REMOTE_USER"
    And The environment variable "REMOTE_USER" is set to "certainly-not-provisioned-user"
    When I send a GET request to "http://localhost/index.php/login"
    Then I should be redirected to "http://localhost/index.php/apps/user_saml/saml/notProvisioned"
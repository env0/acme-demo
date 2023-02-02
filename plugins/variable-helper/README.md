# Variable Helper plugin

This plugin will fetch output values from another environment and insert them as terraform variables.


Similar to self hosted agent secrets, use this notation in the value of the terraform input value:

`${env0:<environment id>:<output name>}`

Howto:

1. Create a new environment or redeploy an existing environment.
2. Add a Terraform Variable
3. Key is the name of your Terraform Variable
4. Value is a _reference_ to another environment's output variable.
* For example, if I needed the VPC ID from my "Dev VPC" Environment:
  a. First I need to get the ENV0_ENVIRONMENT_ID from that environment.
     note: the Environment ID can be found in the URL: `https://app.env0.com/p/7320dd7a-4822-426c-84b5-62ddd8be0799/environments/9cec1eb6-c17f-4cca-9cdf-606a23cdf6b5` where `9cec1eb6-c17f-4cca-9cdf-606a23cdf6b5` is the ENV0_ENVIRONMENT_ID.
  b. Find the output name in the environment Resources tab.  e.g. `vpc_id`
  c. The value you enter would be then: `${env0:9cec1eb6-c17f-4cca-9cdf-606a23cdf6b5:vpc_id}`
5. Run the environment, and env0 will fetch the value


Requirements:

The ENV0 API KEY needs to be added with access to the target environments:
* `ENV0_API_KEY`
* `ENV0_API_SECRET` 
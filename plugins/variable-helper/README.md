# Variable Helper plugin

This plugin will fetch output values from another environment and insert them as terraform variables.


Howto:

Similar to self hosted agent secrets, use this notation in the value of the terraform input value:

`${env0:[environment id]:[output name]}`


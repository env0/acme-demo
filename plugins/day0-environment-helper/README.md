# Day 0 Environment Helper

This is a demonstration of how to setup env0 to automatically scan a folder for changes, and using the env0 TF provider to create the env0 environment resource per folder.

## How it works

This script scans a target folder (`$SOURCE_DIRECTORY`) for any matching files (`$SOURCE_FILENAME`). 

In my example, I set the variables with the following values:
* `SOURCE_DIRECTORY="dynamic-environments"`
* `SOURCE_FILENAME=main.tf`

The script will use `find` to look for `main.tf` in the `dynamic-environments` folder.

My git repo is structured like so:

```
.
├── README.md
├── dynamic-environments
│   ├── dev-svc
│   │   └── main.tf
│   └── dev-svc2
│       └── main.tf
└── day0-environment-helper
    ├── README.md
    ├── day0helper.sh
    ├── env0.yaml
    ├── main.tf
    ├── outputs.tf
    ├── provider.tf
    └── variables.tf
```
## Adding a new env0 environment
Simply create a PR that adds a new folder to the dynamic-environments folder with at least a main.tf.  The script will detect the folder and create an env0 Environment based on that main.tf

## Notes
* The script automatically populates the environment into an env0 project called "dynamic-environments." If necessary, you could consider using part of the folder path as a designation for the project.
* Since the environment is automatically generated, I recommend including a `*.auto.tfvars` for any variables that need to be specified with this environment.'
* Using the terraform provider to create the environments is useful for not only creating environments, but also removing old environments. By deleting the folder, the provider recognizes that the state needs to be removed, and thus destroy the corresponding environment in env0.

## Next Steps
* A lot of our customers use Atlantis, so we could adapt the script to read from an Atlantis.yaml to automatically generate the environments. 

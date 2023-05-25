# env0, terraform + ansible

Deploy an infrastructure (an ec2 instance anyway) then configure it with Ansible. All managed within env0.

Subsequent runs, and deploy-on-git-push will just re-run Ansible play. Great for updating things in the running VM.

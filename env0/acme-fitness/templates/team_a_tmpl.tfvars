templates = { 
    db_layer = { 
        name = "db layer", 
        description = "DB Layer for ACME FITNESS, managed by TF", 
        repository = "https://github.com/env0/acme-demo",
        path = "simple-terraform",
        revision = "main",
        terraform_version = "1.1.0",
        projects = ["Arnold's Developers", "Arnold's Staging", "Arnold's Production"],
        github_installation_id = 11551359,
        ssh_keys = []
    },
    frontend_layer = { 
        name = "frontend layer", 
        description = "Frontend Layer for ACME FITNESS, managed by TF", 
        repository = "https://github.com/env0/acme-demo",
        path = "simple-terraform",
        revision = "main",
        terraform_version = "1.1.0",
        projects = ["Arnold's Developers", "Arnold's Staging", "Arnold's Production"],
        github_installation_id = 11551359,
        ssh_keys = []
    },
    environment = { 
        name = "Environment", 
        description = "ALPHA Frontend Layer for ACME FITNESS, managed by TF", 
        repository = "https://github.com/env0/acme-demo",
        path = "env0/environment",
        revision = "tfprovider/env",
        terraform_version = "1.1.0",
        projects = ["!env0 Master"],
        github_installation_id = 11551359,
        ssh_keys = []
    },
    network_layer = { 
        name = "network layer", 
        description = "Network Layer for ACME FITNESS, managed by TF", 
        repository = "https://github.com/env0/acme-demo",
        path = "simple-terraform",
        revision = "main",
        terraform_version = "1.1.0",
        projects = ["Arnold's Staging", "Arnold's Production"],
        github_installation_id = 11551359,
        ssh_keys = []
    }
}
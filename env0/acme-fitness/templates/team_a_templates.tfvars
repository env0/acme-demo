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
        name = "ALPHA frontend layer v2", 
        description = "Frontend Layer V2 for ACME FITNESS, managed by TF", 
        repository = "https://github.com/env0/acme-demo",
        path = "simple-terraform",
        revision = "main",
        terraform_version = "1.1.0",
        projects = ["Arnold's Developers"],
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
    networking_layer = { 
        name = "network layer", 
        description = "Network Layer for ACME FITNESS, managed by TF", 
        repository = "https://github.com/env0/acme-demo",
        path = "simple-terraform",
        revision = "main",
        terraform_version = "1.1.0",
        projects = ["Arnold's Production", "Arnold's Staging"],
        github_installation_id = 11551359,
        ssh_keys = []
    }
}
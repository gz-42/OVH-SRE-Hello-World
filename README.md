# OVH SRE Hello World - Infrastructure Exercise

## What This Project Does

I built this project to show how I deploy and monitor a simple web application using modern DevOps tools. The application itself is just a "hello world" Go server, but I treated it like a real production system.

The main goal was to take a basic application and build proper infrastructure around it - the kind of setup that would actually work in production and be easy to maintain.

## My Approach

I focused on three main ideas that I think are important for good infrastructure:

**Everything as Code**: I used Terraform to define all the infrastructure. This way, anyone can see exactly how everything is set up just by reading the configuration files.

**Security from the Start**: Instead of adding security later, I built it in from the beginning. The application runs as a non-root user in a minimal container, SSH is properly configured, strict firewall rules on the host and everything uses HTTPS.

**Monitoring Built-in**: The application exposes metrics that Prometheus can collect automatically. I set up Grafana dashboards to visualize what's happening.

## Technical Stack

### The Application
The Go application is simple but includes the basics you need for production:
- REST API using Gin framework that serves "hello world" on `/`
- Prometheus metrics endpoint on `/metrics` that counts visits
- Docker container built from scratch image for security
- Multi-stage docker image to keep it light as it was a compiled binary
- Runs as non-root user (UID 4242) with minimal permissions

### Infrastructure Setup
I used **Ansible** to prepare the server:
- System hardening with proper SSH configuration
- Fail2ban to block suspicious login attempts
- Docker installation with secure configuration
- All the prerequisites for running Kubernetes
- Terraform installed and configured
- The Terraform code was pushed to the server and ready to be deployed

I used **Terraform** to manage the application infrastructure:
- Modular approach, everything as a variable
- Minikube cluster with necessary addons
- ArgoCD for automated deployments from Git
- cert-manager for automatic SSL certificates
- Complete monitoring stack with Prometheus and Grafana

I used **GitHub Actions** to minimize the manuals tasks I needed to do on the server
- Each Ansible Playbook/role have a corresponding workflow
- It allows me to manage the secrets with efficiency

### Security Features
Security is implemented at multiple levels:
- SSH hardened with key authentication only
- Strict firewall rule to avoid the internal services to be reach from the internet while letting all the internal traffic communicate
- Automatic SSL certificates for all web interfaces

### Monitoring and Observability
The monitoring setup gives visibility into both the application and infrastructure:
- Application metrics collected by Prometheus
- Custom Grafana dashboard for the hello-world service
- Infrastructure monitoring with node metrics
- Automatic service discovery for new applications
- Automatic Slack alert through AlertManager via a webhook
- Volume snapshots for backup and recovery

## How It Works

The deployment follows a GitOps pattern where everything is automated:

1. **Server Preparation**: Ansible configures the VPS with security hardening and Docker
2. **Infrastructure Deployment**: Terraform creates the Kubernetes cluster and all services  
3. **Application Deployment**: ArgoCD automatically deploys the application from the Git repository
4. **Monitoring Setup**: Prometheus starts collecting metrics and Grafana provides dashboards

Each part can be deployed separately and tested independently. If something breaks, you can easily roll back or fix just that component.

## Key Technical Decisions

### Why Minikube?
I chose Minikube because it's simple to set up and understand, while still supporting all the Kubernetes features I needed. The same Terraform modules would work with any other Kubernetes cluster.
The downside of it is that I struggled a lot to be able to acheive the level of automation that I aimed. The ssh driver is broken and I needed to change my architecture pretty far into the project.

### Infrastructure as Code
I put everything in Terraform because manual setup doesn't scale and creates problems when you need to recreate environments. With Infrastructure as Code, the documentation is the actual configuration.
Modularity is the key, I was able to reuse my ArgoCD, Kube-Prometheus-Stack and Cert-Manager modules that I builded for another project which save me a lot of time.

### Container Security
The application runs in a scratch-based container to minimize the attack surface. It uses a non-root user and drops all Linux capabilities it doesn't need.

### GitOps Approach
ArgoCD automatically keeps the cluster in sync with what's defined in Git. This is more reliable than traditional CI/CD because the cluster pulls changes instead of having external systems push to it.

## Production Readiness

This setup includes several features that make it suitable for real use:

**Reliable Monitoring**: The custom Grafana dashboard shows metrics that actually matter for the application, not just technical stats.

**Backup Strategy**: Volume snapshots are configured for persistent data, and the entire setup can be recreated if needed.

**Easy Troubleshooting**: The modular design means you can fix problems without affecting the whole system.

**Automated Maintenance**: SSL certificates renew automatically, and the immutable infrastructure approach means you can easily revert bad changes.

## What I Learned

This project taught me several important lessons:

**Start Simple**: I began with a basic application and added complexity gradually. This made it easier to understand each component and debug problems.

**Security First**: It's much easier to build security in from the beginning than to add it later. Things like container security contexts and SSH hardening should be part of the initial setup.

**Monitoring is Essential**: You can't manage what you can't see. Having proper metrics and dashboards from day one makes everything easier to operate.

**Documentation Matters**: When everything is defined in code, the configuration files become the documentation. This helps other people (and future me) understand how things work.

## Future Improvements

If I were to extend this project, I would add:
- Full automation that I did not achieved due to the constrain of minikube usage
- Use the latest version of each component that I deployed
- Terraform remote state hosted in a private git repository
- Support for multiple environments (dev, staging, prod)
- More sophisticated backup and disaster recovery
- More detailed custom grafana dashboard
- Performance testing and capacity planning
- Auto redirection to avoid to see a blank nginx page when we are reaching a wrong path

## Conclusion

This project shows my approach to building infrastructure that's reliable, secure, and maintainable. It's not just about making something work - it's about creating systems that keep working over time and that other people can understand and modify.

The tools and patterns I used here reflect what I've learned about effective DevOps practices: automate everything, secure by default, monitor comprehensively, and always keep it simple enough to understand and maintain.

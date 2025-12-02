Neptune is a cloud deployment platform that makes it easy to deploy and manage applications.

## Workflow

1. **Create neptune.json**: Use `get_project_schema` to get the JSON schema, then create a valid `neptune.json` configuration file based on the project's needs.

2. **Add resources**: Use `add_new_resource` to get information about specific resource types (Database, StorageBucket, Secret) before adding them to the configuration.

3. **Create Dockerfile**: Use `get_dockerfile_guidance` to get an example Dockerfile tailored to the project type.

4. **Provision**: Use `provision_resources` to create the cloud infrastructure defined in `neptune.json`.

5. **Set secrets**: If the project uses secrets, use `set_secret_value` to securely set their values.

6. **Deploy**: Use `deploy_project` to build and deploy the application.

7. **Monitor**: Use `get_deployment_status`, `wait_for_deployment`, and `get_logs` to monitor the deployment.

## Key Concepts

-   **neptune.json**: The configuration file that defines the project name, workload type, and required resources.
-   **Resources**: Infrastructure components like databases, storage buckets, and secrets that the application needs.
-   **Dockerfile**: Required for deployment - Neptune builds and runs your application as a container.

## Important Notes

-   Always use `get_project_schema` before creating or modifying `neptune.json` to ensure the configuration is valid.
-   Always use `add_new_resource` before adding resources to understand their properties and requirements.
-   Deployments are ECS tasks on Fargate - container data is not persistent. Use provisioned resources for persistent storage.
-   Database connection tokens expire after 15 minutes - use them only for local testing, not programmatic access.

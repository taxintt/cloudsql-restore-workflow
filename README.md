# cloudsql-restore-workflow
This is a sample for restore of Cloud SQL instance.

- Restore database from backup
- Execute sql statements (by using cloud functions)
- Create a backup of the database

1. Prepare a backup of cloud sql instance

```bash
❯ gcloud sql backups list --project <project_name> --instance sample-instance-v1-for-backup

ID             WINDOW_START_TIME              ERROR  STATUS      INSTANCE
1654919319590  2022-06-11T03:48:39.590+00:00  -      SUCCESSFUL  sample-instance-v1-for-backup
```

2. Setup infra
```bash
cd infra
terraform apply -var project="<gcp_project_id>"
```

3. Run a job of cloud scheduler (`sample-scheduler-job`)

4. Confirm the result

>> ::info::
>> You have to check the instance name that is created with random suffix by using cloud logging.

```
❯ gcloud sql backups list --project <project_name> --instance sample-instance-v1-1654996390
ID             WINDOW_START_TIME              ERROR  STATUS      INSTANCE
1654996758862  2022-06-12T01:19:18.862+00:00  -      SUCCESSFUL  sample-instance-v1-1654996390
```
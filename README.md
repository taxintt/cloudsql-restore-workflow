
```bash
❯ gcloud sql backups list --project <project_name> --instance sample-instance-v1-for-backup

ID             WINDOW_START_TIME              ERROR  STATUS      INSTANCE
1654919319590  2022-06-11T03:48:39.590+00:00  -      SUCCESSFUL  sample-instance-v1-for-backup
```

```
❯ gcloud sql backups list --project <project_name> --instance sample-instance-v1-1654996390
ID             WINDOW_START_TIME              ERROR  STATUS      INSTANCE
1654996758862  2022-06-12T01:19:18.862+00:00  -      SUCCESSFUL  sample-instance-v1-1654996390
```
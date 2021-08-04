# trino-on-k8s
Setup for running TrinoDB (formerly Prestosql) with Hive Metastore on Kubernetes as introduced in [this blog post](https://medium.com/@joshua_robinson/presto-powered-s3-data-warehouse-on-kubernetes-aea89d2f40e8).

See [previous blog post](https://medium.com/@joshua_robinson/presto-on-flashblade-s3-486ecb449574)
for more information about running Trino/Presto on FlashBlade.

# How to Use

1. Build Docker image for Hive Metastore

2. Deploy Hive Metastore: MariaDB (pvc and deployment), init-schemas, Metastore

3. Deploy Trino services (coordinator, workers, and cli)

4. Deploy Redash.

Assumptions: working Kubernetes deployment and S3 object store (e.g., FlashBlade).

Things you may need to modify:
* Docker repository name ($REPONAME) in build_image scripts and yaml files.
* DataVIP and access keys for FlashBlade (fs.s3a.endpoint and hive.s3a.endpoint)
* StorageClass for the MariaDB volume.
* Memory settings and worker counts.

# Trino Coordinator/Workers/CLI

Leverages the official [Trino Docker image](https://github.com/trinodb/docker-images).

Yaml for Trino Coordinator/Workers

Trino CLI pod

Create SQL shell as:
```kubectl exec -it pod/trino-cli -- trino --server trino:8080 --catalog hive --schema default```

Create Nginx configmap from file
```
mk create configmap nginx-config --from-file=nginx/config/nginx.conf
mk delete configmap nginx-config
```

Query
```
curl -vvv -X POST -u admin: -H "X-Trino-User=admin" nginx-trino:5566/v1/statement -d"SELECT '1' AS CNT"
```

# Elasticsearch Index Problem

[Can't get text on a START_OBJECT](https://stackoverflow.com/questions/41873672/updating-a-field-with-a-nested-array-in-elastic-search)

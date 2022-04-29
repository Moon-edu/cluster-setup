# Install Hadoop cluster with Ambari

## Required Nodes
Server A
- Install ambari server, agent
- Ambari Server, Primary Namenode, Resource Manager

Server B
- Install ambari agent
- Secondary Namenode, Postgres DB, Hive metastore, History Server

Server C
- Install ambari agent
- Hive Server
- Data node

Server D
- Install ambari agent
- Data node

Server E
- Install ambari agent
- Data node

Server F
- Install ambari agent
- Data node

Server G
- Install ambari agent
- Data node

Server H
- Install ambari agent
- Data node

Server I
- Install ambari agent
- Data node

Server J
- Install ambari agent
- Airflow, Grafana

## Install dependencies to all nodes
```bash
$ exec install-common.sh ambari123
```

## Install ambari server
```bash
$ exec install-ambari.sh server
```

## Install ambari agent
```bash
$ exec install-ambari.sh agent
```

## List to download if download by script is slow
- [Ambari binary](https://www.makeopensourcegreatagain.com/rpms/ambari-2.7.4.0/ambari/)(Download Server/Agent)


There has been a decision to not implement High Availability (HA) leadership or clustering for PayGate. This is done for a few reasons:

1. The work involved in proper HA leadership, gossip, and coordination is estimated to be too much currently.
1. PayGate can be configured to collect `Transfer` objects for set of ABA routing numbers.
1. Pulling transfers from the DB in batches to process is easier checkpoint than pushing messages around PayGate instances with stashing/replay during downtime.

Given these assumptions we've chosen to focus PayGate's vertical scaling (add CPUs and memory) instead of clustering. Currently two instances of PayGate might be able to build and upload files for the same destination ABA routing numbers, but that setup is not officially supported. That coordination would rely on the database across multiple readers.

PayGate has two flavors of dependencies "CPU based in-memory" and "REST and database" servers along with a database (SQLite or MySQL).

### Dependencies

#### CPU based, in-memory

Services: [ACH](http://github.com/moov-io/ach), [Fed](http://github.com/moov-io/fed), and [Watchman](http://github.com/moov-io/watchman)

These services have a basic model of storing data structures in-memory and offering HTTP endpoints of the data. ACH's data comes from HTTP requests for creation and modification where Fed and Watchman parse data files (Watchman downloads them from an external source). Watchman does store data and tasks in a database, but the database is not used for searching the data files.

It is known that ACH offers no persistent storage for multi-instance replication or recovery after shutdown.

#### REST and database

Services: [Accounts](http://github.com/moov-io/accounts) and [Customers](http://github.com/moov-io/customers)

Both services store all data in a database which is used on each HTTP request. They are populated from clients creating and modifying records. Both applications can have multiple instances ran connected to the same database.

#### Database

Given PayGate is ran connected to a MySQL, <s>PostgreSQL</s> ([TODO #387](https://github.com/moov-io/paygate/issues/387)), or <s>Microsoft SQL</s> ([TODO #377](https://github.com/moov-io/paygate/issues/377)) database that database will need to be deployed in an acceptable manor for replication, failure recovery, and backups.

SQLite replication (possibly implemented via [rqlite](https://github.com/rqlite/rqlite)) has not been tested, but looks promising.

### Hot Routing Numbers

One usecase of PayGate is to have "hot" routing numbers in which a large fraction of Transfers are destined to a specific ABA routing number. If one ABA is a large fraction of overall Transfers it poses a risk to dominate the file merging and uploads. While not an issue that should require code changes to solve the batch size and interval intervals should be adjusted for the requirements.

This scenario can be solved by deploying a PayGate instance for a specific routing number. To configure this [run a PayGate instance for each routing number](https://docs.moov.io/paygate/ach/#uploads-of-merged-ach-files) and optionally one instance which gathers the other transfers for upload. (Note: See [PayGate issue #407](https://github.com/moov-io/paygate/issues/407) for discussion on this implementation.)

!!! warning "Operators"
    Track the `missing_ach_file_upload_configs{routing_number="..."}` Prometheus alert for missing configs.

### Clustering concerns

If we implemented HA for multiple PayGate instances we would likely elect a leader for each routing number configured. This would mean elections and heartbeats for each routing number along with stashing knowledge in PayGate when a leader was unresponsive. The implementation details of that seem a lot higher than adding CPU's at the time of writing.

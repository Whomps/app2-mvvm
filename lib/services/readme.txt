The purpose of these /services/ files is to implement Dependency Injection.

DI allows you to switch out where the data comes from easily. You may see these entities called "datasources".
DataSources/Data Sources/datasources are usually defined by an interface or protocol.
In this revision, the protocol is MenuManagerProtocol, and it is implemented by MenuManagerAPI and MenuManagerLocal.

You don't necessarily need multiple data sources or targets to benefit from this strategy.
These services can instead just give you a way to make global or session-based state without messiness within the widget tree.


IMPORTANT:
The use of a local and api variant is not a hard rule. I commonly have singular variants. Common types I use:
-> DataSource-driven variants: local, api, repo/repository. Local is local data and logic. API and repo are API driven state.
-> Client: I like using this to specify a interface with some network protocol. NetworkClient, BluetoothClient, GRPCClient, ...
-> Coordinator: I use this to specify a singleton that manages states but does not ever access off-device information. KeyboardCoordinator, ...
-> Zero: I use this to specify a datasource where (almost) everything is just hardcoded. My own name, so it won't be in internet guides.

The naming isn't as important as your team understanding what it means.
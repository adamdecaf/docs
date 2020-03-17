[Moov Fed](/fed/) is used by PayGate to validate ACH routing numbers for created `Depository` objects. The routing number on a `Depository` must be found within the FedACH file on creation.

### Routing Number Lookup

Moov FED indexes the FedACH file on startup to offer lookup based on ABA routing numbers.

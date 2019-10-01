
## What is OFAC

The Office of Foreign Assets Control administers and enforces economic sanctions programs primarily against countries and groups of individuals, such as terrorists and narcotics traffickers. The sanctions can be either comprehensive or selective, using the blocking of assets and trade restrictions to accomplish foreign policy and national security goals. [09-10-02]

[source: U.S. DEPARTMENT OF THE TREASURY](https://www.treasury.gov/resource-center/faqs/Sanctions/Pages/faq_general.aspx#basic)

![](images/webui.png)

## Running Moov OFAC

You can download a [binary from GitHub](https://github.com/moov-io/ofac/releases) or a [Docker image](https://hub.docker.com/r/moov/ofac) for OFAC. Once downloaded you can start making requests against OFAC. The service will download the latest data on startup.

```
$ docker run -p 8084:8084 -p 9094:9094 -it moov/ofac:v0.11.0
ts=2019-10-01T20:35:31.301254Z caller=main.go:54 startup="Starting ofac server version v0.11.0"
ts=2019-10-01T20:35:31.301338Z caller=database.go:18 database="looking for  database provider"
ts=2019-10-01T20:35:31.301376Z caller=sqlite.go:119 main="sqlite version 3.25.2"
ts=2019-10-01T20:35:31.302651Z caller=download.go:80 download="Starting refresh of OFAC and DPL data"
ts=2019-10-01T20:35:31.302651Z caller=main.go:118 admin="listening on :9094"
ts=2019-10-01T20:35:31.530729Z caller=download.go:132 download="Finished refresh of OFAC and BIS DPL data"
ts=2019-10-01T20:35:31.532927Z caller=main.go:142 main="OFAC data refreshed - Addresses=11696 AltNames=9682 SDNs=7379 DeniedPersons=547"
ts=2019-10-01T20:35:31.532962Z caller=main.go:218 main="Setting OFAC data refresh interval to 12h0m0s (default)"
ts=2019-10-01T20:35:31.533312Z caller=main.go:182 startup="binding to :8084 for HTTP server"

$ curl -s localhost:8084/search?name=...
{
  "SDNs": [
    {
      "entityID": "...",
      "sdnName": "...",
      "sdnType": "...",
      "program": "...",
      "title": "...",
      "callSign": "...",
      "vesselType": "...",
      "tonnage": "...",
      "grossRegisteredTonnage": "...",
      "vesselFlag": "...",
      "vesselOwner": "...",
      "remarks": "..."
    }
  ],
  "altNames": null,
  "addresses": null
}
```

An SDN (or entity) is an individual, group, or company which has or could do business with United States companies or individuals. US law requires checking OFAC data before transactions.

## Web Interface

Moov OFAC provides a web interface for easy browsing of the SDN and related data for mobile and desktop clients. Simply load the address of OFAC in a browser.

## Webhooks

OFAC supports registering a callback url (also called [webhook](https://en.wikipedia.org/wiki/Webhook)) for searches or a given entity ID. (API docs: [company](https://api.moov.io/#operation/addCompanyWatch) or [customers](https://api.moov.io/#operation/addCustomerWatch)) This allows services to monitor for changes to the OFAC data. There's an example [app that receives webhooks](https://github.com/moov-io/ofac/blob/master/examples/webhook/webhook.go) written in Go. OFAC sends either a [Company](https://godoc.org/github.com/moov-io/ofac/client#Company) or [Customer](https://godoc.org/github.com/moov-io/ofac/client#Customer) model in JSON to the webhook URL.

Webhook URLs MUST be secure (https://...) and an `Authorization` header is sent with an auth token provided when setting up the webhook. Callers should always verify this auth token matches what was originally provided.

## FAQ

[FAQ](https://www.treasury.gov/resource-center/faqs/Sanctions/Pages/ques_index.aspx)

[General Questions](https://www.treasury.gov/resource-center/faqs/Sanctions/Pages/faq_general.aspx)

[Sanctions Compliance](https://www.treasury.gov/resource-center/faqs/Sanctions/Pages/faq_compliance.aspx)

[Sanction List and Files](https://www.treasury.gov/resource-center/faqs/Sanctions/Pages/faq_lists.aspx)

[Iran Sanctions](https://www.treasury.gov/resource-center/faqs/Sanctions/Pages/faq_iran.aspx)

[Other Sanction Programs](https://www.treasury.gov/resource-center/faqs/Sanctions/Pages/faq_other.aspx)

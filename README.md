# fantastic-octo-parakeet

I needed a public location to store some XML data & transforms that I'm going to be using to test behaviour; so here it is.

Addresses & Phone numbers generated by the excellent [generatedata.com](https://generatedata.com) so if those addresses actually exist then it's entirely coincendental.

# XML operations

- invoice-sample.xml + schema_validation(invoice.xsd) -> pass
- invoice-sample.xml + xslt(invoice-emit-xml.xsl) -> invoice-output.xml
- invoice-output.xml + xml2json -> invoice-output.json
- invoice-sample.xml + xml2json -> invoice-sample.json

# JSON Operations

- invoice-sample.json + schema_validation(invoice-standalone.schema.json) -> pass
- `"[ $(cat invoice-sample.json) ]"` + schema_validation(invoice-array.schema.json) -> pass
- invoice-sample.json + jslt(invoice.jslt) -> invoice-output.json
  - Custom functions might give us the ability to 2decimal places for the prices; but because we've chosen effectively whole number pricing...
  - Note that this JSLT _also replicates_ the XSLT stylesheet behaviour of Fax numbers (because we can)
- invoice-sample.json + jolt(invoice-jolt.json) -> invoice-output.json
  - Drops the Fax number
  - Date formatting is "hard" in jolt
  - maths is hard in jolt, and the sundry use of temporary variables annoys me.



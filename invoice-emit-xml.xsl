<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:inv="invoice" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="invoice"
  exclude-result-prefixes="xs xsl inv" version="2.0">
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">

    <xsl:variable name="ext">
      <xsl:element name="inv:subtotals">
        <xsl:for-each select="/inv:invoice/inv:items/inv:item">
          <xsl:element name="inv:subtotal">
            <xsl:value-of select="inv:unitprice * inv:quantity"/>
          </xsl:element>
        </xsl:for-each>
      </xsl:element>
    </xsl:variable>

    <Invoice>
      <Date><xsl:value-of select="format-date(/invoice/invdate,'[D1] [MNn] [Y1]')"/></Date>
      <Number><xsl:value-of select="/invoice/invnumber"/></Number>
      <From>
        <Company>Acme Corporation</Company>
        <Address>551-3307 Odio St., Iligan Cagayan Valley 58528</Address>
      </From>
      <BillTo>
        <Name><xsl:value-of select="/invoice/customer/attn"/></Name>
        <Company><xsl:value-of select="/invoice/customer/name"/></Company>
        <Address><xsl:value-of select="/invoice/customer/street"/><xsl:text>, </xsl:text><xsl:value-of select="/invoice/customer/city"/><xsl:text>, </xsl:text>
         <xsl:value-of select="/invoice/customer/state"/><xsl:text> </xsl:text>
         <xsl:value-of select="/invoice/customer/zip"/>
        </Address>
        <Phone><xsl:value-of select="/invoice/customer/phone"/></Phone>
        <xsl:if test="/invoice/customer/fax != ''"><Fax><xsl:value-of select="/invoice/customer/fax"/></Fax>
        </xsl:if>
      </BillTo>
      <xsl:for-each select="/invoice/items/item">
      <InvoiceLine>
        <Date><xsl:value-of select="format-date(./date,'[D1] [MNn] [Y1]')"/></Date>
        <Description><xsl:value-of select="./description"/></Description>
        <Quantity><xsl:value-of select="quantity"/></Quantity>
        <UnitPrice><xsl:value-of select="format-number(unitprice,'$#.00')"/></UnitPrice>
        <Total><xsl:value-of select="format-number(sum(unitprice * quantity),'$#.00')"/></Total>
      </InvoiceLine>
      </xsl:for-each>
      <InvoiceTotal><xsl:value-of select="format-number(sum($ext/subtotals/subtotal),'$#.00')"/></InvoiceTotal>
    </Invoice>
  </xsl:template>
</xsl:stylesheet>

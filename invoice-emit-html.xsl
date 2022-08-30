<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:inv="invoice" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="invoice"
  exclude-result-prefixes="xs xsl inv" version="2.0">

  <xsl:output method="xhtml"/>

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

    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title>Invoice example</title>
      </head>
      <body style="width: 50%; margin-left: 5em; font-family: 'verdana, arial, sans">
        <br/>
        <br/>

        <p style="text-align: right;">
          <xsl:text>Invoice Date: </xsl:text>
          <span style="font-weight: bold;">
            <xsl:value-of select="format-date(/invoice/invdate,'[D1] [MNn] [Y1]')"/>
          </span>
          <br/>
          <xsl:text> Invoice Number: </xsl:text>
          <span style="font-weight: bold;">
            <xsl:value-of select="/invoice/invnumber"/>
          </span>
        </p>
        <br clear="all"/>
        <p>
          <span style="font-size: larger; font-style: bold; ">Acme Corporation</span>
          <br/> 551-3307 Odio St.<br/>Iligan, Cagayan Valley 58528</p>
        <hr/>
        <p>Bill to:<br/>
          <xsl:value-of select="/invoice/customer/name"/><br/>
          <xsl:value-of select="/invoice/customer/street"/><br/>
          <xsl:value-of select="/invoice/customer/city"/><xsl:text>, </xsl:text>
          <xsl:value-of select="/invoice/customer/state"/><xsl:text> </xsl:text>
          <xsl:value-of select="/invoice/customer/zip"/><br/>
          <xsl:value-of select="/invoice/customer/phone"/><br/>
          <xsl:if test="/invoice/customer/fax != ''"> FAX: <xsl:value-of
              select="/invoice/customer/fax"/><br/>
          </xsl:if> ATTN: <xsl:value-of select="/invoice/customer/attn"/>
        </p>

        <table width="100%" align="center" border="1">
          <tr>
            <th>Date</th>
            <th>Description</th>
            <th>Quantity</th>
            <th>Unit<br/>Price</th>
            <th>Total</th>
          </tr>
          <xsl:for-each select="/invoice/items/item">
            <tr>
              <td>
                <xsl:value-of select="format-date(./date,'[D1] [MNn] [Y1]')"/>
              </td>
              <td>
                <xsl:value-of select="./description"/>
              </td>
              <td>
                <xsl:value-of select="quantity"/>
              </td>
              <td align="right"
                style="font-family: courier, fixed, monospace; font-weight: bold;">
                <xsl:value-of select="format-number(unitprice,'$#.00')"/>
              </td>
              <td align="right"
                style="font-family: courier, fixed, monospace; font-weight: bold;">
                <xsl:value-of select="format-number(sum(unitprice * quantity),'$#.00')"/>
              </td>
            </tr>
          </xsl:for-each>
          <tr style="font-weight: bold;">
            <td colspan="4" align="right">Total</td>
            <td align="right" style="font-family: courier, fixed, monospace; ">
              <xsl:value-of select="format-number(sum($ext/subtotals/subtotal),'$#.00')"/>
            </td>
          </tr>
        </table>

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:jca="http://platform.integration.oracle/blocks/adapter/fw/metadata">
  <!-- Update JPR 
  @Author: M. van den Akker, Darwin-IT Professionals, 2018-09-12
  Based on: https://stackoverflow.com/questions/5876382/using-xslt-to-copy-all-nodes-in-xml-with-support-for-special-cases#5877772
  -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- Check if adapter attribute = 'AQ Adapter' ==> should be 'aq' -->
  <xsl:template match="jca:adapter-config/@adapter">
    <xsl:choose>
      <xsl:when test=".='AQ Adapter'">
        <xsl:attribute name='adapter'>aq</xsl:attribute>
      </xsl:when>
      <xsl:when test=".='DB Adapter'">
        <xsl:attribute name='adapter'>db</xsl:attribute>
      </xsl:when>
      <xsl:when test=".='APPS Adapter'">
        <xsl:attribute name='adapter'>apps</xsl:attribute>
      </xsl:when>
      <xsl:when test=".='JMS Adapter'">
        <xsl:attribute name='adapter'>jms</xsl:attribute>
      </xsl:when>
      <xsl:when test=".='FTP Adapter'">
        <xsl:attribute name='adapter'>ftp</xsl:attribute>
      </xsl:when>
      <xsl:when test=".='File Adapter'">
        <xsl:attribute name='adapter'>file</xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>


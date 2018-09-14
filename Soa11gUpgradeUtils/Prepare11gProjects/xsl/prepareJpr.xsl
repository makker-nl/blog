<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!-- Update JPR 
  @Author: M. van den Akker, Darwin-IT Professionals, 2018-09-12
  Based on: https://stackoverflow.com/questions/5876382/using-xslt-to-copy-all-nodes-in-xml-with-support-for-special-cases#5877772
  -->
  <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
  <!-- Check Existence of SOA technology, because of Invalid composite file exceptions. MOS DocId 233742.1-->
  <xsl:template match="hash[@n='oracle.ide.model.TechnologyScopeConfiguration']/list[@n='technologyScope']">  
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
            <!--If SOA doesn't exist then add it -->
            <xsl:choose>
        <xsl:when test="count(./string[@v='SOA'])=0">
            <xsl:comment>Add SOA technology</xsl:comment> 
            <string v="SOA"/>
            </xsl:when>
        <xsl:otherwise><xsl:comment>SOA technology already present </xsl:comment> 
            </xsl:otherwise>
      </xsl:choose>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>


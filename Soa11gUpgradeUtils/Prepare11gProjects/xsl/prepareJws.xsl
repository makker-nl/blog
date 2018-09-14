<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!-- Empty JWS 
  @Author: M. van den Akker, Darwin-IT Professionals, 2018-09-13
  Based on: https://stackoverflow.com/questions/5876382/using-xslt-to-copy-all-nodes-in-xml-with-support-for-special-cases#5877772
  -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- Clear list of children -->
  <xsl:template match="list[@n='listOfChildren']">  
    <list n="listOfChildren">
      <xsl:text>
      </xsl:text>
      <xsl:comment>Clear List of Children</xsl:comment> 
      <xsl:text>
   </xsl:text>
    </list>
  </xsl:template>
</xsl:stylesheet>


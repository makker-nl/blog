<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="projectFile"/>
  <!-- Add project file to  JWS 
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
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
      <hash>
        <url n="URL" path="{$projectFile}"/>
      </hash>
      <xsl:text>
      </xsl:text>
    </xsl:copy>
  </xsl:template>
  <!-- index-of: find position of search within string
2010-08-31, by Martien van den Akker -->
  <xsl:template name="index-of-ci">
    <xsl:param name="string"/>
    <xsl:param name="search"/>
    <xsl:param name="startPos"/>
    <xsl:variable name="searchLwr" select="xp20:lower-case($search)"/>
    <xsl:variable name="work">
      <xsl:choose>
        <xsl:when test="string-length($startPos)>0">
          <xsl:value-of select="substring($string,$startPos)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$string"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="stringLwr" select="xp20:lower-case($work)"/>
    <xsl:variable name="result">
      <xsl:choose>
        <xsl:when test="contains($stringLwr,$searchLwr)">
          <xsl:variable name="stringBefore">
            <xsl:value-of select="substring-before($stringLwr,$searchLwr)"/>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="string-length($startPos)>0">
              <xsl:value-of select="$startPos +string-length($stringBefore)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="1 + string-length($stringBefore)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>-1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:copy-of select="$result"/>
  </xsl:template>
</xsl:stylesheet>


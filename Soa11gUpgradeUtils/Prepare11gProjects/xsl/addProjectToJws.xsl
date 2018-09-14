<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="projectFile"/>
  <xsl:variable name="fileSeparator">\</xsl:variable>
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
    <xsl:variable name="filepath" select="$projectFile"/>
    <xsl:variable name="filename">
      <xsl:call-template name="extractFilename">
          <xsl:with-param name="filePath" select="$filepath"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="subFoldername">
      <xsl:call-template name="extractSubfolder">
          <xsl:with-param name="filePath" select="$filepath"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="relProjectfile" select="concat($subFoldername,'/',$filename)"/>    
      <xsl:apply-templates select="@*|node()"/>
      <hash>
        <url n="URL" path="{$relProjectfile}"/>
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

    <xsl:variable name="result">
      <xsl:choose>
        <xsl:when test="contains($work,$search)">
          <xsl:variable name="stringBefore">
            <xsl:value-of select="substring-before($work,$search)"/>
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
  <!-- index-of: find position of search within string
2018-09-13, by Martien van den Akker -->
  <xsl:template name="last-index-of-ci">
    <xsl:param name="string"/>
    <xsl:param name="search"/>
    <xsl:param name="startPos"/>
    <xsl:variable name="firstOccurrence">
      <xsl:call-template name="index-of-ci">
        <xsl:with-param name="string" select="$string"/>
        <xsl:with-param name="search" select="$search"/>
        <xsl:with-param name="startPos" select="$startPos"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$firstOccurrence=-1">
        <xsl:value-of select="-1"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="secondOccurrence">
          <xsl:call-template name="last-index-of-ci">
            <xsl:with-param name="string" select="$string"/>
            <xsl:with-param name="search" select="$search"/>
            <xsl:with-param name="startPos" select="$firstOccurrence+1"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$secondOccurrence>-1">
            <xsl:value-of select="$secondOccurrence"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$firstOccurrence"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- extractFilename: extract the filename from the filePath
2018-09-13, by Martien van den Akker -->
  <xsl:template name="extractFilename">
    <xsl:param name="filePath"/>
    <xsl:variable name="sepPos">
      <xsl:call-template name="last-index-of-ci">
        <xsl:with-param name="string" select="$filePath"/>
        <xsl:with-param name="search" select="$fileSeparator"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="substring($filePath,number($sepPos)+1)"/>
  </xsl:template>
  <!-- extractSubfolder: extract the last subfolder  from the filePath
2018-09-13, by Martien van den Akker -->
  <xsl:template name="extractSubfolder">
    <xsl:param name="filePath"/>
    <xsl:variable name="sepPos">
      <xsl:call-template name="last-index-of-ci">
        <xsl:with-param name="string" select="$filePath"/>
        <xsl:with-param name="search" select="$fileSeparator"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="folderPath" select="substring($filePath,1, number($sepPos)-1)"/>
    <xsl:variable name="sepPos2">
      <xsl:call-template name="last-index-of-ci">
        <xsl:with-param name="string" select="$folderPath"/>
        <xsl:with-param name="search" select="$fileSeparator"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="subFolder" select="substring($folderPath,number($sepPos2)+1)"/>
    <xsl:value-of select="$subFolder"/>
  </xsl:template>
</xsl:stylesheet>


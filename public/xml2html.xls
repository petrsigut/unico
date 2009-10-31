<?xml version="1.0"?>
<html xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xsl:version="1.0">

  <head></head>
  <body>

  <xsl:for-each select="document/*">
      <xsl:choose>
        <xsl:when test="name()='label'">
          <p><xsl:value-of select="."/></p> 
        </xsl:when>
        <xsl:when test="name()='image'">
          <xsl:element name="img">
            <xsl:attribute name="src">
              <xsl:value-of select="."/>
            </xsl:attribute>
          </xsl:element>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>



  
</body>
</html>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    <xsl:output indent="yes"/>
    
    <xsl:template match='/'>
        <thesaurus>
            <name>NASA/Global Change Master Directory Earth Science Keywords Version 5.3.8</name>
            <keywords>
                <xsl:for-each select="GCMD_KEYWORDS/TOPIC">
                    <xsl:variable name="topic" select="@value"/>
                    
                    <xsl:for-each select="TERM">
                        <xsl:variable name="term" select="@value"/>
                        
                        <xsl:for-each select="VARIABLE">
                            <xsl:variable name="variable" select="."/>
                            
                            <keyword><xsl:value-of select="concat($topic,' | ',$term,' | ',$variable)"/></keyword>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </keywords>
        </thesaurus>
    </xsl:template>
</xsl:stylesheet>
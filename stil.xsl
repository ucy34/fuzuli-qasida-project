<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <style>
                    body { font-family: 'Palatino', serif; background-color: #0a192f; color: #e6f1ff; margin: 0; padding: 20px; }
                    .container { max-width: 1100px; margin: auto; }
                    .header { text-align: center; padding: 40px; border-bottom: 2px solid #64ffda; margin-bottom: 30px; }
                    h1 { color: #64ffda; }
                    
                    .page-block { display: flex; gap: 30px; background: #112240; margin-bottom: 40px; padding: 25px; border-radius: 15px; border: 1px solid #233554; }
                    .img-side { flex: 1; text-align: center; }
                    .img-side img { width: 100%; max-width: 450px; border-radius: 10px; border: 1px solid #64ffda; }
                    
                    .text-side { flex: 1.2; }
                    .couplet { margin-bottom: 35px; padding-bottom: 15px; border-bottom: 1px solid #1d2d50; }
                    .ota { font-size: 1.3em; color: #ccd6f6; line-height: 1.6; margin-bottom: 15px; }
                    
                    /* Çeviri Alanı: Artık her zaman görünür ve belirgin */
                    .eng { 
                        display: block !important; 
                        color: #8892b0; 
                        font-style: italic; 
                        font-size: 1.1em;
                        background: rgba(100, 255, 218, 0.05);
                        padding: 10px;
                        border-left: 3px solid #64ffda;
                    }
                    .translation-label { color: #64ffda; font-weight: bold; font-size: 0.8em; text-transform: uppercase; display: block; margin-bottom: 5px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>Fuzûlî: Digital Edition</h1>
                        <p>Scientific Analysis and Translation</p>
                    </div>

                    <xsl:for-each select="//tei:pb">
                        <div class="page-block">
                            <div class="img-side">
                                <img src="{@facs}" alt="Manuscript Page"/>
                                <p style="color:#64ffda; margin-top:10px;">Folio: <xsl:value-of select="@n"/></p>
                            </div>
                            <div class="text-side">
                                <xsl:for-each select="following-sibling::tei:div[1]/tei:lg">
                                    <div class="couplet">
                                        <div class="ota">
                                            <xsl:for-each select="tei:l">
                                                <span style="display:block;"><xsl:value-of select="."/></span>
                                            </xsl:for-each>
                                        </div>
                                        <div class="eng">
                                            <span class="translation-label">English Translation:</span>
                                            <xsl:choose>
                                                <xsl:when test="tei:quote">
                                                    <xsl:value-of select="tei:quote"/>
                                                </xsl:when>
                                                <xsl:when test="tei:note">
                                                    <xsl:value-of select="tei:note"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <em>Çeviri verisi bulunamadı (XML etiketini kontrol edin).</em>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                    </div>
                                </xsl:for-each>
                            </div>
                        </div>
                    </xsl:for-each>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

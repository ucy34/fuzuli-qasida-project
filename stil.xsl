<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Fuzûlî Digital Edition</title>
                <style>
                    body { font-family: 'Georgia', serif; background-color: #f4f1ea; padding: 20px; line-height: 1.6; margin: 0; }
                    .header-section { text-align: center; border-bottom: 3px double #333; margin-bottom: 40px; padding: 20px; }
                    
                    /* Navigasyon Alanı */
                    .nav-controls {
                        position: fixed; top: 20px; right: 20px; z-index: 1000;
                        display: flex; flex-direction: column; gap: 10px;
                    }

                    .control-box {
                        background: #800; color: white !important; padding: 12px 20px; border-radius: 30px;
                        box-shadow: 0 4px 10px rgba(0,0,0,0.3); font-weight: bold; text-align: center;
                        text-decoration: none; cursor: pointer; font-size: 14px; border: none;
                    }
                    .control-box:hover { background: #a00; }

                    /* Metin Alanları */
                    .ota-text { display: block; font-style: italic; font-size: 1.2em; color: #2c3e50; margin-bottom: 10px; }
                    
                    /* Çeviri Alanı: Artık varsayılan olarak GÖRÜNÜR yaptım ki hata olmasın */
                    .en-text { 
                        display: block; 
                        font-size: 1.1em; 
                        color: #666; 
                        border-left: 4px solid #800; 
                        padding-left: 15px; 
                        margin-top: 10px;
                        background: #fffafa;
                    }

                    /* Sayfa Yapısı */
                    .page-container { display: flex; flex-direction: row; background: white; margin-bottom: 60px; padding: 20px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); max-width: 1100px; margin-left: auto; margin-right: auto; }
                    .manuscript-side { flex: 1; padding: 10px; border-right: 1px solid #eee; text-align: center; }
                    .manuscript-side img { width: 100%; height: auto; border: 1px solid #ccc; border-radius: 4px; }
                    .text-side { flex: 1; padding: 20px; }
                    .couplet { margin-bottom: 35px; border-bottom: 1px solid #eee; padding-bottom: 15px; }
                    .folio-label { font-weight: bold; color: #800; display: block; margin-top: 15px; font-size: 1.1em; }

                    /* Mobil Uyumluluk */
                    @media (max-width: 800px) {
                        .page-container { flex-direction: column; }
                        .manuscript-side { border-right: none; border-bottom: 1px solid #eee; }
                    }
                </style>
            </head>
            <body>
                <div class="nav-controls">
                    <a href="index.xml" class="control-box">Refresh Page</a>
                </div>

                <div class="main-content">
                    <div class="header-section">
                        <h1>Kasîde</h1>
                        <h3>Fuzûlî</h3>
                        <p>Digital Edition by Mehmet Eray Avcı &amp; Uğur Can Yıldız</p>
                    </div>

                    <xsl:for-each select="//tei:pb">
                        <div class="page-container">
                            <div class="manuscript-side">
                                <img src="{@facs}" alt="Manuscript Page"/>
                                <span class="folio-label">Folio: <xsl:value-of select="@n"/></span>
                            </div>
                            <div class="text-side">
                                <xsl:for-each select="following-sibling::tei:div[1]/tei:lg">
                                    <div class="couplet">
                                        <div class="ota-text">
                                            <xsl:for-each select="tei:l">
                                                <span style="display:block;"><xsl:value-of select="."/></span>
                                            </xsl:for-each>
                                        </div>
                                        <div class="en-text">
                                            <strong>Translation: </strong>
                                            <xsl:value-of select="tei:quote"/>
                                            <xsl:value-of select="tei:note"/> </div>
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

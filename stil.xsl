<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Fuzûlî Digital Edition</title>
                <style>
                    body { font-family: 'Palatino', serif; background-color: #0a192f; color: #e6f1ff; margin: 0; padding: 20px; }
                    .container { max-width: 1000px; margin: auto; }
                    .header { text-align: center; padding: 40px; border-bottom: 2px solid #64ffda; margin-bottom: 40px; }
                    
                    /* DİL DEĞİŞTİRME BUTONU */
                    #langToggle { display: none; }
                    .toggle-btn {
                        position: fixed; top: 20px; right: 20px; z-index: 1000;
                        background: #64ffda; color: #0a192f; padding: 12px 25px;
                        border-radius: 30px; cursor: pointer; font-weight: bold;
                        box-shadow: 0 5px 15px rgba(0,0,0,0.3);
                    }

                    /* VARSAYILAN DURUM: Osmanlıca Açık, İngilizce Gizli */
                    .translation { display: none; color: #64ffda; font-size: 1.2em; font-style: italic; line-height: 1.7; }
                    .ota { display: block; font-size: 1.3em; color: #ccd6f6; line-height: 1.7; }

                    /* BUTONA BASILINCA: Osmanlıca Gizle, İngilizce Göster */
                    #langToggle:checked ~ .container .ota { display: none; }
                    #langToggle:checked ~ .container .translation { display: block; }
                    
                    /* Buton Metni Değişimi (Opsiyonel görsel geri bildirim) */
                    #langToggle:checked ~ .toggle-btn { background: #ccd6f6; }
                    #langToggle:checked ~ .toggle-btn:after { content: " (Switch to TR)"; }
                    #langToggle:not(:checked) ~ .toggle-btn:after { content: " (Switch to EN)"; }

                    /* Sayfa Yapısı */
                    .page-wrapper { display: flex; gap: 30px; background: #112240; margin-bottom: 50px; padding: 25px; border-radius: 15px; border: 1px solid #233554; align-items: flex-start; }
                    .facsimile { flex: 1; text-align: center; }
                    .facsimile img { width: 100%; border-radius: 8px; border: 1px solid #64ffda; }
                    .transcription { flex: 1.2; padding-top: 20px; }
                    .couplet { margin-bottom: 30px; min-height: 100px; }
                    
                    .analysis-footer { background: #112240; padding: 30px; border-radius: 15px; border-top: 4px solid #64ffda; margin-top: 50px; }
                    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
                    th, td { padding: 12px; border: 1px solid #233554; text-align: left; }
                    th { color: #64ffda; background: #1d2d50; }
                </style>
            </head>
            <body>
                <input type="checkbox" id="langToggle" />
                <label for="langToggle" class="toggle-btn">🌐 Language</label>

                <div class="container">
                    <div class="header">
                        <h1>Fuzûlî: Bahar Kasîdesi</h1>
                        <p>Digital TEI Edition | Linguistic Variant Analysis</p>
                    </div>

                    <xsl:for-each select="//tei:pb">
                        <div class="page-wrapper">
                            <div class="facsimile">
                                <img src="{@facs}" alt="Manuscript Page"/>
                                <p style="color:#64ffda; font-weight:bold; margin-top:15px;">Varak: <xsl:value-of select="@n"/></p>
                            </div>
                            <div class="transcription">
                                <xsl:for-each select="following-sibling::tei:div[1]/tei:lg">
                                    <div class="couplet">
                                        <div class="ota">
                                            <xsl:for-each select="tei:l">
                                                <span style="display:block;"><xsl:value-of select="."/></span>
                                            </xsl:for-each>
                                        </div>
                                        <div class="translation">
                                            <xsl:value-of select="tei:note[@type='translation']"/>
                                        </div>
                                    </div>
                                </xsl:for-each>
                            </div>
                        </div>
                    </xsl:for-each>

                    <div class="analysis-footer">
                        <h2 style="color:#64ffda;">📊 Python NLTK Analysis Results</h2>
                        <table>
                            <tr><th>Keyword</th><th>Frequency</th><th>Contextual Value</th></tr>
                            <tr><td>Su (Water)</td><td>15</td><td>Central Motif / Purity</td></tr>
                            <tr><td>Gül (Rose)</td><td>14</td><td>Prophetic Symbolism</td></tr>
                            <tr><td>Bahār (Spring)</td><td>11</td><td>Divine Manifestation</td></tr>
                        </table>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

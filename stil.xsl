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
                    
                    /* Toggle Switch ve About Buton Alanı */
                    .nav-controls {
                        position: fixed; top: 20px; right: 20px; z-index: 1000;
                        display: flex; flex-direction: column; gap: 10px;
                    }

                    .control-box {
                        background: #800; color: white; padding: 12px 20px; border-radius: 30px;
                        box-shadow: 0 4px 10px rgba(0,0,0,0.3); font-weight: bold; text-align: center;
                        text-decoration: none; cursor: pointer; font-size: 14px;
                    }
                    .control-box:hover { background: #a00; }

                    /* Gizli Checkbox Mantığı (Dil Değişimi için) */
                    #langToggle { display: none; }
                    .ota-text { display: block; font-style: italic; font-size: 1.2em; color: #2c3e50; }
                    .en-text { display: none; font-size: 1.1em; color: #444; border-left: 4px solid #800; padding-left: 15px; }

                    #langToggle:checked ~ .main-content .ota-text { display: none; }
                    #langToggle:checked ~ .main-content .en-text { display: block; }

                    /* ABOUT MODAL (CSS Only) */
                    #aboutModal {
                        position: fixed; top: 0; left: 0; width: 100%; height: 100%;
                        background: rgba(0,0,0,0.8); display: none; z-index: 2000;
                        justify-content: center; align-items: center;
                    }
                    #aboutModal:target { display: flex; } /* Linke tıklandığında görünür olur */

                    .modal-content {
                        background: white; padding: 40px; border-radius: 10px;
                        max-width: 800px; max-height: 80vh; overflow-y: auto; position: relative;
                        box-shadow: 0 10px 30px rgba(0,0,0,0.5);
                    }
                    .close-btn {
                        position: absolute; top: 15px; right: 20px;
                        font-size: 30px; text-decoration: none; color: #333; font-weight: bold;
                    }
                    .modal-content h2 { color: #800; border-bottom: 2px solid #800; padding-bottom: 10px; }
                    .faq-item { margin-top: 20px; background: #f9f9f9; padding: 15px; border-radius: 5px; }
                    .faq-q { font-weight: bold; color: #800; display: block; margin-bottom: 5px; }

                    /* Sayfa Yapısı */
                    .page-container { display: flex; flex-direction: row; background: white; margin-bottom: 60px; padding: 20px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); max-width: 1200px; margin-left: auto; margin-right: auto; }
                    .manuscript-side { flex: 1; padding: 10px; border-right: 1px solid #eee; text-align: center; }
                    .manuscript-side img { width: 100%; max-width: 500px; border: 1px solid #ccc; }
                    .text-side { flex: 1; padding: 20px; }
                    .couplet { margin-bottom: 25px; }
                    .folio-label { font-weight: bold; color: #800; display: block; margin-top: 15px; }
                </style>
            </head>
            <body>
                <input type="checkbox" id="langToggle" />
                
                <div class="nav-controls">
                    <label for="langToggle" class="control-box">Show English Translation</label>
                    <a href="#aboutModal" class="control-box">About This Project</a>
                </div>

                <div id="aboutModal">
                    <div class="modal-content">
                        <a href="#" class="close-btn">×</a>
                        <h2>About This Project</h2>
                        <p>This website was designed by two FU Berlin ISME Students, namely <strong>Mehmet Eray Avcı</strong> and <strong>Uğur Can Yıldız</strong>. It was developed under the final requirement of Dr. Christian Casey's course "Manuscripts and Digital Humanities."</p>
                        <p>In this website, one can find three pages from "Külliyat-ı Divan-ı Fuzuli", published in Ottoman Turkish in 1890s, while being originally written in 16th century. The access to the manuscript is via TBMM (Turkish National Grand Assembly) Archives, which can be found through this link: <a href="https://acikerisim.tbmm.gov.tr/items/a0d3a7c5-e73e-4d8e-a36a-5b05072d3d49" target="_blank">TBMM Open Access</a>.</p>
                        
                        <h2>FAQ</h2>
                        <div class="faq-item">
                            <span class="faq-q">1. What is Divan Literature?</span>
                            <p>Divan literature is the classical tradition of Ottoman poetry and prose that flourished between the 13th and 19th centuries, heavily shaped by Islamic culture and Persian and Arabic literary models.</p>
                        </div>
                        <div class="faq-item">
                            <span class="faq-q">2. What is a Kaside?</span>
                            <p>A kaside is a long, formal lyric poem, typically ranging from 33 to 99 couplets. The specific poem we translated functions as both a bahâriye and a tevhid, where the poet uses themes of cosmology, Islamic law (fiqh), and logic to illustrate that the harmony found in nature is undeniable proof of a single, omnipotent Creator.</p>
                        </div>
                        <div class="faq-item">
                            <span class="faq-q">3. Who is Fuzuli?</span>
                            <p>Fuzuli was a 16th-century poet and one of the greatest masters of the Divan tradition, renowned for his profound emotional depth and masters of divine love.</p>
                        </div>
                    </div>
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
                                            <xsl:value-of select="tei:quote"/>
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


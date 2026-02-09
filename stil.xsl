<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Fuzûlî Digital Edition</title>
                <style>
                    /* TEMEL RENK DEĞİŞKENLERİ */
                    :root {
                        --bg-main: #f4f1ea;
                        --bg-card: #ffffff;
                        --text-primary: #2c3e50;
                        --accent: #800000;
                        --border: #ccc;
                        --shadow: rgba(0,0,0,0.1);
                        --note-bg: #f9f9f9;
                        --note-border: #3498db;
                    }

                    /* DARK MODE DEĞİŞKENLERİ */
                    #darkToggle:checked ~ .site-wrapper {
                        --bg-main: #121212;
                        --bg-card: #1e1e1e;
                        --text-primary: #e0e0e0;
                        --accent: #ff4d4d;
                        --border: #333;
                        --shadow: rgba(0,0,0,0.5);
                        --note-bg: #252525;
                        --note-border: #ff4d4d;
                    }

                    body { 
                        margin: 0; padding: 0; font-family: 'Georgia', serif; 
                        background-color: var(--bg-main); transition: 0.3s;
                    }

                    .site-wrapper { min-height: 100vh; padding: 20px; color: var(--text-primary); }

                    /* KONTROL PANELİ (SAĞ ÜST) */
                    .nav-controls {
                        position: fixed; top: 20px; right: 20px; z-index: 1000;
                        display: flex; flex-direction: column; gap: 10px;
                    }

                    .btn {
                        background: var(--accent); color: white; padding: 12px 20px; 
                        border-radius: 4px; box-shadow: 0 4px 6px var(--shadow); 
                        font-weight: bold; cursor: pointer; font-size: 13px; text-align: center;
                        user-select: none; border: none; transition: 0.2s;
                    }
                    .btn:hover { opacity: 0.9; transform: translateY(-2px); }

                    /* GİZLİ CHECKBOX'LAR */
                    #langToggle, #darkToggle, #noteToggle { display: none; }

                    /* BUTON METİN DİNAMİKLERİ */
                    #langToggle:not(:checked) ~ .nav-controls .lang-btn:after { content: "Show English Translation"; }
                    #langToggle:checked ~ .nav-controls .lang-btn:after { content: "Show Turkish Transcription"; }
                    
                    #noteToggle:not(:checked) ~ .nav-controls .note-btn:after { content: "Show Scholarly Notes"; }
                    #noteToggle:checked ~ .nav-controls .note-btn:after { content: "Hide Scholarly Notes"; }

                    #darkToggle:not(:checked) ~ .nav-controls .dark-btn:after { content: "🌙 Dark Mode"; }
                    #darkToggle:checked ~ .nav-controls .dark-btn:after { content: "☀️ Light Mode"; }

                    .header-section { text-align: center; border-bottom: 3px double var(--accent); margin-bottom: 40px; padding: 20px; }
                    
                    .page-container { 
                        display: flex; flex-direction: row; background: var(--bg-card); 
                        margin-bottom: 50px; padding: 25px; border-radius: 8px; 
                        box-shadow: 0 4px 15px var(--shadow); max-width: 1200px; 
                        margin-left: auto; margin-right: auto; border: 1px solid var(--border);
                    }

                    .manuscript-side { flex: 1; padding: 10px; border-right: 1px solid var(--border); text-align: center; }
                    .manuscript-side img { width: 100%; max-width: 500px; border: 1px solid var(--border); border-radius: 4px; }
                    
                    .text-side { flex: 1; padding: 30px; }

                    /* ARKADAŞININ KODUNDAKİ BOYUTLAR */
                    .tr-text { 
                        display: block; 
                        font-style: italic; 
                        font-size: 1.2em; 
                        line-height: 1.6; 
                    }

                    .en-text { 
                        display: none; 
                        font-size: 1.1em; 
                        border-left: 5px solid var(--accent); 
                        padding-left: 20px; 
                        line-height: 1.6; 
                    }

                    /* COMMENTARY KUTUSU (BAŞLANGIÇTA GİZLİ) */
                    .commentary-box {
                        display: none;
                        margin-top: 15px; padding: 12px;
                        background-color: var(--note-bg);
                        border-left: 4px solid var(--note-border);
                        font-size: 0.9em; font-family: sans-serif;
                        color: var(--text-primary);
                    }
                    .commentary-label { font-weight: bold; color: var(--note-border); text-transform: uppercase; font-size: 0.8em; display: block; margin-bottom: 5px; }

                    /* GÖSTER/GİZLE MANTIĞI */
                    #langToggle:checked ~ .site-wrapper .tr-text { display: none; }
                    #langToggle:checked ~ .site-wrapper .en-text { display: block; }
                    #noteToggle:checked ~ .site-wrapper .commentary-box { display: block; }

                    .couplet { margin-bottom: 45px; border-bottom: 1px dashed var(--border); padding-bottom: 20px; }
                    .couplet:last-child { border-bottom: none; }
                    .folio-label { font-weight: bold; color: var(--accent); display: block; margin-top: 15px; font-size: 1.1em; }
                </style>
            </head>
            <body>
                <input type="checkbox" id="langToggle" />
                <input type="checkbox" id="noteToggle" />
                <input type="checkbox" id="darkToggle" />
                
                <div class="nav-controls">
                    <label for="langToggle" class="btn lang-btn"></label>
                    <label for="noteToggle" class="btn note-btn"></label>
                    <label for="darkToggle" class="btn dark-btn"></label>
                </div>

                <div class="site-wrapper">
                    <div class="header-section">
                        <h1 style="color: var(--accent);">Kasîde</h1>
                        <p>Digital Humanities Edition | Mehmet Eray Avcı &amp; Uğur Can Yıldız</p>
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
                                        <div class="tr-text">
                                            <xsl:for-each select="tei:l">
                                                <span style="display:block;"><xsl:value-of select="."/></span>
                                            </xsl:for-each>
                                        </div>
                                        
                                        <div class="en-text">
                                            <xsl:value-of select="tei:note[@type='translation']"/>
                                        </div>

                                        <xsl:if test="tei:note[@type='commentary']">
                                            <div class="commentary-box">
                                                <span class="commentary-label">Scholarly Commentary</span>
                                                <xsl:value-of select="tei:note[@type='commentary']"/>
                                            </div>
                                        </xsl:if>
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


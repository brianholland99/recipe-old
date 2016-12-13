<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">


<xsl:template match="recipes">
  <fo:root>
    <fo:layout-master-set>
      <fo:simple-page-master master-name="recipe-8x11">
        <fo:region-body column-count="1" reference-orientation="0"
            margin-top="1in" margin-bottom="1in" margin-left="1in"
            margin-right="1in" />
      </fo:simple-page-master>
    </fo:layout-master-set><xsl:apply-templates/>
  </fo:root>
</xsl:template>


<xsl:template match="recipe">
  <fo:page-sequence master-reference="recipe-8x11">
    <fo:flow flow-name="xsl-region-body" font="10pt Times">

      <fo:block font="12pt Times" font-weight="bold">
        <xsl:value-of select="@title"/>
      </fo:block>

      <fo:block>
       <fo:leader leader-length="2.5in" leader-pattern="rule"
	 rule-style="solid" rule-thickness="0.5pt"/>
      </fo:block>
      <xsl:apply-templates select="category"/>
      <xsl:for-each select="group"><fo:block padding-left="9pt">
        <xsl:apply-templates select="."/></fo:block>
      </xsl:for-each>
      <xsl:apply-templates select="ingredients"/>
      <xsl:apply-templates select="steps"/>
      <xsl:apply-templates select="yield"/>
      <xsl:apply-templates select="comment"/>
      <xsl:apply-templates select="author"/>
      <xsl:apply-templates select="source"/>
      <xsl:apply-templates select="background"/>
      <xsl:apply-templates select="image"/>
    </fo:flow>
  </fo:page-sequence>
</xsl:template>


<xsl:template match="steps">
  <fo:block padding-top="9pt"><xsl:text>Steps:</xsl:text></fo:block>
  <fo:list-block padding-top="3pt" provisional-distance-between-starts="10mm">
    <xsl:for-each select="step">
      <fo:list-item>
        <fo:list-item-label end-indent="label-end()">
          <fo:block><xsl:number value="position()" format="1."/></fo:block>
        </fo:list-item-label>
        <fo:list-item-body start-indent="body-start()">
          <fo:block>
            <xsl:apply-templates select="."/>
          </fo:block>
        </fo:list-item-body>
      </fo:list-item>
    </xsl:for-each>
  </fo:list-block>
</xsl:template>


<xsl:template match="ingredients">
  <xsl:for-each select="ingredient|choices">
    <xsl:apply-templates select="."/>
  </xsl:for-each>
</xsl:template>


<!-- should check for negative and use "less" !!!!!!!!!!!!!!! -->
<xsl:template match="ingredient">
  <fo:list-block provisional-distance-between-starts="1in"
     padding-left="9pt">
    <fo:list-item>
      <fo:list-item-label end-indent="label-end()">
        <fo:block>
          <!-- min-measure & max-measure -->
	  <xsl:for-each select="measure">
	    <xsl:value-of select="@qty"/><xsl:text> </xsl:text>
	    <xsl:value-of select="@unit"/>
	    <xsl:if test="not(position()=last())">
	      <xsl:text> plus </xsl:text>
	    </xsl:if>
	  </xsl:for-each>
	  <xsl:for-each select="min-measure">
	    <xsl:value-of select="@qty"/><xsl:text> </xsl:text>
	    <xsl:value-of select="@unit"/>
	    <xsl:if test="not(position()=last())">
	      <xsl:text> plus </xsl:text>
	    </xsl:if>
	    <xsl:if test="position()=last()">
	      <xsl:text> - </xsl:text>
	    </xsl:if>
	  </xsl:for-each>
	  <xsl:for-each select="max-measure">
	    <xsl:value-of select="@qty"/><xsl:text> </xsl:text>
	    <xsl:value-of select="@unit"/>
	    <xsl:if test="not(position()=last())">
	      <xsl:text> plus </xsl:text>
	    </xsl:if>
	  </xsl:for-each>
	</fo:block>
      </fo:list-item-label>
      <fo:list-item-body start-indent="body-start()">
	<fo:block>
	  <xsl:value-of select="@form"/>
	  <xsl:text> </xsl:text>
	  <xsl:value-of select="@name"/>
	  <xsl:if test="@optional = 'yes'"><xsl:text> (optional)</xsl:text>
	  </xsl:if>
	</fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </fo:list-block>
</xsl:template>

<xsl:template match="choices">
  <fo:block padding-left="9pt"><xsl:text>Choose:</xsl:text></fo:block>
  <fo:block padding-left="9pt">
    <xsl:for-each select="choice">
      <fo:list-block  provisional-distance-between-starts="15pt"
              padding-left="18pt">
        <fo:list-item>
	  <fo:list-item-label end-indent="label-end()">
	    <fo:block>
	      <xsl:number value="position()" format="1) "/>
	    </fo:block>
	  </fo:list-item-label>
	  <fo:list-item-body start-indent="body-start()">
	    <xsl:apply-templates select="."/>
	  </fo:list-item-body>
        </fo:list-item>
      </fo:list-block>
      <xsl:if test="not(position()=last())">
        <fo:block padding-left="9pt" font-size="8pt">
          <xsl:text>or</xsl:text>
        </fo:block>
      </xsl:if>
    </xsl:for-each>
  </fo:block>
</xsl:template>

<!-- Not needed since default is to apply templates of child elements-->
<!-- commented out
<xsl:template match="choice">
  <fo:block>
    <xsl:apply-templates select="ingredient"/>
    <xsl:apply-templates select="comment"/>
  </fo:block>
</xsl:template>
-->

<xsl:template match="emph">
  <fo:wrapper font-weight="bold">
    <xsl:apply-templates/>
  </fo:wrapper>
</xsl:template>

<!-- This doesn't appear to match multiple attributes !!! -->
<xsl:template match="yield"> 
  <fo:block>
  <xsl:text>Makes: </xsl:text>
  <xsl:value-of select="@count"/>
  <xsl:text> </xsl:text><xsl:value-of select="@size"/>
  </fo:block>
</xsl:template>

<xsl:template match="group/steps">
  <fo:block padding-top="4pt">
    <xsl:value-of select="../@name"/>
    <xsl:text> steps:</xsl:text>
  </fo:block>
  <fo:block>
    <fo:list-block padding-top="3pt"
	 provisional-distance-between-starts="5mm">
      <xsl:for-each select="step">
        <fo:list-item>
          <fo:list-item-label end-indent="label-end()">
            <fo:block><xsl:number value="position()" format="1."/>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()"><fo:block>
            <xsl:apply-templates select="."/>
          </fo:block></fo:list-item-body>
        </fo:list-item>
      </xsl:for-each>
    </fo:list-block>
  </fo:block>
</xsl:template>

<xsl:template match="group">
  <fo:block space-after.optimum="6pt" space-before.optimum="6pt">
    <fo:block font-weight="bold"><xsl:value-of select="@name"/></fo:block>
    <xsl:apply-templates select="ingredients"/>
    <xsl:apply-templates select="steps"/>
  </fo:block>
</xsl:template>

<xsl:template match="author">
  <fo:block>
  <xsl:text>Author: </xsl:text>
  <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="source">
  <fo:block>
  <xsl:text>Source: </xsl:text>
  <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="background">
  <fo:block>
  <xsl:text>Background: </xsl:text>
  <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="category">
  <fo:block>
  <xsl:text>Category: </xsl:text>
  <xsl:value-of select="@name"/>
  </fo:block>
</xsl:template>

<xsl:template match="comment">
  <fo:block>
  <xsl:text>Comment: </xsl:text>
  <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="image">
  <fo:block>
  <xsl:text>Image: </xsl:text>
  </fo:block>
  <fo:block>
<fo:external-graphic src="url('{@src}')"/>
  </fo:block>
</xsl:template>

</xsl:stylesheet>








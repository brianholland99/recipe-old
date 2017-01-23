<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">


<xsl:template match="recipes">
<HTML><HEAD><TITLE><xsl:text>Recipes</xsl:text></TITLE></HEAD>
<BODY><xsl:apply-templates/></BODY></HTML>
</xsl:template>


<xsl:template match="recipe">
<H1><xsl:value-of select="@title"/></H1><HR />
<xsl:apply-templates select="category"/>
<xsl:apply-templates select="group"/>
<xsl:apply-templates select="ingredients"/>
<xsl:apply-templates select="steps"/>
<xsl:apply-templates select="yield"/>
<xsl:apply-templates select="comment"/>
<xsl:apply-templates select="authors"/>
<xsl:apply-templates select="source"/>
<xsl:apply-templates select="background"/>
<xsl:apply-templates select="image"/>
</xsl:template>


<xsl:template match="steps">
<H3><xsl:text>Steps:</xsl:text></H3><OL>
  <xsl:for-each select="step">
    <LI><xsl:apply-templates select="."/></LI>
  </xsl:for-each>
</OL>
</xsl:template>

<xsl:template match="ingredients">
<H3><xsl:text>Ingredients:</xsl:text></H3><UL>
  <xsl:for-each select="ingredient|choices">
    <xsl:apply-templates select="."/>
  </xsl:for-each>
</UL>
</xsl:template>


<xsl:template match="ingredient">
<LI><xsl:for-each select="measure">
<xsl:value-of select="@qty"/><xsl:text> </xsl:text>
<xsl:value-of select="@unit"/><xsl:text> </xsl:text>
<!-- should check for negative and use "less" !!!!!!!!!!!!!!! -->
<xsl:if test="not(position()=last())"><xsl:text> plus </xsl:text></xsl:if>
</xsl:for-each>
<xsl:apply-templates select="measure-range"/>
<xsl:value-of select="@form"/><xsl:text> </xsl:text>
<xsl:value-of select="@name"/>
<xsl:if test="@optional = 'yes'"><xsl:text> (optional)</xsl:text></xsl:if></LI>
</xsl:template>


<xsl:template match="measure-range">
<xsl:for-each select="min-measure">
<xsl:value-of select="@qty"/><xsl:text> </xsl:text>
<xsl:value-of select="@unit"/><xsl:text> </xsl:text>
<!-- should check for negative and use "less" !!!!!!!!!!!!!!! -->
<xsl:if test="not(position()=last())"><xsl:text> plus </xsl:text></xsl:if>
<xsl:if test="position()=last()"><xsl:text> - </xsl:text></xsl:if>
</xsl:for-each>
<xsl:for-each select="max-measure">
<xsl:value-of select="@qty"/><xsl:text> </xsl:text>
<xsl:value-of select="@unit"/><xsl:text> </xsl:text>
<!-- should check for negative and use "less" !!!!!!!!!!!!!!! -->
<xsl:if test="not(position()=last())"><xsl:text> plus </xsl:text></xsl:if>
</xsl:for-each>
</xsl:template>



<xsl:template match="choices">
  <LI><xsl:text>Choose:</xsl:text>
    <UL><xsl:for-each select="choice">
	   <xsl:apply-templates select="."/>
      <xsl:if test="not(position()=last())">
          <xsl:text>or</xsl:text>
      </xsl:if>
    </xsl:for-each></UL></LI>
</xsl:template>

<xsl:template match="emph">
<B><xsl:apply-templates/></B>
</xsl:template>

<!-- This doesn't appear to match multiple attributes !!! -->
<!--
<xsl:template match="yield">
<xsl:text>Makes: </xsl:text><xsl:value-of select="@count"/>
<xsl:text> </xsl:text><xsl:value-of select="@size"/><BR />
</xsl:template>
-->
<!-- Yield -->
<xsl:template match="yield">
  <xsl:choose><!-- { -->
    <xsl:when test="@serves"><!-- { -->
      Serves <xsl:value-of select="@serves"/>
    </xsl:when><!-- } -->
    <xsl:when test="@count"><!-- { -->
      Makes <xsl:value-of select="@count"/>
    </xsl:when><!-- } -->
    <xsl:when test="@measurement"><!-- { -->
      Makes <xsl:value-of select="@measurement"/>
    </xsl:when><!-- } -->
    <xsl:when test="@size"><!-- { -->
      Makes <xsl:value-of select="@size"/>
    </xsl:when><!-- } -->
    <xsl:when test="@descriptive"><!-- { -->
      Makes <xsl:value-of select="@descriptive"/>
    </xsl:when><!-- } -->
  </xsl:choose><!-- } -->
  <BR />
</xsl:template>

<xsl:template match="group">
<B><xsl:value-of select="@name"/></B>
<UL><xsl:apply-templates select="ingredients"/></UL>
<xsl:apply-templates select="steps"/><!-- Need to pass part name ?? -->
<!--
<B><xsl:value-of select="@name"/><xsl:text> steps:</xsl:text></B><OL>
  <xsl:for-each select="steps/step">
    <LI><xsl:apply-templates select="."/></LI>
  </xsl:for-each>
</OL>
-->
<BR />
</xsl:template>

<xsl:template match="group/steps">
<B><xsl:value-of select="@name"/><xsl:text> steps:</xsl:text></B><OL>
<xsl:for-each select="step">
    <LI><xsl:apply-templates select="."/></LI>
  </xsl:for-each>
</OL>

</xsl:template>

<xsl:template match="authors">
<xsl:text>Authors: </xsl:text><I><xsl:apply-templates/></I><BR />
</xsl:template>

<xsl:template match="source">
<xsl:text>Source: </xsl:text><I><xsl:apply-templates/></I><BR />
</xsl:template>

<xsl:template match="category">
<xsl:text>Category: </xsl:text><I><xsl:value-of select="@name"/></I><BR />
</xsl:template>

<xsl:template match="comment">
<xsl:text>Comment: </xsl:text><xsl:apply-templates/><BR />
</xsl:template>


<xsl:template match="background">
<xsl:text>Background: </xsl:text><xsl:apply-templates/><BR />
</xsl:template>



<xsl:template match="image">
  <xsl:text>Image: </xsl:text>
<img src="{@src}" />
</xsl:template>

</xsl:stylesheet>








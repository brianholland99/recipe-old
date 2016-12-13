<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">


<xsl:template match="recipes">
<HTML>
<HEAD>
  <TITLE>Recipes</TITLE>
  <style type="text/css">
.BookTitle  { font-family: Arial, Helvetica, sans-serif;
              font-size: 24px;
              font-weight: bold;
              color: #000000;
              background-color: #CCCCCC;
              text-align: center;
              margin-left: 10px;
              margin-right: 10px;
              margin-top: 20px;
              margin-bottom: 20px; }
.BookAuthor { font-family: Arial, Helvetica, sans-serif;
              font-size: 12px;
              color: #000000;
              font-weight: bold;
              margin-left: 10px;
              margin-right: 10px;
              margin-top: 10px;
              margin-bottom: 0px; }
.BookVersion{ font-family: Arial, Helvetica, sans-serif;
              font-size: 12px;
              font-weight: bold;
              color: #000000;
              margin-left: 40px;
              margin-right: 10px;
              margin-top: 10px;
              margin-bottom: 0px; }
.BookDate   { font-family: Arial, Helvetica, sans-serif;
              font-size: 10px;
              font-weight: normal;
              color: #000000;
              margin-left: 40px;
              margin-right: 10px;
              margin-top: 0px;
              margin-bottom: 10px; }
.TOC        { font-family: Arial, Helvetica, sans-serif;
              font-size: large;
              font-weight: bold;
              color: #666666;
              margin-top: 5px;
              margin-bottom: 5px; }
.TOCentry   { font-family: Arial, Helvetica, sans-serif;
              font-size: medium;
              font-weight: normal;
              color: #666666;
              margin-left: 10px;
              margin-right: 10px;
              margin-top: 0px;
              margin-bottom: 0px; }
.Title      { font-family: Arial, Helvetica, sans-serif;
              font-size: larger;
              font-weight: bold;
              color: #CC0000;
              margin-top: 15px;
              margin-bottom: 5px; }
.SubTitle   { font-family: Arial, Helvetica, sans-serif;
              font-size: small;
              color: #CC0000;
              margin-top: 0px;
              margin-bottom: 5px; }
.Author     { font-family: Arial, Helvetica, sans-serif;
              font-size: small;
              color: #000000;
              font-weight: bold; }
.Source     { font-family: Arial, Helvetica, sans-serif;
              font-size: small;
              color: #000000;
              font-weight: bold; }
.Category   { font-family: Arial, Helvetica, sans-serif;
              font-size: small;
              color: #000000;
              font-weight: bold; }
.Comment    { font-family: Arial, Helvetica, sans-serif;
              font-size: medium;
              color: #999999;
              text-align: center; }
.Story      { font-family: Arial, Helvetica, sans-serif;
              font-size: medium;
              color: #000000;
              text-align: left; }
.Section    { font-family: Verdana, Arial, Helvetica, sans-serif;
              font-size: medium;
              font-weight: bold;
              color: #D00000;
              margin-left: 5px;
              margin-top: 15px; }
.Measure    { font-family: Arial, Helvetica, sans-serif;
              font-size: medium;
              font-weight: bold;
              margin-left: 5px; }
.Ingredient { font-family: Arial, Helvetica, sans-serif;
              font-size: medium;
              font-weight: bold;
              margin-left: 5px; }
.Choices    { background-color: #EEEEEE; }
.Choice     { font-family: Verdana, Arial, Helvetica, sans-serif;
              font-size: small;
              font-weight: bold;
              color: #D00000;
              margin-left: 20px;
              margin-top: 10px; }
.Group      { font-family: Verdana, Arial, Helvetica, sans-serif;
              font-size: small;
              font-weight: bold;
              color: #D00000;
              margin-left: 15px;
              margin-top: 10px; }
.DirectionNum { font-family: Arial, Helvetica, sans-serif;
              font-size: large;
              font-weight: bold;
              color: #0099CC;
              text-align: right;
              margin-left: 25px; }
.Direction  { font-family: Arial, Helvetica, sans-serif;
              font-size: medium;
              font-weight: bold;
              margin-top: 0px;
              margin-bottom: 0px; }
.Servings   { font-family: Arial, Helvetica, sans-serif;
              font-size: medium;
              font-weight: bold;
              color: #0098D0;
              text-align: right; }
  </style>
</HEAD>
<BODY bgcolor="#FFFFFF" text="#000000">
  <xsl:apply-templates select="bookinfo"/>
  <P CLASS="TOC">Table of Contents</P>
  <xsl:for-each select="recipe">
    <P CLASS="TOCentry">
      <xsl:element name="A">
        <xsl:attribute name="HREF">#<xsl:value-of select="translate(@title,' ','_')"/></xsl:attribute>
        <xsl:attribute name="CLASS">TOCentry</xsl:attribute>
        <xsl:value-of select="@title"/>
      </xsl:element>
    </P>
  </xsl:for-each>
  <HR/>
  <xsl:apply-templates select="recipe"/>
</BODY>
</HTML>
</xsl:template>

<!-- bookinfo -->
<xsl:template match="bookinfo">
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR><TD CLASS="BookTitle"><xsl:apply-templates select="title"/></TD></TR>
</TABLE>

<xsl:apply-templates select="author" mode="book"/>
<HR WIDTH="30%" ALIGN="left"/>
<xsl:apply-templates select="version"/>
<xsl:apply-templates select="date"/>
<HR/>
</xsl:template>

<!-- book:title -->
<xsl:template match="title">
  <P CLASS="BookTitle"><xsl:apply-templates/></P>
</xsl:template>

<!-- book:author -->
<xsl:template match="author" mode="book">
  <P CLASS="BookAuthor"><xsl:apply-templates/></P>
</xsl:template>

<!-- book:version -->
<xsl:template match="version">
  <P CLASS="BookVersion">Version <xsl:apply-templates/></P>
</xsl:template>

<!-- book:date -->
<xsl:template match="date">
  <P CLASS="BookDate"><xsl:apply-templates/></P>
</xsl:template>

<!-- recipe -->
<xsl:template match="recipe">
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR>
    <TD VALIGN="top" WIDTH="100%" CLASS="Title">
      <xsl:element name="A">
        <xsl:attribute name="NAME"><xsl:value-of select="translate(@title,' ','_')"/></xsl:attribute>
        <xsl:value-of select="@title"/>
      </xsl:element>
      <xsl:if test="not(@subtitle = '')">
        <SPAN CLASS="SubTitle"> - <xsl:value-of select="@subtitle"/></SPAN>
      </xsl:if>
    </TD>
    <TD VALIGN="top" ALIGN="center">
      <xsl:apply-templates select="image"/>
    </TD>
    <TD VALIGN="top" ALIGN="right">
      <TABLE BORDER="0">
        <xsl:apply-templates select="category"/>
        <TR CLASS="Source">
          <TD VALIGN="top" ALIGN="right">Source:</TD>
          <TD VALIGN="top"><xsl:apply-templates select="source"/></TD>
        </TR>
      </TABLE>
    </TD>
  </TR>
<xsl:apply-templates select="group"/>
<xsl:apply-templates select="ingredients"/>
<xsl:apply-templates select="steps"/>
<xsl:apply-templates select="yield"/>
<xsl:apply-templates select="comment"/>
<xsl:apply-templates select="background"/>
  <TR>
    <TD></TD>
    <TD CLASS="Author">
      <xsl:apply-templates select="author"/>
    </TD>
  </TR>
</TABLE>
<HR/>
</xsl:template>


<!-- do_steps -->
<xsl:template name="do_steps">
  <xsl:for-each select="step">
              <TR>
                <TD CLASS="DirectionNum" VALIGN="top">
    <xsl:value-of select="position()"/>
                </TD>
                <TD CLASS="Direction" VALIGN="top" WIDTH="100%">
    <xsl:apply-templates select="."/>
                </TD>
              </TR>
  </xsl:for-each>
</xsl:template>

<!-- Steps -->
<xsl:template match="steps">
          <TD COLSPAN="3">
            <TABLE WIDTH="98%" BORDER="0" CELLSPACING="0" CELLPADDING="2">
              <TR><TD COLSPAN="3"><P CLASS="Section">Directions:</P></TD></TR>
  <xsl:call-template name="do_steps" select="."/>
            </TABLE>
          </TD>
</xsl:template>

<!-- Steps:group -->
<xsl:template match="steps" mode="group">
  <TR>
    <TD COLSPAN="3">
      <TABLE WIDTH="98%" BORDER="0" CELLSPACING="0" CELLPADDING="2">
        <TR><TD COLSPAN="2"><P CLASS="Group">Directions:</P></TD></TR>
        <xsl:call-template name="do_steps" select="."/>
      </TABLE>
    </TD>
  </TR>
</xsl:template>

<!-- Ingredients -->
<xsl:template match="ingredients">
  <TR>
    <TD COLSPAN="3">
      <SPAN CLASS="Section">Ingredients:</SPAN>
      <TABLE WIDTH="75%" BORDER="0" CELLSPACING="0" CELLPADDING="5">
        <TR><TD>&#xA0;</TD><TD>
          <TABLE WIDTH="100%" BORDER="1" CELLSPACING="0" CELLPADDING="2">
            <xsl:apply-templates/>
          </TABLE>
        </TD></TR>
      </TABLE>
    </TD>
  </TR>
</xsl:template>

<!-- Ingredients:group -->
<xsl:template match="ingredients" mode="group">
  <TR>
    <TD COLSPAN="3">
      <SPAN CLASS="Group">Ingredients:</SPAN>
      <TABLE WIDTH="75%" BORDER="0" CELLSPACING="0" CELLPADDING="5">
        <TR><TD>&#xA0;</TD><TD>
          <TABLE WIDTH="100%" BORDER="1" CELLSPACING="0" CELLPADDING="2">
            <xsl:apply-templates/>
          </TABLE>
        </TD></TR>
      </TABLE>
    </TD>
  </TR>
</xsl:template>

<!-- Ingredient -->
<xsl:template match="ingredient">
        <TR>
  <xsl:choose>
    <xsl:when test="count(descendant::*) &lt; 1">
      <!-- Empty ingredient element: output name only -->
          <TD VALIGN="top"></TD>
          <TD VALIGN="top" WIDTH="100%" CLASS="Ingredient">
      <xsl:value-of select="@name"/>
      <xsl:if test="not(@form = '')">
       - <xsl:value-of select="@form"/>
      </xsl:if>
      <xsl:if test="@optional = 'yes'"> (<I>optional</I>)</xsl:if>
          </TD>
    </xsl:when>
    <xsl:otherwise>
      <!-- One or more measures -->
          <TD VALIGN="top" NOWRAP="1" CLASS="Measure">
            <P CLASS="Measure">
      <xsl:apply-templates/>
            </P>
          </TD>
          <TD VALIGN="top" WIDTH="100%" CLASS="Ingredient">
            <P CLASS="Ingredient">
      <xsl:value-of select="@name"/>
      <xsl:if test="not(@form = '')">
       - <xsl:value-of select="@form"/>
      </xsl:if>
      <xsl:if test="@optional = 'yes'"> (<I>optional</I>)</xsl:if>
            </P>
          </TD>
    </xsl:otherwise>
  </xsl:choose>
        </TR>
</xsl:template>

<!-- Measure -->
<xsl:template match="measure">
  <xsl:choose><!-- { -->
    <xsl:when test="not(@type = 'alternate')"><!-- { -->
      <xsl:if test="position() &gt; 2"><!-- { -->
        <!-- Additional measure: Measure plus/minus Measure -->
        <xsl:choose><!-- { -->
          <!-- negative measure == 'less', positive == 'plus' -->
          <xsl:when test="@qty &lt; 0"><xsl:text> less </xsl:text></xsl:when>
          <xsl:otherwise><xsl:text> plus </xsl:text></xsl:otherwise>
        </xsl:choose><!-- } -->
      </xsl:if><!-- } -->
    </xsl:when><!-- } -->
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="position() = 4"><BR/>(</xsl:when>
        <xsl:otherwise>,<BR/> </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose><!-- } -->
  <!-- TODO: precision -->
  <xsl:value-of select="@qty"/><xsl:text> </xsl:text>
  <xsl:value-of select="@unit"/>
  <xsl:if test="(@type = 'alternate') and ((position()+1) = last())">)</xsl:if>
</xsl:template>

<!-- Measure-range -->
<xsl:template match="measure-range">
  <xsl:value-of select="./min-measure/@qty"/>
  <xsl:if test="not(./min-measure/@unit = ./max-measure/@unit)">
    <xsl:text> </xsl:text><xsl:value-of select="./min-measure/@unit"/>
  </xsl:if>
  <xsl:text> - </xsl:text>
  <xsl:value-of select="./max-measure/@qty"/><xsl:text> </xsl:text>
  <xsl:value-of select="./max-measure/@unit"/>

  <!-- xsl:apply-templates/ -->
</xsl:template>

<xsl:template match="min-measure">
  <xsl:value-of select="@qty"/><xsl:text> </xsl:text>
  <xsl:value-of select="@unit"/>
  <xsl:text> - </xsl:text>
</xsl:template>

<xsl:template match="max-measure">
  <xsl:value-of select="@qty"/><xsl:text> </xsl:text>
  <xsl:value-of select="@unit"/>
</xsl:template>

<!-- Choices -->
<xsl:template match="choices">
        <TR><TD COLSPAN="3" CLASS="Choice">
          Choose:
          <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="2">
            <TR>
              <TD>&#xA0;</TD>
              <TD>
                <TABLE WIDTH="100%" BORDER="1" CELLSPACING="0" CELLPADDING="2">
  <xsl:apply-templates/>
                </TABLE>
              </TD>
            </TR>
          </TABLE>
        </TD></TR>
</xsl:template>

<xsl:template match="choice">
  <xsl:apply-templates/>
  <xsl:if test="not((position()+1)=last())">
        <TR><TD COLSPAN="3" CLASS="Choice">or</TD></TR>
  </xsl:if>
</xsl:template>

<!-- Yield -->
<xsl:template match="yield">
  <TR>
    <TD COLSPAN="3" CLASS="Servings">
      <P CLASS="Servings">
  <xsl:choose><!-- { -->
    <xsl:when test="not(@serves = '')"><!-- { -->
      Serves <xsl:value-of select="@serves"/>
    </xsl:when><!-- } -->
    <xsl:when test="not(@count = '')"><!-- { -->
      Makes <xsl:value-of select="@count"/>
    </xsl:when><!-- } -->
    <xsl:when test="not(@measurement = '')"><!-- { -->
      Makes <xsl:value-of select="@measurement"/>
    </xsl:when><!-- } -->
    <xsl:when test="not(@size = '')"><!-- { -->
      Makes <xsl:value-of select="@size"/>
    </xsl:when><!-- } -->
    <xsl:when test="not(@descriptive = '')"><!-- { -->
      Makes <xsl:value-of select="@descriptive"/>
    </xsl:when><!-- } -->
  </xsl:choose><!-- } -->
      </P>
    </TD>
  </TR>
</xsl:template>

<!-- Group -->
<xsl:template match="group">
  <TR>
    <TD COLSPAN="3">
      <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="2">
        <TR>
          <TD COLSPAN="2">
            <P CLASS="Section"><xsl:value-of select="@name"/></P>
          </TD>
        </TR>
    <xsl:apply-templates select="./ingredients" mode="group"/>
    <xsl:apply-templates select="./steps" mode="group"/>
      </TABLE>
    </TD>
  </TR>
</xsl:template>

<!-- Author -->
<xsl:template match="author">
  <xsl:if test="position() &gt; 1">, </xsl:if>
  <xsl:apply-templates/>
</xsl:template>

<!-- Source -->
<xsl:template match="source">
  <xsl:if test="position() &gt; 1">, </xsl:if>
  <xsl:apply-templates/>
</xsl:template>

<!-- Category -->
<xsl:template match="category">
        <TR CLASS="Category">
          <TD VALIGN="top" ALIGN="right">Category:</TD>
          <TD VALIGN="top" NOWRAP="1"><xsl:value-of select="@name"/></TD>
        </TR>
</xsl:template>

<!-- Comment -->
<xsl:template match="comment">
  <TR><TD COLSPAN="3"><P CLASS="Comment"><xsl:apply-templates/></P></TD></TR>
</xsl:template>

<!-- Background (story) -->
<xsl:template match="background">
  <TR><TD COLSPAN="3"><P CLASS="Story"><xsl:apply-templates/></P></TD></TR>
</xsl:template>

<!-- Image -->
<xsl:template match="image">
  <img src="{@src}" />
</xsl:template>

<!-- Emph -->
<xsl:template match="emph">
<B><xsl:apply-templates/></B>
</xsl:template>

</xsl:stylesheet>

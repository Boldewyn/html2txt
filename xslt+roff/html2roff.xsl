<?xml version="1.0" encoding="UTF-8" ?>
<stylesheet version="1.0" xmlns="http://www.w3.org/1999/XSL/Transform"
            xmlns:h="http://www.w3.org/1999/xhtml">

  <!--
  Use this command to invoke me:

cd $PWD; \
saxon -novw -s input.xhtml html2roff.xsl | \
groff -me -t -Tutf8 -P -f | \
more

  -->

  <!-- Change encoding to UTF-8 as soon as tested groff 1.19 -->
  <output method="text" media-type="application/x-troff" indent="no" encoding="ISO-8859-1" />

  <!-- P A R A M E T E R S -->
  <param name="showURL" select="''" />
  <param name="paged" select="true()" />
  <param name="ll" select="'78'" />
  <param name="nr-pi" select="'2'" />
  <param name="hpf" select="'/usr/share/groff/1.18.1/tmac/'" />
  <param name="htmlInlines" select="'|a|abbr|acronym|applet|b|basefont|bdo|big|br|button|cite|code|dd|del|dfn|dt|em|font|i|img|ins|input|iframe|kbd|label|map|object|q|samp|script|select|small|span|strong|sub|sup|textarea|tt|var|'" />
  <param name="textElements" select="'|a|abbr|acronym|b|basefont|bdo|big|button|cite|code|del|dfn|em|font|i|img|ins|input|iframe|kbd|label|map|object|q|samp|script|select|small|span|strong|sub|sup|textarea|tt|var|'" />

  <!-- C O R E :   T E X T   T E M P L A T E S -->

  <!-- Basic text match: return the trimmed string with a trailing new line -->
  <template match="text()">
    <!-- the normalized content -->
    <variable name="content">
      <!--call-template name="normalizeString" /-->
      <value-of select="." />
    </variable>
    <choose>
      <!-- any non-empty node -->
      <when test="string-length (normalize-space (translate (., '&#160;', ' '))) > 0">
        <if test="starts-with ( translate (., '&#160;&#xA;&#x9;', '   '), ' ') and
                  preceding-sibling::node()[1][self::* and
                    contains ($textElements, concat ('|', local-name(), '|'))] ">
          <text> </text>
        </if>
        <value-of select="normalize-space (translate ($content, '&#160;', ' '))" />
        <if test="contains ( substring(translate (., '&#160;&#xA;&#x9;', '   '), string-length(), 1), ' ') and
                  following-sibling::node()[1][self::* and
                    contains ($textElements, concat ('|', local-name(), '|'))] ">
          <text> </text>
        </if>
      </when>
      <!-- an empty node between two inlines -->
      <when test="preceding-sibling::node()[1][self::* and
                    contains ($textElements, concat ('|', local-name(), '|'))] and
                  following-sibling::node()[1][self::* and
                    contains ($textElements, concat ('|', local-name(), '|'))] ">
        <text> </text>
      </when>
    </choose>
  </template>

  <!-- I N C L U D E   F I L E S -->

  <!-- write a translation table for special (non-ascii) characters-->
  <include href="h2r_specialchars.xsl" />

  <!-- HTML head elements -->
  <include href="h2r_head.xsl" />

  <!-- HTML Block elements -->
  <include href="h2r_blocks.xsl" />

  <!-- HTML tables -->
  <include href="h2r_tables.xsl" />

  <!-- HTML inline elements -->
  <include href="h2r_inlines.xsl" />

  <!-- S T A R T   P R O C E S S I N G-->

  <!-- root element: write translation table for non-ascii values, then proceed with the document -->
  <template match="h:html">
    <if test=".//h:table">
      <text>.\" t</text>
    </if>
    <call-template name="init_chars" />
    <apply-templates />
    <text>.&#xA;</text>
  </template>

  <!-- G L O B A L   N A M E D   T E M P L A T E S -->

  <!-- a small string-repeat function -->
  <template name="strrepeat">
    <param name="string" select="''" />
    <param name="count" select="number (0)" />
    <if test="$count > 0">
      <value-of select="$string" />
      <call-template name="strrepeat">
        <with-param name="string" select="$string" />
        <with-param name="count" select="number ($count - 1)" />
      </call-template>
    </if>
  </template>

  <!-- print the text of a node -->
  <template name="gettext">
    <param name="node" select="." />
    <if test="string-length (normalize-space (translate ($node, '&#160;', ''))) > 0">
      <value-of select="normalize-space (translate ($node, '&#160;', ''))" />
    </if>
  </template>

  <template name="_">
    <param name="msgid" select="." />
    <value-of select="." />
  </template>

  <template name="normalizeString">
    <param name="string" select="." />
    <param name="lang" select="substring (/h:html/@xml:lang, 1, 2)" />
    <value-of select="$string" />
  </template>

</stylesheet>

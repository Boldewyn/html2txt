<?xml version="1.0" encoding="UTF-8" ?>
<stylesheet version="1.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:h="http://www.w3.org/1999/xhtml">

  <template match="h:head">
    <text>.\" &lt;head>&#xA;</text>
    <!-- page dimensions -->
    <text>.ll </text>
    <value-of select="$ll" />
    <text>n&#xA;</text>
    <if test="not ($paged)">
      <text>.pl 1000000&#xA;</text>
    </if>
    <!-- paragraphs, fine tuning -->
    <text>.nr pi </text>
    <value-of select="$nr-pi" />
    <text>n&#xA;</text>
    <text>.m1 </text><value-of select="'1'" /><text>v&#xA;</text>
    <text>.m2 </text><value-of select="'1'" /><text>v&#xA;</text>
    <text>.m3 </text><value-of select="'1'" /><text>v&#xA;</text>
    <text>.m4 </text><value-of select="'1'" /><text>v&#xA;</text>
    <!-- hyphenation -->
    <if test="../@xml:lang">
      <text>.hla </text>
      <value-of select="substring(../@xml:lang,1,2)" />
      <text>&#xA;</text>
      <text>.hpf </text>
      <value-of select="$hpf" />
      <text>hyphen.</text>
      <value-of select="substring(../@xml:lang,1,2)" />
      <text>&#xA;</text>
    </if>
    <text>.&#xA;</text>
    <apply-templates select="h:title" />
    <text>.\" &lt;/head>&#xA;.&#xA;</text>
  </template>

  <template match="h:title">
    <text>.eh '%''</text>
    <value-of select="." />
    <text>'&#xA;</text>
    <text>.oh '</text>
    <value-of select="." />
    <text>''%'&#xA;</text>
    <text>.ef '</text>
    <if test="../h:meta[@name='author']">
      <call-template name="gettext">
        <with-param name="node" select="../h:meta[@name='author']/@content" />
      </call-template>
    </if>
    <text>''</text>
    <if test="../h:meta[@name='date']">
      <call-template name="gettext">
        <with-param name="node" select="../h:meta[@name='date']/@content" />
      </call-template>
    </if>
    <text>'&#xA;</text>
    <text>.of '</text>
    <if test="../h:meta[@name='date']">
      <call-template name="gettext">
        <with-param name="node" select="../h:meta[@name='date']/@content" />
      </call-template>
    </if>
    <text>''</text>
    <if test="../h:meta[@name='author']">
      <call-template name="gettext">
        <with-param name="node" select="../h:meta[@name='author']/@content" />
      </call-template>
    </if>
    <text>'&#xA;</text>
    <text>.&#xA;</text>
  </template>

  <template match="h:body">
    <text>.\" &lt;body>&#xA;</text>
    <if test="string-length ($showURL) > 0">
      <text>URL of this document: &#xA;</text>
      <text>.b "&lt;</text>
      <value-of select="$showURL" />
      <text>>"&#xA;</text>
      <text>.sp 2&#xA;</text>
    </if>
    <apply-templates />
    <text>.\" &lt;/body>&#xA;.&#xA;</text>
  </template>

</stylesheet>

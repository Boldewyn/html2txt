<?xml version="1.0" encoding="UTF-8" ?>
<stylesheet version="1.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:h="http://www.w3.org/1999/xhtml">

  <param name="hr-char" select="'-'" />

  <template match="*" mode="inlineBlock">
    <apply-templates select="." />
  </template>

  <template match="h:address|h:blockquote|h:center|h:del|h:dir|h:div|h:dl|h:fieldset|h:form|h:h1|h:h2|h:h3|h:h4|h:h5|h:h6|h:hr|h:ins|h:isindex|h:menu|h:noframes|h:noscript|h:ol|h:p|h:pre|h:table|h:ul" mode="inlineBlock">
    <text>&#xA;</text>
    <apply-templates select="." />
  </template>

  <template match="h:address|h:del|h:dir|h:fieldset|h:form|h:ins|h:isindex|h:menu|h:noframes|h:noscript">
    <apply-templates />
    <text>&#xA;</text>
  </template>

  <template match="h:pre">
    <value-of select="." />
  </template>

  <template match="h:div">
    <!-- the first div could open a block, but this is bad in cases of div/h1, ... -->
    <!--if test="not(ancestor::h:*[local-name()='div'])">
      <text>.(b&#xA;</text>
    </if-->
    <apply-templates />
    <text>&#xA;</text>
    <!--if test="not(ancestor::h:*[local-name()='div'])">
      <text>.)b&#xA;</text>
    </if-->
  </template>

  <template match="h:p">
    <text>.pp&#xA;</text>
    <apply-templates />
    <text>&#xA;</text>
  </template>

  <template match="h:center">
    <text>.ce 10000&#xA;</text>
    <apply-templates />
    <text>&#xA;</text>
    <text>.ce 0&#xA;</text>
  </template>

  <template match="h:blockquote">
    <text>.(q&#xA;</text>
    <apply-templates />
    <text>&#xA;</text>
    <text>.)q&#xA;</text>
  </template>

  <template match="h:hr">
    <text>.br&#xA;</text>
    <call-template name="strrepeat">
      <with-param name="string" select="$hr-char" />
      <with-param name="count" select="number($ll)" />
    </call-template>
    <text>&#xA;</text>
  </template>

  <template match="h:ol|h:ul|h:dl">
    <text>.(l&#xA;</text>
    <apply-templates select="h:li|h:dt|h:dd" />
    <text>.)l&#xA;</text>
  </template>

  <template match="h:ol/h:li">
    <text>.np&#xA;</text>
    <apply-templates mode="inlineBlock" />
    <text>&#xA;</text>
  </template>

  <template match="h:ul/h:li">
    <text>.bu&#xA;</text>
    <apply-templates mode="inlineBlock" />
    <text>&#xA;</text>
  </template>

  <template match="h:dl/h:dt">
    <text>.ip "</text>
    <apply-templates />
    <text>"&#xA;</text>
  </template>

  <template match="h:dl/h:dd">
    <apply-templates />
    <text>&#xA;</text>
  </template>

  <template match="h:h1">
    <text>.(b L&#xA;</text>
    <text>.(c&#xA;</text>
    <!--apply-templates select="text()" /-->
    <value-of select="." />
    <text>&#xA;</text>
    <text>.)c&#xA;</text>
    <text>.)b&#xA;</text>
    <text>.sp&#xA;</text>
  </template>

  <template match="h:h2">
    <text>.(b&#xA;</text>
    <text>.sh 1 "</text>
    <!--apply-templates select="text()" /-->
    <value-of select="." />
    <text>"&#xA;</text>
    <text>.)b&#xA;</text>
    <text>.sp&#xA;</text>
  </template>

  <template match="h:h3">
    <text>.(b&#xA;</text>
    <text>.sh 2 "</text>
    <!--apply-templates select="text()" /-->
    <value-of select="." />
    <text>"&#xA;</text>
    <text>.)b&#xA;</text>
    <text>.sp&#xA;</text>
  </template>

  <template match="h:h4">
    <text>.pp&#xA;</text>
    <text>.sh 3 "</text>
    <!--apply-templates select="text()" /-->
    <value-of select="." />
    <text>"&#xA;</text>
    <text>.sp&#xA;</text>
  </template>

  <template match="h:h5">
    <text>.pp&#xA;</text>
    <text>.sh 4 "</text>
    <!--apply-templates select="text()" /-->
    <value-of select="." />
    <text>"&#xA;</text>
    <text>.sp&#xA;</text>
  </template>

  <template match="h:h6">
    <text>.pp&#xA;</text>
    <text>.uh "</text>
    <!--apply-templates select="text()" /-->
    <value-of select="." />
    <text>"&#xA;</text>
    <text>.sp&#xA;</text>
  </template>

</stylesheet>

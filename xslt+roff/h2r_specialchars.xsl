<?xml version="1.0" encoding="UTF-8" ?>
<stylesheet version="1.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:h="http://www.w3.org/1999/xhtml">

  <template name="init_chars">
    <variable name="str">
      <for-each select="//h:*/text()|//h:meta/@content">
        <value-of select="." />
      </for-each>
    </variable>
    <if test="contains($str,'&#196;')">
      <text>.char &#196; \[:A]&#xA;</text>
    </if>
    <if test="contains($str,'&#214;')">
      <text>.char &#214; \[:O]&#xA;</text>
    </if>
    <if test="contains($str,'&#220;')">
      <text>.char &#220; \[:U]&#xA;</text>
    </if>
    <if test="contains($str,'&#223;')">
      <text>.char &#223; \[ss]&#xA;</text>
    </if>
    <if test="contains($str,'&#228;')">
      <text>.char &#228; \[:a]&#xA;</text>
    </if>
    <if test="contains($str,'&#246;')">
      <text>.char &#246; \[:o]&#xA;</text>
    </if>
    <if test="contains($str,'&#252;')">
      <text>.char &#252; \[:u]&#xA;</text>
    </if>
  </template>

</stylesheet>

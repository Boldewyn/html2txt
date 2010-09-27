<?xml version="1.0" encoding="UTF-8" ?>
<stylesheet version="1.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:h="http://www.w3.org/1999/xhtml">

  <template match="h:table">
    <text>.TS H&#xA;</text>
    <!--text>tab(&#x9;);</text-->
    <if test="@border > 0 or @width = '100%'">
      <if test="@border > 0">
        <text>allbox</text>
      </if>
      <if test="@width = '100%'">
        <if test="@border > 0">
          <text> </text>
        </if>
        <text>expand</text>
      </if>
    </if>
    <text>;&#xA;</text>
    <if test="h:caption">
      <text>c</text>
      <for-each select="h:tr[1]/h:th|h:tr[1]/h:td|h:tbody[1]/h:tr[1]/h:th|h:tbody[1]/h:tr[1]/h:td">
        <if test="position() != last()">
          <text> s</text>
        </if>
        <if test="@colspan">
          <value-of select="substring(' s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s',1,@colspan*2-1)" />
        </if>
      </for-each>
      <text>&#xA;</text>
    </if>
    <for-each select="h:tr|h:tbody/h:tr">
      <for-each select="h:th|h:td">
        <choose>
          <when test="local-name()='th'">
            <text>c<!--b   bold face will extend to following cells...--></text>
          </when>
          <otherwise>
            <text>l</text>
          </otherwise>
        </choose>
        <if test="@colspan">
          <value-of select="substring(' s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s',1,@colspan*2-1)" />
        </if>
        <if test="position() != last()">
          <text> </text>
        </if>
      </for-each>
      <choose>
        <when test="following-sibling::h:tr">
          <text>&#xA;</text>
        </when>
        <otherwise>
          <text>.&#xA;</text>
        </otherwise>
      </choose>
    </for-each>
    <if test="h:caption">
      <value-of select="h:caption" />
      <text>&#xA;</text>
    </if>
    <text>.TH&#xA;</text>
    <apply-templates select="h:tbody|h:tr" />
    <text>.TE&#xA;</text>
  </template>

  <template match="h:tr|h:tbody">
    <apply-templates select="h:th|h:td" />
  </template>
  
  <template match="h:td|h:th">
    <text>T{&#xA;</text>
    <apply-templates />
    <text>&#xA;T}</text>
    <choose>
      <when test="following-sibling::h:td or following-sibling::h:th">
        <text>&#x9;</text>
      </when>
      <otherwise>
        <text>&#xA;</text>
      </otherwise>
    </choose>
  </template>
  
</stylesheet>

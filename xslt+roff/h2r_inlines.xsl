<?xml version="1.0" encoding="UTF-8" ?>
<stylesheet version="1.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:h="http://www.w3.org/1999/xhtml">

  <template match="h:applet|h:basefont|h:bdo|h:big|h:button|h:cite|h:code|h:del|h:dfn|h:font|h:ins|h:input|h:iframe|h:kbd|h:map|h:object|h:samp|h:select|h:small|h:span|h:textarea|h:tt">
    <!-- for most stuff: Do nothing, since it isn't recognized by the terminal -->
    <apply-templates />
  </template>

  <template match="h:span[contains (@class, 'footnote')]">
    <text>[\**]&#xA;</text>
    <text>.(f&#xA;\** </text>
    <apply-templates />
    <text>&#xA;</text>
    <text>.)f&#xA;</text>
  </template>

  <template match="h:script">
    <!-- do nothing -->
  </template>

  <template match="h:abbr|h:acronym">
    <apply-templates />
    <!-- the long form goes in parentheses -->
    <if test="@title">
      <text> (</text>
      <value-of select="@title" />
      <text>)</text>
    </if>
  </template>

  <template match="h:label">
    <apply-templates />
    <!-- note the element the label is for -->
    <text> [label for </text>
    <choose>
      <when test="local-name (id (@for)) = 'select'">
        <text>selectlist </text>
      </when>
      <when test="local-name (id (@for)) = 'textarea'">
        <text>textarea </text>
      </when>
      <when test="local-name (id (@for)) = 'button'">
        <text>button </text>
      </when>
      <when test="id (@for)/@type">
        <value-of select="id (@for)/@type" />
        <text> element </text>
      </when>
    </choose>
    <text>#</text>
    <value-of select="@for" />
    <text>]</text>
  </template>

  <template match="h:b|h:strong">
    <if test="preceding-sibling::node()[1][self::text() or
                contains ($textElements, concat ('|', local-name(), '|'))]">
      <text>&#xA;</text>
    </if>
    <text>.b "</text>
    <apply-templates />
    <text>"&#xA;</text>
    <if test="following-sibling::node()[1][self::text() and starts-with (., ' ')]">
      <text>\&amp;</text>
    </if>
  </template>

  <template match="h:i|h:em|h:var">
    <if test="preceding-sibling::node()[1][self::text() or
                contains ($textElements, concat ('|', local-name(), '|'))]">
      <text>&#xA;</text>
    </if>
    <text>.i "</text>
    <apply-templates />
    <text>\|"&#xA;</text>
    <if test="following-sibling::node()[1][self::text() and starts-with (., ' ')]">
      <text>\&amp;</text>
    </if>
  </template>

  <template match="h:q">
    <!-- do nothing but adding quotes -->
    <text>\*(lq</text>
    <apply-templates />
    <text>\*(rq</text>
  </template>

  <template match="h:sub">
    <text>\*&lt;</text>
    <apply-templates />
    <text>\*></text>
  </template>

  <template match="h:sup">
    <text>\*{</text>
    <apply-templates />
    <text>\*}</text>
  </template>

  <template match="h:br">
    <!-- a break will be modelled by groff's .br -->
    <text>&#xA;.br&#xA;</text>
  </template>

  <template match="h:a">
    <apply-templates />
    <choose>
      <!-- all links (except mail) unequal to the link text -->
      <when test="@href != . and not (starts-with (@href, 'mailto:'))">
        <text> &lt;</text>
        <value-of select="@href" />
        <text>&gt;</text>
      </when>
      <!-- mail addresses unequal to the link text -->
      <when test="starts-with (@href, 'mailto:') and substring (@href, 8) != .">
        <text> &lt;</text>
        <value-of select="substring (@href, 8)" />
        <text>&gt;</text>
      </when>
    </choose>
  </template>

  <template match="h:img">
    <text>[Image: </text>
    <!-- search for an alt text -->
    <choose>
      <when test="string-length (@alt) > 0">
        <call-template name="gettext">
          <with-param name="node" select="@alt" />
        </call-template>
      </when>
      <otherwise>
        <value-of select="@src" />
      </otherwise>
    </choose>
    <text>]</text>
  </template>

</stylesheet>

<%@ page contentType="text/html; charset=GBK" %>
<%@page isErrorPage="true"%>
<HTML><HEAD><TITLE>信息提示</TITLE>
<LINK
href="images/css0.css" type=text/css rel=stylesheet>

</script>
</HEAD>

<BODY>
<P><br>
</P>
<TABLE width="358" height="93" border=0 align=center cellPadding=3 cellSpacing=1>
  <TBODY>
    <TR class=S4>
      <TD width="40%" height="22">
        <DIV align=center><SPAN class="bt FONT1">错误信息</SPAN></DIV></TD>
    </TR>
    <TR class=S2>
      <TD vAlign=top><div align="center">
<%=exception%><br>

        </div>
        <P align="center" style="LINE-HEIGHT: 16pt"><SPAN class=bt>

          </SPAN></P></TD>
    </TR>
    <TR class=S2>
      <TD height="20" vAlign=top>
<div align="center">

      <A HREF="javascript:history.back()">〖 返回 〗</A>

	  </div></TD>
    </TR>
  </TBODY>
</TABLE>
</BODY></HTML>

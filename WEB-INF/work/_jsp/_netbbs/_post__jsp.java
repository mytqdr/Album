/*
 * JSP generated by Resin Professional 4.0.44 (built Wed, 22 Apr 2015 02:04:40 PDT)
 */

package _jsp._netbbs;
import javax.servlet.*;
import javax.servlet.jsp.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import java.text.*;
import org.hibernate.*;
import net.*;
import org.hibernate.cfg.Configuration;

public class _post__jsp extends com.caucho.jsp.JavaPage
{
  private static final java.util.HashMap<String,java.lang.reflect.Method> _jsp_functionMap = new java.util.HashMap<String,java.lang.reflect.Method>();
  private boolean _caucho_isDead;
  private boolean _caucho_isNotModified;
  private com.caucho.jsp.PageManager _jsp_pageManager;
  
  public void
  _jspService(javax.servlet.http.HttpServletRequest request,
              javax.servlet.http.HttpServletResponse response)
    throws java.io.IOException, javax.servlet.ServletException
  {
    javax.servlet.http.HttpSession session = request.getSession(true);
    com.caucho.server.webapp.WebApp _jsp_application = _caucho_getApplication();
    com.caucho.jsp.PageContextImpl pageContext = _jsp_pageManager.allocatePageContext(this, _jsp_application, request, response, "/netbbs/errorPage.jsp", session, 8192, true, false);

    TagState _jsp_state = null;

    try {
      _jspService(request, response, pageContext, _jsp_application, session, _jsp_state);
    } catch (java.lang.Throwable _jsp_e) {
      pageContext.handlePageException(_jsp_e);
    } finally {
      _jsp_pageManager.freePageContext(pageContext);
    }
  }
  
  private void
  _jspService(javax.servlet.http.HttpServletRequest request,
              javax.servlet.http.HttpServletResponse response,
              com.caucho.jsp.PageContextImpl pageContext,
              javax.servlet.ServletContext application,
              javax.servlet.http.HttpSession session,
              TagState _jsp_state)
    throws Throwable
  {
    javax.servlet.jsp.JspWriter out = pageContext.getOut();
    final javax.el.ELContext _jsp_env = pageContext.getELContext();
    javax.servlet.ServletConfig config = getServletConfig();
    javax.servlet.Servlet page = this;
    javax.servlet.jsp.tagext.JspTag _jsp_parent_tag = null;
    com.caucho.jsp.PageContextImpl _jsp_parentContext = pageContext;
    response.setContentType("text/html; charset=utf-8");

    out.write(_jsp_string0, 0, _jsp_string0.length);
    
util sql = new util();
sql.begin();
Session hsession = sql.getSession();
hsession.beginTransaction();   //hibernate\u521d\u59cb\u5316

java.util.Date date= new java.util.Date();//\u521b\u5efa\u4e00\u4e2a\u65f6\u95f4\u5bf9\u8c61\uff0c\u83b7\u53d6\u5230\u5f53\u524d\u7684\u65f6\u95f4
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//\u8bbe\u7f6e\u65f6\u95f4\u663e\u793a\u683c\u5f0f
String nowtime = sdf.format(date);//\u5c06\u5f53\u524d\u65f6\u95f4\u683c\u5f0f\u5316\u4e3a\u5b57\u7b26\u4e32



String postid = request.getParameter("id");//\u83b7\u53d6\u5e16\u5b50ID

login nlogin = (login)session.getAttribute("login");//\u83b7\u53d6\u767b\u5f55\u4fe1\u606f


String oreplay = (String)session.getAttribute("oreplay");
String rand = request.getParameter("text");//\u9a8c\u8bc1\u7801
String text = request.getParameter("textarea");//\u5185\u5bb9
if(oreplay != null)//\u6709\u8bb0\u5f55\u5c31\u62ff\u51fa\u6765 \u6e05\u7a7asession
{
	session.removeAttribute("oreplay");
}
else
{
	oreplay = "";
}
boolean totop = false;//\u9876\u8d34\u5224\u65ad \u5982\u679c\u6709\u56de\u5e16 \u90a3\u4e48\u5728\u5237\u65b0\u8bbf\u95ee\u4eba\u6570\u65f6\u987a\u5e26\u5237\u65b0\u5e16\u5b50\u7684\u65f6\u95f4
if(rand!=null)//\u5982\u679c\u6709\u9a8c\u8bc1\u7801 \u8bf4\u660e\u6709\u56de\u5e16
{
	if(!rand.equals(session.getAttribute("rand")))//\u9a8c\u8bc1\u7801\u8f93\u5165\u9519\u8bef
	{
		out.print("<script>alert(\"\u9a8c\u8bc1\u7801\u8f93\u5165\u9519\u8bef\uff01\");</script>");
	}
	else
	{
		if(nlogin!=null && nlogin.isIslogin())//\u767b\u5f55\u4e86\u6ca1
		{ 
			
			replay nreplay = new replay();//\u5185\u5bb9
			nreplay.setPoid(nlogin.getId());//\u4e0a\u4f20\u8005ID
			nreplay.setPostid(Integer.parseInt(postid));//\u5e16\u5b50ID
			nreplay.setTime(nowtime);
			nreplay.setMain(text);
			//hsession.clear();
			totop = true; //\u9876\u8d34
			hsession.save(nreplay); 
		//	hsession.getTransaction().commit(); \u63d0\u4ea4\u7531\u4e0b\u9762\u7684\u8ba1\u6570\u5668+1\u4e00\u5e76\u63d0\u4ea4
		} 
		else//\u6ca1\u767b\u5f55\u5c31\u5e2e\u4f60\u6682\u5b58\u4e00\u4e0b\u53d1\u5e16\u7684\u5185\u5bb9 \u767b\u5f55\u4e86\u7ed9\u4f60\u6062\u590d
		{
			session.setAttribute("oreplay",text);
			out.print("<script>alert(\"\u4f60\u5c1a\u672a\u767b\u5f55\uff01\");location.href=\"login.jsp\";</script>");
			return;
		}
	}
}




String delreid = request.getParameter("replayid");//\u83b7\u53d6\u5220\u9664\u8bf7\u6c42
if(delreid != null)//\u5982\u679c\u8981\u5220\u9664
{
	List query2= hsession.createSQLQuery("select replay.* from replay,post where replay.postid = post.id and (replay.poid = "+nlogin.getId()+" or post.poid = "+nlogin.getId()+") and replay.id ="+delreid).addEntity(replay.class).list();//\u5224\u65ad\u6743\u9650 \u767b\u9646\u8005\u662f\u5426\u662f\u5e16\u5b50\u7684\u53d1\u5e03\u8005 or \u56de\u8d34\u53d1\u5e03\u8005
	Iterator rs2 = query2.iterator();
	if(rs2.hasNext())//\u5982\u679c\u662f
	{
	//	out.print("<script>alert(\""+delreid+"\");</script>");
	//\u8981\u5220\u9664\u6574\u4e2a\u5e16\u5b50\u600e\u4e48\u529e \u96be\u641e\u4e86
	//\u601d\u8def \u5728\u8fd9\u91cc\u6574\u4e2a\u5224\u65ad 
	//\u67e5\u8be2\u4e00\u4e0b\u8fd9\u4e2a\u5e16\u5b50\u7b2c\u4e00\u4e2a\u56de\u5e16 \u5982\u679c\u5220\u7684\u662f\u4ed6 \u987a\u5e26\u5220\u9664POST\u91cc\u7684\u6570\u636e
	//\u7136\u540e\u67e5\u51fa\u6240\u6709\u7684\u56de\u5e16 \u62ff\u5faa\u73af \u5168\u5220
	//\u65e9\u77e5\u9053\u6211\u5c31\u628a\u7b2c\u4e00\u4e2a\u56de\u5e16\u653e\u5230POST\u91cc\u4e86
	
	//if(post
 	List query3= hsession.createSQLQuery("select id from replay where postid = "+postid+" order by time LIMIT 1 ").list();//\u83b7\u53d6\u7b2c\u4e00\u4e2a\u56de\u5e16ID
	Iterator rs3 = query3.iterator();
  	int mainreplayid=(int)rs3.next();//\u6574\u8d34\u7684\u7b2c\u4e00\u4e2a\u5e16\u5b50
	String mainid = mainreplayid+"";
	if(delreid.equals(mainid))//\u5982\u679c\u5220\u7684\u662f\u7b2c\u4e00\u4e2a\u5e16\u5b50
	{
		
		//\u6267\u884c\u6574\u8d34\u5220\u9664 \u5305\u62ec \u5220\u9664POST\u8bb0\u5f55  \u5220\u9664replay\u91cc postid \u7b49\u4e8e post\u7684id\u7684\u8bb0\u5f55
		
		//\u7b2c\u4e00\u90e8\u5206 \u5220\u9664post
		List query4= hsession.createSQLQuery("select * from post where id ="+postid).addEntity(post.class).list();//\u83b7\u53d6\u7b2c\u4e00\u4e2a\u56de\u5e16ID
		Iterator rs4 = query4.iterator();//\u67e5\u51fapost\u8bb0\u5f55
		post delpost =(post)rs4.next();//\u5b9e\u4f8b\u5316
		hsession.delete(delpost);//\u5220\u9664
		
		//\u7b2c\u4e8c\u90e8\u5206 \u5220\u9664\u5bf9\u5e94replay
		List query5= hsession.createSQLQuery("select * from replay where postid ="+postid).addEntity(replay.class).list();//\u83b7\u53d6\u7b2c\u4e00\u4e2a\u56de\u5e16ID
		Iterator rs5 = query5.iterator();//\u67e5\u51fapost\u8bb0\u5f55
		//\u5faa\u73af\u5220\u9664
		while(rs5.hasNext())
		{
			replay delreplay =(replay)rs5.next();//\u5b9e\u4f8b\u5316
			hsession.delete(delreplay);//\u5220\u9664
		}
		//\u56e0\u4e3a\u8fd9\u4e2a\u9875\u9762\u8981\u88ab\u5220\u9664 \u63d0\u4ea4 \u8df3\u51fa
		hsession.getTransaction().commit(); //\u63d0\u4ea4
		out.print("<script>alert(\"\u6574\u4e2a\u5e16\u5b50\u5df2\u88ab\u5220\u9664\uff01\");location.href=\"index.jsp\";</script>");
		return;//\u8df3\u51fa
		
	}
	replay delreplay =(replay)rs2.next(); //\u83b7\u53d6\u5355\u8d34\u5b9e\u4f8b	
	hsession.delete(delreplay);//\u5220\u9664 \u63d0\u4ea4\u7531\u4e0b\u9762\u7684\u8ba1\u6570\u5668+1\u4e00\u5e76\u63d0\u4ea4
	out.print("<script>alert(\"\u5e16\u5b50\u5df2\u5220\u9664!\");</script>");
 // 	hsession.getTransaction().commit();
	}
	else//\u5982\u679c\u4e0d\u662f
	{
		out.print("<script>alert(\"\u5220\u9664\u5931\u8d25!\u65e0\u6743\u9650\u6216\u5e16\u5b50\u4e0d\u5b58\u5728!\");</script>");
	}
}

if(postid == null)//\u5982\u679c\u6ca1\u6709\u5e16\u5b50ID
{
	out.print("<script>alert(\"\u5e16\u5b50\u4e0d\u5b58\u5728\uff01\");location.href=\"index.jsp\";</script>");
//	response.sendRedirect("index.jsp"); 
	return;
}
List query1= hsession.createSQLQuery("select * from post WHERE id = "+postid).addEntity(post.class).list();
Iterator rs1 = query1.iterator();//\u67e5\u8be2\u5e16\u5b50\u4fe1\u606f
String title = "";//\u5e16\u5b50\u6807\u9898
int thispoid;//\u5e16\u5b50ID
int viewers;//\u5e16\u5b50\u6d4f\u89c8\u4eba\u6570
if(rs1.hasNext())//\u5982\u679c\u5e16\u5b50\u5b58\u5728
{
	post thispost =(post)rs1.next(); //\u5b9e\u4f8b\u7ed9\u53d8\u91cf\u8d4b\u503c
	thispoid = thispost.getId();
	title = thispost.getTitle();
	viewers = thispost.getViewers();
	thispost.setViewers(++viewers);
	
	if(totop)//\u5237\u65b0\u65f6\u95f4\u4ee5\u9876\u8d34
	{
		thispost.setTime(nowtime);
	}
	
	hsession.save(thispost); //\u4fdd\u5b58\u5b9e\u4f8b
	hsession.getTransaction().commit(); 
}
else
{
	out.print("<script>alert(\"\u5e16\u5b50\u4e0d\u5b58\u5728\uff01\");location.href=\"index.jsp\";</script>");
//	response.sendRedirect("index.jsp"); 
	return;
} 
	
	



    out.write(_jsp_string1, 0, _jsp_string1.length);
    out.print((title));
    out.write(_jsp_string2, 0, _jsp_string2.length);
    
	if(nlogin!=null && nlogin.isIslogin())//\u6309\u7167\u662f\u5426\u767b\u5f55\u6765\u51b3\u5b9a\u8f93\u51fa\u5185\u5bb9
	{
		out.print("\u4f60\u597d,"+nlogin.getUsername());
		
	}
	else
	{
		out.print("\u4f60\u5c1a\u672a\u767b\u5f55.");
	}
    
    out.write(_jsp_string3, 0, _jsp_string3.length);
    
	
	if(nlogin!=null && nlogin.isIslogin())//\u6309\u7167\u662f\u5426\u767b\u5f55\u6765\u51b3\u5b9a\u8f93\u51fa\u5185\u5bb9
	{
		out.print("<a href=\"logout.jsp\">\u6ce8\u9500</a>");
	}
	else
	{
		out.print("<a href=\"login.jsp\">\u767b\u5f55</a>");
	}
	
	
	
    out.write(_jsp_string4, 0, _jsp_string4.length);
    out.print((title));
    out.write(_jsp_string5, 0, _jsp_string5.length);
    out.print((viewers));
    out.write(_jsp_string6, 0, _jsp_string6.length);
    
List query= hsession.createSQLQuery("select user.username as username,user.icon as icon,user.point as point,replay.id as replayid,replay.time as time,replay.main as main,replay.poid as poid from user,replay,post where post.id=replay.postid and user.id = replay.poid and replay.postid ="+postid+" order by replay.time").list();
Iterator rs = query.iterator();//\u4ece\u6570\u636e\u5e93\u83b7\u53d6\u56de\u5e16\u4fe1\u606f

while(rs.hasNext())
{
	Object[] replay=(Object[])rs.next();//\u5b9e\u4f8b\u8d4b\u503c
    String nusername=(String)replay[0];
	String nicon=(String)replay[1];
	int point=(int)replay[2];
	int nreplayid=(int)replay[3];
	String ntime=(String)replay[4];
	String nmain=(String)replay[5];
	int npoid=(int)replay[6];
	
	String icon ="default.jpg" ;//\u9ed8\u8ba4\u5934\u50cf
	if(!nicon.equals(""))
	{
		icon = nicon;
	}
 	String button = "";
	if(nlogin!=null && nlogin.isIslogin())//\u5224\u65ad\u662f\u5426\u6709\u6743\u9650\u6765\u5220\u9664\u5e16\u5b50 
	{
		if(nlogin.getId()== npoid || nlogin.getId()== thispoid)//\u82e5\u662f \u8f93\u51fa\u4e00\u4e2a\u5220\u9664\u6309\u94ae\u7528\u4ee5\u63d0\u4ea4\u5220\u9664\u8bf7\u6c42
		{
			button= "<input type=\"button\" name=\"button\" id=\"button\" value=\"\u5220\u9664\"  onClick=\"delsubmit("+nreplayid+");\" />";//\u5220\u9664\u6309\u94ae \u901a\u8fc7JS\u628a\u5e16\u5b50\u7684ID\u4f20\u7ed9\u9690\u85cf\u8868\u5355 \u518d\u7528POST\u63d0\u4ea4\u7ed9\u672c\u9875
		}
	}
	//if()
out.print("<tr><td width=\"146\" height=\"165\" align=\"center\" valign=\"middle\"><img src=\"image/"+icon+"\" width=\"120\" height=\"120\"/></p>"+nusername+"</td><td colspan=\"2\" align=\"left\" valign=\"top\"><p>"+nmain+"</td></tr><tr><td height=\"23\"></td><td width=\"271\" align=\"left\" valign=\"bottom\">"+button+"</td><td width=\"291\" align=\"right\" valign=\"bottom\">"+ntime+"</td></tr>");//\u8f93\u51fa\u56de\u5e16\u5185\u5bb9
  
  }
  
hsession.close(); //\u4e0d\u60f3\u670d\u52a1\u5668\u5185\u5b58\u6ea2\u51fa\u7684\u8bdd

    out.write(_jsp_string7, 0, _jsp_string7.length);
    out.print((oreplay));
    out.write(_jsp_string8, 0, _jsp_string8.length);
  }

  private com.caucho.make.DependencyContainer _caucho_depends
    = new com.caucho.make.DependencyContainer();

  public java.util.ArrayList<com.caucho.vfs.Dependency> _caucho_getDependList()
  {
    return _caucho_depends.getDependencies();
  }

  public void _caucho_addDepend(com.caucho.vfs.PersistentDependency depend)
  {
    super._caucho_addDepend(depend);
    _caucho_depends.add(depend);
  }

  protected void _caucho_setNeverModified(boolean isNotModified)
  {
    _caucho_isNotModified = true;
  }

  public boolean _caucho_isModified()
  {
    if (_caucho_isDead)
      return true;

    if (_caucho_isNotModified)
      return false;

    if (com.caucho.server.util.CauchoSystem.getVersionId() != -7371470110589488364L)
      return true;

    return _caucho_depends.isModified();
  }

  public long _caucho_lastModified()
  {
    return 0;
  }

  public void destroy()
  {
      _caucho_isDead = true;
      super.destroy();
    TagState tagState;
  }

  public void init(com.caucho.vfs.Path appDir)
    throws javax.servlet.ServletException
  {
    com.caucho.vfs.Path resinHome = com.caucho.server.util.CauchoSystem.getResinHome();
    com.caucho.vfs.MergePath mergePath = new com.caucho.vfs.MergePath();
    mergePath.addMergePath(appDir);
    mergePath.addMergePath(resinHome);
    com.caucho.loader.DynamicClassLoader loader;
    loader = (com.caucho.loader.DynamicClassLoader) getClass().getClassLoader();
    String resourcePath = loader.getResourcePathSpecificFirst();
    mergePath.addClassPath(resourcePath);
    com.caucho.vfs.Depend depend;
    depend = new com.caucho.vfs.Depend(appDir.lookup("netbbs/post.jsp"), -3635644174528333L, false);
    _caucho_depends.add(depend);
  }

  final static class TagState {

    void release()
    {
    }
  }

  public java.util.HashMap<String,java.lang.reflect.Method> _caucho_getFunctionMap()
  {
    return _jsp_functionMap;
  }

  public void caucho_init(ServletConfig config)
  {
    try {
      com.caucho.server.webapp.WebApp webApp
        = (com.caucho.server.webapp.WebApp) config.getServletContext();
      init(config);
      if (com.caucho.jsp.JspManager.getCheckInterval() >= 0)
        _caucho_depends.setCheckInterval(com.caucho.jsp.JspManager.getCheckInterval());
      _jsp_pageManager = webApp.getJspApplicationContext().getPageManager();
      com.caucho.jsp.TaglibManager manager = webApp.getJspApplicationContext().getTaglibManager();
      com.caucho.jsp.PageContextImpl pageContext = new com.caucho.jsp.InitPageContextImpl(webApp, this);
    } catch (Exception e) {
      throw com.caucho.config.ConfigException.create(e);
    }
  }

  private final static char []_jsp_string0;
  private final static char []_jsp_string7;
  private final static char []_jsp_string3;
  private final static char []_jsp_string5;
  private final static char []_jsp_string6;
  private final static char []_jsp_string4;
  private final static char []_jsp_string8;
  private final static char []_jsp_string1;
  private final static char []_jsp_string2;
  static {
    _jsp_string0 = "\r\n<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n".toCharArray();
    _jsp_string7 = "\r\n<tr><td  colspan=\"3\" ><table  width=\"730\"  border=\"0\">\r\n<form action=\"#\" method=\"post\" name=\"form2\" id=\"form2\">\r\n <tr>\r\n   <td width=\"179\"> </td><td colspan=\"2\">\r\n    <textarea name=\"textarea\" id=\"textarea\" cols=\"45\" rows=\"5\" >".toCharArray();
    _jsp_string3 = "\r\n    </td>\r\n    <td width=\"293\" align=\"right\">\r\n     ".toCharArray();
    _jsp_string5 = "</a></td>\r\n    <td width=\"197\" height=\"33\" align=\"right\" valign=\"middle\">\u5df2\u88ab\u8bbf\u95ee".toCharArray();
    _jsp_string6 = "\u6b21\r\n    </td>\r\n  </tr>\r\n </table>\r\n    </td>\r\n  </tr>\r\n".toCharArray();
    _jsp_string4 = " \r\n    </td>\r\n    <td width=\"201\">\r\n    \r\n    \r\n    &nbsp;&nbsp;&nbsp;\r\n    \r\n    <a href=\"register.jsp\">\u6ce8\u518c</a></td>\r\n  </tr>\r\n </table>\r\n </td>\r\n  <tr><td colspan=\"3\" >\r\n  <table width=\"730\" border=\"0\">\r\n  <tr>\r\n  	<td width=\"178\"><a href=\"../\">DrCy's Space</a>&gt;&gt;<a href=\"bbs.jsp\">\u8bba\u575b</a>&gt;&gt;</td>\r\n    <td width=\"341\" height=\"33\" align=\"center\" valign=\"middle\"><a href=\"#\">".toCharArray();
    _jsp_string8 = "</textarea></td><td width=\"195\" ></td>\r\n</tr>\r\n  <tr><td></td><td width=\"218\">\r\n    <input type=\"submit\" name=\"button\" id=\"button\" value=\"\u53d1\u8868\" />\r\n    <input type=\"text\" name=\"text\" id=\"text\" /></td><td width=\"120\">\r\n  <img src=\"../randCodeImage\" /></td>\r\n    <td>  </td></tr>\r\n</form></table></table></div>\r\n</body>\r\n</html>".toCharArray();
    _jsp_string1 = "\r\n<head>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\r\n<title>".toCharArray();
    _jsp_string2 = "-netbbs</title>\r\n</head>\r\n<script type=\"text/javascript\">  //\u5904\u7406\u5220\u9664\u7684\u786e\u8ba4\r\nfunction delsubmit(reid) {  \r\n    var result = confirm(\"\u662f\u5426\u5220\u9664\u6b64\u8d34?\");  \r\n    if (result == true) {  \r\n    //    alert(\"\u5e16\u5b50\u5df2\u5220\u9664.\"); \r\n		document.getElementById('replayid').value =reid;\r\n		document.form1.submit();\r\n    }\r\n}  \r\n</script>  \r\n<body>\r\n<div align=\"center\">\r\n\r\n<form id=\"form1\" name=\"form1\" method=\"post\" action=\"#\">\r\n<input name=\"replayid\" id=\"replayid\" type=\"hidden\" value=\"\" />\r\n</form>\r\n<table width=\"730\" border=\"1\">\r\n  <tr>\r\n  <td colspan=\"3\" >\r\n  <table width=\"730\" border=\"0\">\r\n  <tr>\r\n    <td width=\"222\">\r\n    ".toCharArray();
  }
}
/*
 * JSP generated by Resin Professional 4.0.44 (built Wed, 22 Apr 2015 02:04:40 PDT)
 */

package _jsp;
import javax.servlet.*;
import javax.servlet.jsp.*;
import javax.servlet.http.*;

public class _b__jsp extends com.caucho.jsp.JavaPage
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
    com.caucho.server.webapp.WebApp _jsp_application = _caucho_getApplication();
    com.caucho.jsp.PageContextImpl pageContext = _jsp_pageManager.allocatePageContext(this, _jsp_application, request, response, null, null, 8192, true, false);

    TagState _jsp_state = null;

    try {
      _jspService(request, response, pageContext, _jsp_application, _jsp_state);
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
              TagState _jsp_state)
    throws Throwable
  {
    javax.servlet.jsp.JspWriter out = pageContext.getOut();
    final javax.el.ELContext _jsp_env = pageContext.getELContext();
    javax.servlet.ServletConfig config = getServletConfig();
    javax.servlet.Servlet page = this;
    javax.servlet.jsp.tagext.JspTag _jsp_parent_tag = null;
    com.caucho.jsp.PageContextImpl _jsp_parentContext = pageContext;
    response.setContentType("text/html");

    out.write(_jsp_string0, 0, _jsp_string0.length);
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
    depend = new com.caucho.vfs.Depend(appDir.lookup("b.jsp"), 8514311859982063955L, false);
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
  static {
    _jsp_string0 = "<!DOCTYPE html>\r\n<html style=\"height: 100%\">\r\n   <head>\r\n       <meta charset=\"utf-8\">\r\n   </head>\r\n   <body style=\"height: 100%; margin: 0\">\r\n       <div id=\"container\" style=\"height: 100%\"></div>\r\n       <script language=\"javascript\" src=\"/js/echarts.min.js\" charset=\"utf-8\"></script>\r\n       <script type=\"text/javascript\">\r\nvar dom = document.getElementById(\"container\");\r\nvar myChart = echarts.init(dom);\r\nvar app = {};\r\noption = null;\r\noption = {\r\n    backgroundColor: '#2c343c',\r\n    visualMap: {\r\n        show: false,\r\n        min: 80,\r\n        max: 600,\r\n        inRange: {\r\n            colorLightness: [0, 1]\r\n        }\r\n    },\r\n    series : [\r\n        {\r\n            name: '\u00e8\u00ae\u00bf\u00e9\u0097\u00ae\u00e6\u009d\u00a5\u00e6\u00ba\u0090',\r\n            type: 'pie',\r\n            radius: '55%',\r\n            data:[\r\n                {value:235, name:'\u00e8\u00a7\u0086\u00e9\u00a2\u0091\u00e5\u00b9\u00bf\u00e5\u0091\u008a'},\r\n                {value:274, name:'\u00e8\u0081\u0094\u00e7\u009b\u009f\u00e5\u00b9\u00bf\u00e5\u0091\u008a'},\r\n                {value:310, name:'\u00e9\u0082\u00ae\u00e4\u00bb\u00b6\u00e8\u0090\u00a5\u00e9\u0094\u0080'},\r\n                {value:335, name:'\u00e7\u009b\u00b4\u00e6\u008e\u00a5\u00e8\u00ae\u00bf\u00e9\u0097\u00ae'},\r\n                {value:400, name:'\u00e6\u0090\u009c\u00e7\u00b4\u00a2\u00e5\u00bc\u0095\u00e6\u0093\u008e'}\r\n            ],\r\n            roseType: 'angle',\r\n            label: {\r\n                normal: {\r\n                    textStyle: {\r\n                        color: 'rgba(255, 255, 255, 0.3)'\r\n                    }\r\n                }\r\n            },\r\n            labelLine: {\r\n                normal: {\r\n                    lineStyle: {\r\n                        color: 'rgba(255, 255, 255, 0.3)'\r\n                    }\r\n                }\r\n            },\r\n            itemStyle: {\r\n                normal: {\r\n                    color: '#c23531',\r\n                    shadowBlur: 200,\r\n                    shadowColor: 'rgba(0, 0, 0, 0.5)'\r\n                }\r\n            }\r\n        }\r\n    ]\r\n};;\r\nif (option && typeof option === \"object\") {\r\n    myChart.setOption(option, true);\r\n}\r\n       </script>\r\n   </body>\r\n</html>".toCharArray();
  }
}

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
  pageContext.setAttribute( "now", new java.util.Date() );
  pageContext.setAttribute( "paramMap", request.getParameterMap() );
  java.util.Map headerMap = new java.util.HashMap();
  java.util.Enumeration e = request.getHeaderNames();
  while (e.hasMoreElements()) {
    String headerName = (String)e.nextElement();
    headerMap.put( headerName, request.getHeader( headerName ) );
    pageContext.setAttribute( "headerMap", headerMap );
  }
  System.out.println(request.getMethod());
%>
<html>
  <head>
    <title>Request Inspector</title>
    <link rel="stylesheet" type="text/css" href="styles.css"/>
  </head>
  
  <body>

    <div>
      <label>Time:</label> <fmt:formatDate value="${now}" pattern="MMM d, yyyy hh:mm:ss"/>
    </div>

    <div>
      <label>Method:</label> ${pageContext.request.method}
    </div>

    <div>
      <label>Query string:</label> ${pageContext.request.queryString}
    </div>

    <div>
      <label>Headers:</label><br/>
      <ul>
        <c:forEach items="${headerMap}" var="item">
          <li>${item}</li>
        </c:forEach>
      </ul>
    </div>

    <div>
      <label>Parameters:</label><br/>
      <ul>
        <c:forEach items="${paramMap}" var="item">
          <li>${item.key}=${item.value[0]}</li>
        </c:forEach>
      </ul>
    </div>

  </body>
  
</html>

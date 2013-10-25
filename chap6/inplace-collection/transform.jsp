<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% Thread.sleep(3000); %>
${fn:toUpperCase(param.value)}

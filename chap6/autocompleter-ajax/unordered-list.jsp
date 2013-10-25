<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<ul>
  <c:forEach items="${list}" var="item">
    <li>${item}</li>
  </c:forEach>
</ul>

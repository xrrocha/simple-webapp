<%@ page import="java.util.*" %>
<%
    Map<String, String> properties = (Map<String, String>) session.getAttribute("properties");
    if (properties == null) {
        properties = new HashMap<String, String>();
        session.setAttribute("properties", properties);
    }

    String[] names = request.getParameterValues("name");
    if (names != null) {
        String[] values = request.getParameterValues("value");
        for (int i = 0; i < names.length; i++) {
            String delete = request.getParameter("delete_" + i);
            if (delete != null) {
                properties.remove(names[i]);
            } else {
                properties.put(names[i], values[i]);
            }
        }
    }

    String propertyNameParameter = request.getParameter("propertyName");
    if (propertyNameParameter != null) {
        String newPropertyName = propertyNameParameter.trim();
        if (newPropertyName.length() > 0) {
            String newPropertyValue = request.getParameter("propertyValue").trim();
            properties.put(newPropertyName, newPropertyValue);
        }
    }
%>
<html>
    <head>
        <title>Simple Webapp</title>
    </head>
<body>
    <h2>Simple Webapp</h2>
    <p>
        Enter and/or delete properties
    </p>
    <form method="post">
        <table>
            <thead>
                <tr>
                    <th>Delete?</th>
                    <th>Property Name</th>
                    <th>Property Value</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>&nbsp;</td>
                    <td><input name="propertyName" size="16"></td>
                    <td><input name="propertyValue" size="64"></td>
                </tr>
                <%
                    List<String> propertyNames = new ArrayList<String>(properties.keySet());
                    Collections.sort(propertyNames);
                    for (int i = 0; i < propertyNames.size(); i++) {
                        String propertyName = propertyNames.get(i);%>
                        <tr>
                            <td><input name="delete_<%= i %>" type="checkbox"></td>
                            <td>
                                <%= propertyName %>
                                <input name="name" type="hidden" value="<%= propertyName %>">
                            </td>
                            <td><input name="value" value="<%= properties.get(propertyName) %>" size="64"></td>
                        </tr>
                    <%}
                %>
            </tbody>
        </table>
        <div style="text-align: center;">
            <input type="submit" value="Submit">
        </div>
    </form>
</body>
</html>

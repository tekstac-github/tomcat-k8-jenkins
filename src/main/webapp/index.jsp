<html>
<body>
<h2>Hello World!</h2>
<p>
Current Build Tag from ENV Variable: <% out.print(System.getenv("BUILD_TAG")); %><br />
Previous Build Tag from ENV Variable: <% out.print(System.getenv("CUSTOM_STRING")); %>
</p>
</body>
</html>

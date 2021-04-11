<html>
<body>
<h1>Hello World!</h1>
<h2>Let's Copy Artifacts! Again!</h2>
<h3>If you see me, all works fine!</h3>
<p>
Current Build Tag from ENV Variable: <% out.print(System.getenv("BUILD_TAG")); %><br />
Previous Build Tag from ENV Variable: <% out.print(System.getenv("CUSTOM_STRING")); %>
</p>
</body>
</html>

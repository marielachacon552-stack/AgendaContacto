<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 10/6/2026
  Time: 19:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión - Agenda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex justify-content-center align-items-center" style="height: 100vh;">

<%
    // Lógica del Login
    String mensajeError = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String usuario = request.getParameter("user");
        String pass = request.getParameter("pass");

        // Validamos credenciales
        if ("admin".equals(usuario) && "1234".equals(pass)) {
            session.setAttribute("logueado", true);
            response.sendRedirect("index.jsp");
            return; // Detenemos la ejecución para redirigir
        } else {
            mensajeError = "Usuario o contraseña incorrectos.";
        }
    }
%>

<div class="card shadow p-4" style="width: 350px;">
    <h3 class="text-center mb-4">Agenda Contactos</h3>

    <form method="POST">
        <div class="mb-3">
            <label class="form-label">Usuario</label>
            <input type="text" name="user" class="form-control" placeholder="admin" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Contraseña</label>
            <input type="password" name="pass" class="form-control" placeholder="****" required>
        </div>

        <button type="submit" class="btn btn-primary w-100">Ingresar</button>

        <%-- Mostramos el error si existe --%>
        <% if (!mensajeError.isEmpty()) { %>
        <div class="alert alert-danger mt-3 p-2 text-center" role="alert">
            <%= mensajeError %>
        </div>
        <% } %>
    </form>
</div>

</body>
</html>

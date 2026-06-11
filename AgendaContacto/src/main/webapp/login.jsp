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
    <style>
        @keyframes gradientFlow {
            0% { 
                background-position: 0% 0%;
                background: linear-gradient(45deg, #001a4d 0%, #003d99 25%, #0066cc 50%, #004d99 75%, #001a4d 100%);
            }
            25% { 
                background-position: 100% 100%;
                background: linear-gradient(225deg, #003d99 0%, #0066cc 25%, #00a3e0 50%, #0088bb 75%, #003d99 100%);
            }
            50% { 
                background-position: 0% 100%;
                background: linear-gradient(135deg, #0066cc 0%, #00a3e0 25%, #006666 50%, #004d4d 75%, #0066cc 100%);
            }
            75% { 
                background-position: 100% 0%;
                background: linear-gradient(315deg, #00a3e0 0%, #006666 25%, #2d004d 50%, #1a0033 75%, #00a3e0 100%);
            }
            100% { 
                background-position: 0% 0%;
                background: linear-gradient(45deg, #001a4d 0%, #003d99 25%, #0066cc 50%, #004d99 75%, #001a4d 100%);
            }
        }

        body {
            animation: gradientFlow 40s ease-in-out infinite;
            background-size: 200% 200%;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
    </style>
</head>
<body class="d-flex justify-content-center align-items-center">

<%
    // Lógica del Login y Logout
    String mensajeError = "";
    
    // Invalidar sesión si se cierra sesión
    String logout = request.getParameter("logout");
    if ("true".equals(logout)) {
        session.invalidate();
        response.sendRedirect("login.jsp");
        return;
    }
    
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

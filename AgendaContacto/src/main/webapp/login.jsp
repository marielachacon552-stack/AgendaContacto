<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 10/6/2026
  Time: 19:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Login | ContactApp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); height: 100vh; display: flex; align-items: center; justify-content: center; margin: 0; }
        .glass-card { background: rgba(255, 255, 255, 0.15); backdrop-filter: blur(10px); border: 1px solid rgba(255, 255, 255, 0.2); border-radius: 20px; padding: 40px; width: 400px; color: white; box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3); }
        .btn-login { background: linear-gradient(to right, #3a7bd5, #00d2ff); border: none; color: white; font-weight: 500; transition: 0.3s; }
        .form-control { background: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.3); color: white; }
    </style>
</head>
<body>
<div class="glass-card text-center">
    <h2 class="mb-4 fw-bold">ContactApp</h2>
    <form method="POST">
        <input type="text" name="user" class="form-control mb-3" placeholder="Usuario" required>
        <input type="password" name="pass" class="form-control mb-4" placeholder="Contraseña" required>
        <button type="submit" class="btn btn-login w-100 py-2">INGRESAR</button>
    </form>
    <% if ("POST".equalsIgnoreCase(request.getMethod())) {
        if ("admin".equals(request.getParameter("user")) && "1234".equals(request.getParameter("pass"))) {
            session.setAttribute("logueado", true);
            response.sendRedirect("index.jsp");
        } else { %><div class="mt-3 text-warning small">Credenciales incorrectas.</div><% }} %>
</div>
</body>
</html>

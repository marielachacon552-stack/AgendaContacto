<%@ page import="java.util.*, com.agenda.modelo.Contacto" %>
<%
    if(session.getAttribute("logueado") == null) { response.sendRedirect("login.jsp"); return; }

    // Inicializar lista en memoria
    if(application.getAttribute("contactos") == null) application.setAttribute("contactos", new ArrayList<Contacto>());
    List<Contacto> lista = (List<Contacto>) application.getAttribute("contactos");

    String action = request.getParameter("action");
    if("add".equals(action)) {
        int id = lista.size() + 1;
        lista.add(new Contacto(id, request.getParameter("nombre"), request.getParameter("telefono")));
    } else if("delete".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        lista.removeIf(c -> c.getId() == id);
    } else if("update".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        for(Contacto c : lista) {
            if(c.getId() == id) {
                c.setNombre(request.getParameter("nombre"));
                c.setTelefono(request.getParameter("telefono"));
            }
        }
    }
%>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Agenda</title>
</head>
<body class="container mt-4">
<div class="d-flex justify-content-between">
    <h2>Mis Contactos</h2>
    <a href="login.jsp" class="btn btn-danger">Cerrar Sesión</a>
</div>
<form method="POST" action="index.jsp?action=add" class="row g-3 my-3">
    <div class="col"><input type="text" name="nombre" class="form-control" placeholder="Nombre" required></div>
    <div class="col"><input type="text" name="telefono" class="form-control" placeholder="Teléfono" required></div>
    <div class="col"><button type="submit" class="btn btn-success">Agregar</button></div>
</form>
<table class="table table-hover shadow">
    <thead class="table-dark"><tr><th>Nombre</th><th>Teléfono</th><th>Acciones</th></tr></thead>
    <tbody>
    <% for(Contacto c : lista) { %>
    <tr>
        <form method="POST" action="index.jsp?action=update&id=<%=c.getId()%>">
            <td><input type="text" name="nombre" value="<%=c.getNombre()%>" class="form-control"></td>
            <td><input type="text" name="telefono" value="<%=c.getTelefono()%>" class="form-control"></td>
            <td>
                <button type="submit" class="btn btn-warning">Editar</button>
                <a href="index.jsp?action=delete&id=<%=c.getId()%>" class="btn btn-danger">Eliminar</a>
            </td>
        </form>
    </tr>
    <% } %>
    </tbody>
</table>
</body>
</html>
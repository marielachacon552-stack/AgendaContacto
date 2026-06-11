<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.agenda.modelo.Contacto" %>
<%
    if (session.getAttribute("logueado") == null) { response.sendRedirect("login.jsp"); return; }
    if (application.getAttribute("contactos") == null) application.setAttribute("contactos", new ArrayList<Contacto>());
    List<Contacto> lista = (List<Contacto>) application.getAttribute("contactos");

    String action = request.getParameter("action");
    if ("add".equals(action)) {
        lista.add(new Contacto((int)(Math.random()*10000), request.getParameter("nombre"), request.getParameter("telefono"), request.getParameter("correo")));
    } else if ("delete".equals(action)) {
        lista.removeIf(c -> c.getId() == Integer.parseInt(request.getParameter("id")));
    } else if ("update".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        for (Contacto c : lista) {
            if (c.getId() == id) {
                c.setNombre(request.getParameter("nombre")); c.setTelefono(request.getParameter("telefono")); c.setCorreo(request.getParameter("correo"));
            }
        }
    }
%>
<html>
<head>
    <title>Dashboard | ContactApp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body { font-family: 'Poppins', sans-serif; background: #f0f2f5; }
        .navbar { background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); }
        .avatar { width: 40px; height: 40px; background: #e3f2fd; color: #1e3c72; display: flex; align-items: center; justify-content: center; border-radius: 50%; font-weight: bold; }
    </style>
    <script>
        function confirmarEliminar(id) {
            Swal.fire({
                title: '¿Estás seguro?',
                text: "¡No podrás revertir esta acción!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc3545',
                cancelButtonColor: '#6c757d',
                confirmButtonText: 'Sí, eliminar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = "index.jsp?action=delete&id=" + id;
                }
            })
        }
    </script>
</head>
<body>
<nav class="navbar navbar-dark py-3"><div class="container"><span class="navbar-brand fw-bold"><i class="fa-solid fa-address-book me-2"></i> ContactApp</span><a href="login.jsp" class="btn btn-sm btn-outline-light"><i class="fa-solid fa-right-from-bracket"></i> Salir</a></div></nav>
<div class="container py-5">
    <div class="card p-4 mb-5 shadow-sm border-0">
        <h5 class="mb-4 fw-bold"><i class="fa-solid fa-plus-circle me-2 text-primary"></i>Nuevo Contacto</h5>
        <form method="POST" action="index.jsp?action=add" class="row g-3">
            <div class="col-md-3"><input type="text" name="nombre" class="form-control" placeholder="Nombre" required></div>
            <div class="col-md-3"><input type="text" name="telefono" class="form-control" placeholder="Teléfono" required></div>
            <div class="col-md-4"><input type="email" name="correo" class="form-control" placeholder="Correo" required></div>
            <div class="col-md-2"><button type="submit" class="btn btn-primary w-100 fw-bold">GUARDAR</button></div>
        </form>
    </div>
    <table class="table table-hover align-middle shadow-sm bg-white border">
        <thead><tr><th>Persona</th><th>Teléfono</th><th>Correo</th><th class="text-center">Acciones</th></tr></thead>
        <tbody>
        <% for (Contacto c : lista) { %>
        <tr>
            <form method="POST" action="index.jsp?action=update&id=<%=c.getId()%>">
                <td><div class="d-flex align-items-center"><div class="avatar me-3"><%= c.getNombre().substring(0,1).toUpperCase() %></div><input type="text" name="nombre" value="<%=c.getNombre()%>" class="form-control-plaintext" readonly></div></td>
                <td><input type="text" name="telefono" value="<%=c.getTelefono()%>" class="form-control-plaintext" readonly></td>
                <td><input type="email" name="correo" value="<%=c.getCorreo()%>" class="form-control-plaintext" readonly></td>
                <td class="text-center"><div class="d-flex justify-content-center gap-2">
                    <button type="button" class="btn btn-outline-warning btn-sm" onclick="this.parentElement.parentElement.parentElement.parentElement.querySelectorAll('input').forEach(i=>i.readOnly=false)"><i class="fa-solid fa-pen"></i> Editar</button>
                    <button type="submit" class="btn btn-outline-success btn-sm"><i class="fa-solid fa-check"></i> Guardar</button>
                    <button type="button" class="btn btn-outline-danger btn-sm" onclick="confirmarEliminar(<%=c.getId()%>)"><i class="fa-solid fa-trash"></i> Eliminar</button>
                </div></td>
            </form>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
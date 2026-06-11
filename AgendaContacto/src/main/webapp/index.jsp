<%@ page import="java.util.*, com.agenda.modelo.Contacto" contentType="text/html; charset=UTF-8" %>
<%
    if(session.getAttribute("logueado") == null) { response.sendRedirect("login.jsp"); return; }

    // Inicializar lista en memoria
    if(application.getAttribute("contactos") == null) application.setAttribute("contactos", new ArrayList<Contacto>());
    List<Contacto> lista = (List<Contacto>) application.getAttribute("contactos");

    String mensajeError = "";
    String action = request.getParameter("action");
    if("add".equals(action)) {
        String telefono = request.getParameter("telefono");
        boolean telefonoExiste = lista.stream().anyMatch(c -> c.getTelefono().equals(telefono));
        
        if(telefonoExiste) {
            mensajeError = "Error: Ya existe un contacto con este número de teléfono.";
        } else {
            int id = lista.size() + 1;
            lista.add(new Contacto(id, request.getParameter("nombre"), telefono));
            mensajeError = "Contacto agregado correctamente.";
        }
    } else if("delete".equals(action)) {
        String idParam = request.getParameter("id");
        if(idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            lista.removeIf(c -> c.getId() == id);
            mensajeError = "Contacto eliminado correctamente.";
        }
    } else if("update".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        String nuevoTelefono = request.getParameter("telefono");
        boolean telefonoExiste = lista.stream().anyMatch(c -> c.getId() != id && c.getTelefono().equals(nuevoTelefono));
        
        if(telefonoExiste) {
            mensajeError = "Error: Ya existe otro contacto con este número de teléfono.";
        } else {
            for(Contacto c : lista) {
                if(c.getId() == id) {
                    c.setNombre(request.getParameter("nombre"));
                    c.setTelefono(nuevoTelefono);
                    mensajeError = "Contacto actualizado correctamente.";
                    break;
                }
            }
        }
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Agenda</title>
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
            min-height: 100vh;
        }

        .card {
            background: rgba(255, 255, 255, 0.95) !important;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <h2>Mis Contactos</h2>
    <a href="login.jsp?logout=true" class="btn btn-danger">Cerrar Sesión</a>
</div>
<form method="POST" action="index.jsp?action=add" class="row g-3 my-3">
    <div class="col"><input type="text" name="nombre" class="form-control" placeholder="Nombre" required></div>
    <div class="col"><input type="text" name="telefono" class="form-control" placeholder="Teléfono" required></div>
    <div class="col"><button type="submit" class="btn btn-success">Agregar</button></div>
</form>
<% if(!mensajeError.isEmpty()) { %>
    <% if(mensajeError.startsWith("Error")) { %>
        <div class="alert alert-danger" role="alert"><%= mensajeError %></div>
    <% } else { %>
        <div class="alert alert-success" role="alert"><%= mensajeError %></div>
    <% } %>
<% } %>
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
                <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirmModal" data-delete-id="<%=c.getId()%>">Eliminar</button>
            </td>
        </form>
    </tr>
    <% } %>
    </tbody>
</table>
</div>
</body>
</html>

<!-- Modal de confirmación para eliminar -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="confirmLabel">Confirmar eliminación</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                ¿Está seguro que desea borrar este contacto? Esta acción no se puede deshacer.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <a id="deleteLink" href="#" class="btn btn-danger">Eliminar</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let currentDeleteId = '';
    
    const confirmModal = document.getElementById('confirmModal');
    confirmModal.addEventListener('show.bs.modal', function(event) {
        const button = event.relatedTarget;
        currentDeleteId = button.getAttribute('data-delete-id');
    });
    
    const deleteLink = document.getElementById('deleteLink');
    deleteLink.addEventListener('click', function() {
        if(currentDeleteId) {
            window.location.href = 'index.jsp?action=delete&id=' + currentDeleteId;
        }
    });
</script>
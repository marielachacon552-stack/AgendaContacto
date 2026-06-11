package com.agenda.modelo;

public class Contacto {
    private int id;
    private String nombre, telefono, correo;

    public Contacto(int id, String nombre, String telefono, String correo) {
        this.id = id; this.nombre = nombre; this.telefono = telefono; this.correo = correo;
    }
    public int getId() { return id; }
    public String getNombre() { return nombre; }
    public void setNombre(String n) { this.nombre = n; }
    public String getTelefono() { return telefono; }
    public void setTelefono(String t) { this.telefono = t; }
    public String getCorreo() { return correo; }
    public void setCorreo(String c) { this.correo = c; }
}
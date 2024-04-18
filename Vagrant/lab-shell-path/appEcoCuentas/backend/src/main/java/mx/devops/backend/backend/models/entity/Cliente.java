package mx.devops.backend.backend.models.entity;


import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name="clientes")
public class Cliente implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotEmpty(message = "no puede ser vació")
    @Size(min=4, max=12, message = "El tamaño tiene que estar entre 4 y 12")
    @Column(nullable = false)
    private String nombre;

    @NotEmpty(message = "no puede ser vació")
    private String apellido;

    @NotEmpty(message = "no puede ser vació")
    @Email(message="no es una dirección valida")
    @Column(nullable = false, unique = true)
    private String email;

    @PrePersist
    public void prePersist() {
        createAt = new Date();
    }
    @Column(name="create_at")
    @Temporal(TemporalType.DATE)
    private Date createAt;

    @Column(name="fecha_nacimiento")
    @Temporal(TemporalType.DATE)
    @NotNull(message = "no puede ser vació")
    private Date fechaNacimiento;

    private String foto;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public Date getFechaNacimiento() {
        return fechaNacimiento;
    }
    public void setFechaNacimiento(Date fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }

    @Serial
    private static final long serialVersionUID = 8096018828451384687L;

}

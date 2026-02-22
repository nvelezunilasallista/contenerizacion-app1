package co.edu.politecnico.model;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "docentes")
public class Docente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long id;

    @Column(nullable = false, length = 100)
    public String nombres;

    @Column(nullable = false, length = 100)
    public String apellidos;

    @Column(nullable = false, length = 20, unique = true)
    public String cedula;

    @Column(nullable = false, length = 150, unique = true)
    public String correo;

    @Column(length = 15)
    public String telefono;

    @Column(name = "fecha_ingreso", nullable = false)
    public LocalDate fechaIngreso;

    @Column(nullable = false)
    public Boolean activo = true;

    @Column(name = "tipo_contrato", nullable = false, length = 1)
    public String tipoContrato;

    @OneToMany(mappedBy = "docente", fetch = FetchType.LAZY)
    @JsonManagedReference
    public List<Asignatura> asignaturas;
}

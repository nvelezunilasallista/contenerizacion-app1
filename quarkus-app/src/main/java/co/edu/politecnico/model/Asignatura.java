package co.edu.politecnico.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "asignaturas")
public class Asignatura {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long id;

    @Column(nullable = false, length = 10, unique = true)
    public String codigo;

    @Column(nullable = false, length = 150)
    public String nombre;

    @Column(nullable = false)
    public Integer creditos;

    @Column(name = "horas_semana", nullable = false)
    public Integer horasSemana;

    @Column(length = 500)
    public String descripcion;

    @Column(name = "fecha_creacion", nullable = false)
    public LocalDate fechaCreacion;

    @Column(nullable = false)
    public Boolean obligatoria = true;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "docente_id", nullable = false)
    @JsonBackReference
    public Docente docente;

    // Campo transient para serialización del nombre del docente
    @Transient
    public Long docenteId;

    @Transient
    public String docenteNombre;

    @PostLoad
    public void postLoad() {
        if (docente != null) {
            this.docenteId = docente.id;
            this.docenteNombre = docente.nombres + " " + docente.apellidos;
        }
    }
}

package co.edu.politecnico.repository;

import co.edu.politecnico.model.Asignatura;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class AsignaturaRepository implements PanacheRepository<Asignatura> {}

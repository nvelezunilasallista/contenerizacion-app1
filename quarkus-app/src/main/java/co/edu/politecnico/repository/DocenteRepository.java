package co.edu.politecnico.repository;

import co.edu.politecnico.model.Docente;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class DocenteRepository implements PanacheRepository<Docente> {}

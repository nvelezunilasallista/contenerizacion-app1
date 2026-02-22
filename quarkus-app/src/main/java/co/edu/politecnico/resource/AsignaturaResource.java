package co.edu.politecnico.resource;

import co.edu.politecnico.model.Asignatura;
import co.edu.politecnico.model.Docente;
import co.edu.politecnico.repository.AsignaturaRepository;
import co.edu.politecnico.repository.DocenteRepository;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("/api/asignaturas")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class AsignaturaResource {

    @Inject AsignaturaRepository repo;
    @Inject DocenteRepository docenteRepo;

    @GET
    public List<Asignatura> list() {
        return repo.listAll();
    }

    @GET
    @Path("/{id}")
    public Asignatura getById(@PathParam("id") Long id) {
        return repo.findByIdOptional(id)
                .orElseThrow(() -> new NotFoundException("Asignatura no encontrada: " + id));
    }

    @POST
    @Transactional
    public Response create(Asignatura asignatura) {
        if (asignatura.docenteId != null) {
            Docente d = docenteRepo.findByIdOptional(asignatura.docenteId)
                    .orElseThrow(() -> new NotFoundException("Docente no encontrado"));
            asignatura.docente = d;
        }
        repo.persist(asignatura);
        asignatura.postLoad();
        return Response.status(Response.Status.CREATED).entity(asignatura).build();
    }

    @PUT
    @Path("/{id}")
    @Transactional
    public Response update(@PathParam("id") Long id, Asignatura data) {
        Asignatura a = repo.findByIdOptional(id)
                .orElseThrow(() -> new NotFoundException("Asignatura no encontrada: " + id));
        a.codigo        = data.codigo;
        a.nombre        = data.nombre;
        a.creditos      = data.creditos;
        a.horasSemana   = data.horasSemana;
        a.descripcion   = data.descripcion;
        a.fechaCreacion = data.fechaCreacion;
        a.obligatoria   = data.obligatoria;
        if (data.docenteId != null) {
            Docente d = docenteRepo.findByIdOptional(data.docenteId)
                    .orElseThrow(() -> new NotFoundException("Docente no encontrado"));
            a.docente = d;
        }
        a.postLoad();
        return Response.ok(a).build();
    }

    @DELETE
    @Path("/{id}")
    @Transactional
    public Response delete(@PathParam("id") Long id) {
        Asignatura a = repo.findByIdOptional(id)
                .orElseThrow(() -> new NotFoundException("Asignatura no encontrada: " + id));
        repo.delete(a);
        return Response.noContent().build();
    }
}

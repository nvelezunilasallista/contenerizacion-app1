package co.edu.politecnico.resource;

import co.edu.politecnico.model.Docente;
import co.edu.politecnico.repository.DocenteRepository;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("/api/docentes")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class DocenteResource {

    @Inject
    DocenteRepository repo;

    @GET
    public List<Docente> list() {
        return repo.listAll();
    }

    @GET
    @Path("/{id}")
    public Docente getById(@PathParam("id") Long id) {
        return repo.findByIdOptional(id)
                .orElseThrow(() -> new NotFoundException("Docente no encontrado: " + id));
    }

    @POST
    @Transactional
    public Response create(Docente docente) {
        repo.persist(docente);
        return Response.status(Response.Status.CREATED).entity(docente).build();
    }

    @PUT
    @Path("/{id}")
    @Transactional
    public Response update(@PathParam("id") Long id, Docente data) {
        Docente d = repo.findByIdOptional(id)
                .orElseThrow(() -> new NotFoundException("Docente no encontrado: " + id));
        d.nombres      = data.nombres;
        d.apellidos    = data.apellidos;
        d.cedula       = data.cedula;
        d.correo       = data.correo;
        d.telefono     = data.telefono;
        d.fechaIngreso = data.fechaIngreso;
        d.activo       = data.activo;
        d.tipoContrato = data.tipoContrato;
        return Response.ok(d).build();
    }

    @DELETE
    @Path("/{id}")
    @Transactional
    public Response delete(@PathParam("id") Long id) {
        Docente d = repo.findByIdOptional(id)
                .orElseThrow(() -> new NotFoundException("Docente no encontrado: " + id));
        long count = repo.getEntityManager()
                .createQuery("SELECT COUNT(a) FROM Asignatura a WHERE a.docente.id = :id", Long.class)
                .setParameter("id", id).getSingleResult();
        if (count > 0) {
            return Response.status(Response.Status.CONFLICT)
                    .entity("{\"error\":\"El docente tiene " + count + " asignatura(s) asignada(s). Reasígnelas antes de eliminar.\"}")
                    .build();
        }
        repo.delete(d);
        return Response.noContent().build();
    }
}

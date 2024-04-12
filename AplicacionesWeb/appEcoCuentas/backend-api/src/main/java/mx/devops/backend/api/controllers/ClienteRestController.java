package mx.devops.backend.api.controllers;

import jakarta.validation.Valid;
import mx.devops.backend.api.models.entity.Cliente;
import mx.devops.backend.api.models.services.IClienteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@CrossOrigin(origins = {"http://10.11.12.2:4200"})
@RestController
@RequestMapping("/api")
public class ClienteRestController {

    @Autowired
    private IClienteService clienteService;

    @GetMapping("/clientes")
    public List<Cliente> index() {
        return clienteService.findAll();
    };

    @GetMapping("/clientes/{id}")
    public ResponseEntity<?> show(@PathVariable Long id) {

        Cliente cliente = null;
        Map<String, Object> response = new HashMap<>();

        try {
            cliente = clienteService.findById(id);
        } catch (DataAccessException e) {
            response.put("mensaje", "Error al realizar la consulta");
            response.put("error", e.getMessage().concat(":  ").concat(e.getMostSpecificCause().getMessage()));
            return new ResponseEntity<Map<String, Object>>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }

        if (cliente == null) {
            response.put("mensaje", "EL cliente ID: ".concat(id.toString().concat(" no existe en la base de datos")));
            return new ResponseEntity<Map<String, Object>>(response, HttpStatus.NOT_FOUND);
        }

        return new ResponseEntity<Cliente>(cliente, HttpStatus.OK);
    }

    @PostMapping("/clientes")
    public ResponseEntity<?> create(@Valid @RequestBody Cliente cliente, BindingResult result){
        Cliente clienteNew = null;
        Map<String, Object> response = new HashMap<>();

        if (resultadoError(result, response))
            return new ResponseEntity<Map<String, Object>>(response, HttpStatus.BAD_REQUEST);
//        try {
//            clienteNew = clienteService.save(cliente);
//        } catch (DataAccessException e) {
//            response.put("mensaje", "Error al realizar el insert a la base de datos");
//            response.put("error", e.getMessage().concat(":  ").concat(e.getMostSpecificCause().getMessage()));
//            return new ResponseEntity<Map<String, Object>>(response, HttpStatus.INTERNAL_SERVER_ERROR);
//        }

        try {
            clienteNew = clienteService.save(cliente);
        } catch (DataAccessException e) {
            if(e.getMostSpecificCause() instanceof SQLIntegrityConstraintViolationException && e.getMostSpecificCause().getMessage().startsWith("Duplicate entry")) {
                List<String> errors = new ArrayList<String>();
                errors.add("Error: el correo electrónico ya existe en la base de datos");
                response.put("errors", errors);
                return new ResponseEntity<Map<String, Object>>(response, HttpStatus.BAD_REQUEST);
            } else {
                response.put("mensaje", "Error al realizar el insert en la base de datos");
                response.put("error", e.getMessage().concat(": ").concat(e.getMostSpecificCause().getMessage()));
                return new ResponseEntity<Map<String, Object>>(response, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }
        response.put("mensaje", "El cliente ha sido creado con éxito!");
        response.put("cliente", clienteNew);

        return new ResponseEntity<Map<String, Object>>(response, HttpStatus.CREATED);
    }

    @PutMapping("/clientes/{id}")
    public ResponseEntity<?> update(@Valid @RequestBody Cliente cliente, @PathVariable Long id, BindingResult result){
        Cliente clienteActual = clienteService.findById(id);
        Map<String, Object> response = new HashMap<>();

        if (result.hasErrors()) {
            List<String> errores = obtenerErroresDeValidacion(result);
            response.put("status", "error");
            response.put("tipo", "Errores de validación");
            response.put("errors", errores);
            return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
        }
        if (clienteActual == null) {
            response.put("status", "error");
            response.put("tipo", "Cliente no encontrado");
            response.put("mensaje", "El cliente con ID: " + id + " no existe en la base de datos.");
            return new ResponseEntity<>(response, HttpStatus.NOT_FOUND);
        }
        try {
            actualizarCliente(cliente, clienteActual);
            response.put("status", "success");
            response.put("tipo", "Cliente actualizado");
            response.put("cliente", clienteActual);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (DataAccessException e) {
            response.put("status", "error");
            response.put("tipo", "Error al actualizar");
            response.put("detalle", procesarErrorDeAccesoADatos(e));
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    private void actualizarCliente(Cliente cliente, Cliente clienteActual) {
        clienteActual.setNombre(cliente.getNombre());
        clienteActual.setApellido(cliente.getApellido());
        clienteActual.setEmail(cliente.getEmail());
        clienteActual.setCreateAt(cliente.getCreateAt());
        clienteService.save(clienteActual);
    }

    private boolean resultadoError(BindingResult result, Map<String, Object> response) {
        if (result.hasErrors()) {
            List<String> errors = result.getFieldErrors()
                    .stream()
                    .map(err -> "El campo '"+err.getField()+"' "+err.getDefaultMessage())
                    .collect(Collectors.toList());

            response.put("errors", errors);
            return true;
        }
        return false;
    }

    private List<String> obtenerErroresDeValidacion(BindingResult result) {
        return result.getFieldErrors().stream()
                .map(err -> "El campo '" + err.getField() + "' " + err.getDefaultMessage())
                .collect(Collectors.toList());
    }


    private String procesarErrorDeAccesoADatos(DataAccessException e) {

        if (e.getMostSpecificCause() instanceof SQLIntegrityConstraintViolationException) {
            return "El correo electrónico ya existe en la base de datos.";
        } else {
            // Utilizar getMessage().concat para construir el mensaje de error.
            return e.getMessage().concat(": ").concat(e.getMostSpecificCause().getMessage());
        }
    }
    private String obtenerMensajeDeError(DataAccessException e) {
        if (e.getMostSpecificCause() instanceof SQLIntegrityConstraintViolationException) {
            return "El correo electrónico ya existe en la base de datos.";
        } else {
            //return e.getMessage().concat(": ").concat(e.getMostSpecificCause().getMessage());
            e.getMostSpecificCause();
            return e.getMostSpecificCause().getMessage();
        }
    }


    @DeleteMapping("/clientes/{id}")
    public ResponseEntity<?> delete(@PathVariable Long id){
        Map<String, Object> response = new HashMap<>();
        Cliente clienteEliminar = clienteService.findById(id);

        if (clienteEliminar == null) {
            response.put("mensaje", "El cliente con el id: ".concat(id.toString().concat(" no existe en la base de datos!")));
            return new ResponseEntity<Map<String, Object>>(response, HttpStatus.NOT_FOUND);
        }

        try {
            clienteService.delete(id);
        } catch (DataAccessException e) {
            response.put("mensaje", "Error al eliminar el cliente de la base de datos");
            response.put("error", e.getMessage().concat(":  ").concat(e.getMostSpecificCause().getMessage()));
            return new ResponseEntity<Map<String, Object>>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
        response.put("mensaje", "El cliente se ha eliminado con éxito");
        return new ResponseEntity<Map<String, Object>>(response, HttpStatus.OK);
    }
}

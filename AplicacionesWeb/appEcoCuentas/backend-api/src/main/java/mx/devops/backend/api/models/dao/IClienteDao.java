package mx.devops.backend.api.models.dao;

import mx.devops.backend.api.models.entity.Cliente;
import org.springframework.data.repository.CrudRepository;

public interface IClienteDao extends CrudRepository<Cliente, Long> {
}

package mx.devops.backend.api.models.dao;

import mx.devops.backend.api.models.entity.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IClienteDao extends JpaRepository<Cliente, Long> {
}

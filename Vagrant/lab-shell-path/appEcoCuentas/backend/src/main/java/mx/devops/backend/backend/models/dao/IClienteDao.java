package mx.devops.backend.backend.models.dao;

import mx.devops.backend.backend.models.entity.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IClienteDao extends JpaRepository<Cliente, Long> {
}

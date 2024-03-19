package mx.devops.backend.api.models.services;

import mx.devops.backend.api.models.entity.Cliente;

import java.util.List;

public interface IClienteService {
    public List<Cliente> findAll();
}

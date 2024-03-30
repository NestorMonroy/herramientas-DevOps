import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import {Cliente} from "./cliente";
import {ClienteService} from "./cliente.service";

@Component({
  selector: 'app-clientes',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './clientes.component.html',
})
export class ClientesComponent implements OnInit{

  clientes: Cliente[];

  constructor(private clienteService: ClienteService) {}
  ngOnInit() {
    this.clienteService.getClientes().subscribe(clientes => this.clientes = clientes);
  }

}

import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink  } from '@angular/router';
import Swal from 'sweetalert2'

import {Cliente} from "./cliente";
import {ClienteService} from "./cliente.service";

@Component({
  selector: 'app-clientes',
  standalone: true,
  imports: [
    CommonModule,
    RouterLink
  ],
  templateUrl: './clientes.component.html',
})
export class ClientesComponent implements OnInit{

  clientes: Cliente[];

  constructor(private clienteService: ClienteService) {}
  ngOnInit() {
    this.clienteService.getClientes().subscribe(clientes => this.clientes = clientes);
  }

  delete(cliente: Cliente): void {
    const swalWithBootstrap = Swal.mixin({
      customClass: {
        confirmButton: "btn btn-success",
        cancelButton: "btn btn-danger"
      },
      buttonsStyling: false
    });
    swalWithBootstrap.fire({
      title: 'Está seguro?',
      text: `¿Seguro que desea eliminar al cliente ${cliente.nombre} ${cliente.apellido}?`,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Si, eliminar!',
      cancelButtonText: 'No, cancelar!',
      //confirmButtonClass: 'btn btn-success',
      //cancelButtonClass: 'btn btn-danger',
      buttonsStyling: false,
      reverseButtons: true
    }).then((result) => {
      if (result.value) {
        //console.log(result)
        //console.log(cliente.id)
        this.clienteService.delete(cliente.id).subscribe(
          response => {
            this.clientes = this.clientes.filter(cli => cli !== cliente)
            swalWithBootstrap.fire(
              { title: 'Cliente Eliminado!',
                text: `Cliente ${cliente.nombre} eliminado con éxito.`,
                icon: 'success'
              }
            )
          }
        )

      }
    })
  }
}

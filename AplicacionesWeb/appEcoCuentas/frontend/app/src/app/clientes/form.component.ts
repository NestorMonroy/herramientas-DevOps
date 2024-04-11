import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormsModule, NgForm  } from '@angular/forms';
import { CommonModule } from '@angular/common';
import Swal from 'sweetalert2'
import {Cliente} from "./cliente";
import {ClienteService} from "./cliente.service";


@Component({
  selector: 'app-form',
  standalone: true,
  imports: [
    FormsModule,
    CommonModule
  ],
  templateUrl: './form.component.html',
})
export class FormComponent implements OnInit{
  public cliente: Cliente = new Cliente();
  public titulo: string = "Crear cliente";
  public errores: string[] = [];

  constructor(
    private clienteService: ClienteService,
    private router: Router,
    private activatedRouter:ActivatedRoute
  ) {}

  ngOnInit(){
    this.cargarCliente();
  }

  cargarCliente(): void {
    this.activatedRouter.params.subscribe(params => {
      let id = params['id']
      if(id){
        this.clienteService.getCliente(id).subscribe((cliente) => this.cliente = cliente)
      }
    })
  }

  create(f: NgForm): void {
    if (f.form.valid) {
      this.clienteService.create(this.cliente)
        .subscribe({
          next: (cliente) => {
            this.router.navigate(['/clientes']);
            Swal.fire('Nuevo cliente', `El cliente ${cliente.nombre} ha sido creado con éxito`, 'success');
          }, error: (err) => {
            this.errores = err.error.errors ? (err.error.errors as string[]) : [];
            console.error('Código de error desde backend: ' + err.status + ' | MSG = ' + err.error.errors);
          }
        });
    }
  }
  update():void {
    this.clienteService.update(this.cliente)
      .subscribe({
        next: (json) => {
          this.router.navigate(['/clientes'])
          Swal.fire('Cliente Actualizado', `${json.mensaje} : ${json.cliente.nombre} `, 'success')
        },
        error: (err) =>  {
          this.errores = err.error.errors ? (err.error.errors as string[]) : [];
          console.error('Código de error desde backend: ' + err.status + ' | MSG = ' + JSON.stringify(err.error.errors));
        }
      });
  };

}

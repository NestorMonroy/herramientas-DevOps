import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormsModule, NgForm  } from '@angular/forms';
import { CommonModule } from '@angular/common';
import Swal from 'sweetalert2'
import {Cliente} from "./cliente";
import {ClienteService} from "./cliente.service";

import{MatDatepickerModule} from '@angular/material/datepicker';
import {MatInputModule} from '@angular/material/input';
import {provideMomentDateAdapter} from '@angular/material-moment-adapter';
// Formato personalizado para la fecha
export const MY_DATE_FORMATS = {
  parse: {
    dateInput: 'DD/MM/YYYY',
  },
  display: {
    dateInput: 'DD/MM/YYYY', // Aquí defines el formato de visualización deseado
    monthYearLabel: 'MMM YYYY',
    dateA11yLabel: 'LL',
    monthYearA11yLabel: 'MMMM YYYY',
  },
};

@Component({
  selector: 'app-form',
  standalone: true,
  imports: [
    FormsModule,
    CommonModule,
    MatInputModule,
    MatDatepickerModule,
  ],
  providers: [
    // Moment can be provided globally to your app by adding `provideMomentDateAdapter`
    // to your app config. We provide it at the component level here, due to limitations
    // of our example generation script.
    provideMomentDateAdapter(MY_DATE_FORMATS),
  ],
  templateUrl: './form.component.html',
})
export class FormComponent implements OnInit{
  public cliente: Cliente = new Cliente();
  public titulo: string = "Crear cliente";
  public errores: string[];

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
          Swal.fire('Cliente Actualizado', `${json.tipo} : ${json.cliente.nombre} `, 'success')
        },
        error: (err: any) =>  {
          if (err.status === 400 && err.error && Array.isArray(err.error.errors)) {

            this.errores = err.error.errors.map((error: any) => error.defaultMessage);
            //console.log( JSON.stringify(this.errores)  )
            //console.log( err.error.errors as string[]  )
            Swal.fire('Errores de validación', this.errores.join(', '), 'error');
          } else {
            let mensajeError = 'Error al actualizar cliente';
            let detalleError = 'No se proporcionó más información';

            if (err.error && err.error.tipo) {
              mensajeError = err.error.tipo;
            }
            if (err.error && err.error.detalle) {
              detalleError += ': ' + err.error.detalle;
            }
            Swal.fire(mensajeError, detalleError, 'error');
          }
        }
      });
  };

}

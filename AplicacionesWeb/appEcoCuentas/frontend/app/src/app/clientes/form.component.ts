import { Component } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormsModule } from '@angular/forms';
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
export class FormComponent {
  public cliente: Cliente = new Cliente();
  public titulo: string = "Crear cliente";

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

  public create(): void {
    this.clienteService.create(this.cliente)
      .subscribe(cliente => {
        this.router.navigate(['/clientes'])
        Swal.fire('Nuevo cliente', `El cliente ${cliente.nombre} ha sido creado con éxito`, 'success')
      }
    )
  };

  update():void {
    this.clienteService.update(this.cliente)
      .subscribe(json => {
        this.router.navigate(['/clientes'])
        //console.log(json);
        Swal.fire('Cliente Actualizado',`${json.mensaje} : ${json.cliente.nombre} `, 'success')
      }
      )
  };

}

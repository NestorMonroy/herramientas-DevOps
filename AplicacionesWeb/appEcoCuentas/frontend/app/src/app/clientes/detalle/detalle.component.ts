import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { HttpEventType } from '@angular/common/http';
import Swal from 'sweetalert2'

import {Cliente} from "../cliente";
import {ClienteService} from "../cliente.service";

@Component({
  selector: 'detalle-cliente',
  standalone: true,
  imports: [
    CommonModule,
  ],
  templateUrl: './detalle.component.html',
  styleUrl: './detalle.component.css'
})
export class DetalleComponent implements OnInit{
  titulo: string = "Detalle del cliente";
  cliente: Cliente;
  fotoSeleccionada: File;
  progreso: number = 0;

  constructor(
    private clienteService: ClienteService,
    private activatedRouter: ActivatedRoute,
  ){}

  ngOnInit(){
    this.activatedRouter.paramMap.subscribe(params => {
      let id: number = +params.get('id');
      if(id){
        this.clienteService.getCliente(id).subscribe((cliente) => {
          this.cliente = cliente;
        })
      }
    })
  }

  seleccionarFoto(event: any) {
    this.fotoSeleccionada = event.target.files[0];
    this.progreso = 0;
    console.log(this.fotoSeleccionada);
    if(this.fotoSeleccionada.type.indexOf("image") < 0){
      Swal.fire("Error: seleccionar imagen ", 'El archivo debe de ser tipo imagen', 'error')
      this.fotoSeleccionada = null;
    }
  }

  subirFoto(){
    if(!this.fotoSeleccionada){
      console.log(this.fotoSeleccionada);
      Swal.fire("Error:upload ", 'debe seleccionar una foto', 'error')
    }else {
      this.clienteService.subirFoto(this.fotoSeleccionada,this.cliente.id)
        .subscribe(event => {
          if(event.type === HttpEventType.UploadProgress){
            this.progreso = Math.round((event.loaded/event.total)*100);
          }else if(event.type === HttpEventType.Response){
            let response: any = event.body;
            this.cliente = response.cliente as Cliente;

            Swal.fire("La foto se ha subido completamente!", `La foto se ha subido con éxito: ${this.cliente.foto}`, 'success')
          }
        });
    }
  }
}

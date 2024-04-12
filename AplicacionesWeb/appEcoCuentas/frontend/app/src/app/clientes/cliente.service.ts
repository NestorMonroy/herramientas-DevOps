import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Router } from '@angular/router';
import { Observable, throwError } from 'rxjs';
import { map, catchError  } from 'rxjs/operators';
import Swal from 'sweetalert2'

import { Cliente } from "./cliente";

@Injectable({
  providedIn: 'root'
})
export class ClienteService {
  private urlEndPoint: string = "http://localhost:8080/api/clientes"
  private httpHeaders = new HttpHeaders({ 'Content-Type': 'application/json' })

  constructor(
    private http: HttpClient,
    private router: Router
  ) { }

  getClientes(): Observable<Cliente[]> {
    return this.http.get(this.urlEndPoint).pipe(
      map((response) => response as Cliente[])
    )
  }

  create(cliente: Cliente): Observable<Cliente> {
    return this.http.post(
      this.urlEndPoint,
      cliente,
      {headers: this.httpHeaders}
    ).pipe(
      map((response : any) => response.cliente as Cliente),
      catchError(this.handleError)
    )
  }

  getCliente(id: number): Observable<Cliente> {
    return this.http.get<Cliente>(`${this.urlEndPoint}/${id}`).pipe(
      catchError(e => {
        this.router.navigate(['/clientes'])
        console.log(e.error.detalle)
        Swal.fire({
          icon: "error",
          title: "Error al editar",
          text: e.error.detalle,
        });
        return throwError(() => e)
      })
    )
  }
  update(cliente: Cliente): Observable<any> {
    return this.http.put<any>(
      `${this.urlEndPoint}/${cliente.id}`,
      cliente,
      {headers: this.httpHeaders}
    ).pipe(
      catchError(this.handleError)
    )
  }
  delete(id: number): Observable<Cliente>{
    return this.http.delete<Cliente>(
      `${this.urlEndPoint}/${id}`,
    ).pipe(
      catchError(this.handleError)
    )

  }

  private handleError(e: any): Observable<never> {
    let mensajeError = 'Error no especificado';
    let detalleError = 'No se proporcionó más información';

    if (e.error instanceof ErrorEvent) {
      // A client-side or network error occurred.
      mensajeError = e.error.message;
    } else {
      // The backend returned an unsuccessful response code.
      if (e.error && e.error.tipo) {
        mensajeError = e.error.tipo;
      }
      if (e.error && e.error.detalle) {
        detalleError = e.error.detalle;
      }
    }
    Swal.fire({
      icon: 'error',
      title: mensajeError,
      text: detalleError
    });

    return throwError(() => e);
  }
}

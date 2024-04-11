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
      catchError(e => {
        let mensajeError = 'Error al crear cliente';
        if (e.error instanceof ErrorEvent) {
          // A client-side or network error occurred.
          mensajeError = e.error.message;
        } else {
          // The backend returned an unsuccessful response code.
          if (e.error && typeof e.error === 'object') {
            console.log(JSON.stringify(e))
            mensajeError = JSON.stringify(e.error.errors);
            // err.error.errors ? (err.error.errors as string[]) : [];
          }
        }
        Swal.fire({
          icon: 'error',
          title: 'Error',
          text: mensajeError
        });
        return throwError(() => e);
      })
    )
  }
  getCliente(id: number): Observable<Cliente> {
    return this.http.get<Cliente>(`${this.urlEndPoint}/${id}`).pipe(
      catchError(e => {
        this.router.navigate(['/clientes'])
        console.log(e.error.mensaje)
        Swal.fire({
          icon: "error",
          title: "Error al editar",
          text: e.error.mensaje,
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
      catchError(e => {
          let mensajeError = 'Error al actualizar cliente';
          if (e.error instanceof ErrorEvent) {
            // A client-side or network error occurred.
            mensajeError = e.error.message;
          } else {
            // The backend returned an unsuccessful response code.
            if (e.error && typeof e.error === 'object') {
              mensajeError = JSON.stringify(e.error.errors);
            }
          }
          Swal.fire({
            icon: 'error',
            title: 'Error',
            text: mensajeError
          });
          return throwError(() => e);
        }
      )
    )
  }
  delete(id: number): Observable<Cliente>{
    return this.http.delete<Cliente>(
      `${this.urlEndPoint}/${id}`,
    ).pipe(
      catchError(e => {
        console.log(e.error.mensaje)
        console.log(e.error.error)
        Swal.fire({
          icon: "error",
          title: e.error.mensaje,
          text: e.error.error,
        });
        return throwError(() => e)
      })
    )

  }
}


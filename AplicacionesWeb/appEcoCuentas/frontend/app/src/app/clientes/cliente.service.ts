import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, catchError, throwError } from 'rxjs';
import { Router } from '@angular/router';
import Swal from 'sweetalert2'
import { map } from 'rxjs/operators';
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
        console.log(e)
        console.log(e.error.mensaje)
        console.log(e.error.error)
        Swal.fire({
          icon: "error",
          title: e.error.mensaje,
          text: e.error.error,
        });
        return throwError(() => new Error(e))
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
        return throwError(() => new Error(e))
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
        console.log(e.error.mensaje)
        console.log(e.error.error)
        Swal.fire({
          icon: "error",
          title: e.error.mensaje,
          text: e.error.error,
        });
        return throwError(() => new Error(e))
      })
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
        return throwError(() => new Error(e))
      })
    )

  }
}


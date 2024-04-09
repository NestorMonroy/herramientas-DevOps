import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import {Cliente} from "./cliente";

@Component({
  selector: 'app-form',
  standalone: true,
  imports: [
    FormsModule
  ],
  templateUrl: './form.component.html',
})
export class FormComponent {
  public cliente: Cliente = new Cliente();
  public titulo: string = "Crear cliente";

  public create(): void {
    console.log("click")
    console.log(this.cliente)
  };

}

import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-directiva',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './directiva.component.html'
})
export class DirectivaComponent {
  listaCurso: string[]= ['TypeScript', 'JavaScript', 'Java SE', 'C#']
  habilitar:boolean = true;
  setHabilitar(): void {
    this.habilitar = !this.habilitar;
  }

}

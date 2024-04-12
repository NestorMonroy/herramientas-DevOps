import { ApplicationConfig, LOCALE_ID } from '@angular/core';
import { registerLocaleData } from '@angular/common';
import { provideRouter  } from '@angular/router';
import { provideHttpClient } from '@angular/common/http';
import localeEsMX from '@angular/common/locales/es-MX';
//registerLocaleData(localeEsMX, 'es-MX');
registerLocaleData(localeEsMX, 'es-MX');
import { MAT_DATE_FORMATS } from '@angular/material/core';
import { routes } from './app.routes';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';


export const appConfig: ApplicationConfig = {

  providers: [
    provideRouter(routes),
    provideHttpClient(),
    { provide: LOCALE_ID, useValue: 'es-MX' },
    provideAnimationsAsync(),
  ]
};

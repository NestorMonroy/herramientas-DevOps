import { ApplicationConfig, LOCALE_ID } from '@angular/core';
import { registerLocaleData } from '@angular/common';
import { provideRouter  } from '@angular/router';
import { provideHttpClient } from '@angular/common/http';
import localeEsMX from '@angular/common/locales/es-MX';

//registerLocaleData(localeEsMX, 'es-MX');
registerLocaleData(localeEsMX, 'mx');

import { routes } from './app.routes';

export const appConfig: ApplicationConfig = {
  providers: [
    provideRouter(routes),
    provideHttpClient(),
    { provide: LOCALE_ID, useValue: 'mx' }
  ]
};

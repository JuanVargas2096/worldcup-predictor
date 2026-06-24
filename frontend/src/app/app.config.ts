import { ApplicationConfig, provideZoneChangeDetection } from '@angular/core';
import { provideRouter, withHashLocation } from '@angular/router';
import { provideHttpClient } from '@angular/common/http';
import { routes } from './app.routes';

export const appConfig: ApplicationConfig = {
  providers: [
    provideZoneChangeDetection({ eventCoalescing: true }),
    // Hash routing -> URLs tipo https://host/#/ranking, /#/equipo/:id, etc.
    provideRouter(routes, withHashLocation()),
    provideHttpClient()
  ]
};

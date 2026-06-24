import { Component } from '@angular/core';
import { RouterLink, RouterLinkActive, RouterOutlet } from '@angular/router';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, RouterLink, RouterLinkActive],
  template: `
    <div class="min-h-screen flex flex-col">
      <header class="bg-night text-white shadow-lg">
        <div class="max-w-6xl mx-auto px-4 py-4 flex items-center justify-between flex-wrap gap-3">
          <a routerLink="/ranking" class="flex items-center gap-2 text-xl font-bold">
            <span class="text-2xl">⚽</span>
            <span>Predictor Mundial <span class="text-emerald-400">2026</span></span>
          </a>
          <nav class="flex gap-1 text-sm">
            <a routerLink="/ranking" routerLinkActive="bg-emerald-600"
               class="px-3 py-2 rounded-md hover:bg-slate-700 transition">Ranking</a>
            <a routerLink="/fixture" routerLinkActive="bg-emerald-600"
               class="px-3 py-2 rounded-md hover:bg-slate-700 transition">Fixture</a>
            <a routerLink="/configuracion" routerLinkActive="bg-emerald-600"
               class="px-3 py-2 rounded-md hover:bg-slate-700 transition">Configuración</a>
          </nav>
        </div>
      </header>

      <main class="flex-1 max-w-6xl w-full mx-auto px-4 py-6">
        <router-outlet></router-outlet>
      </main>

      <footer class="text-center text-xs text-slate-400 py-4">
        Datos de equipos y grupos reales (sorteo 05-dic-2025). Forma reciente simulada (MVP).
      </footer>
    </div>
  `
})
export class AppComponent {}

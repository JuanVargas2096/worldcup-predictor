import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { ApiService } from '../../core/api.service';
import { RankingEntry } from '../../models/models';
import { FormBadgesComponent } from '../../components/form-badges.component';

@Component({
  selector: 'app-ranking',
  standalone: true,
  imports: [CommonModule, RouterLink, FormBadgesComponent],
  template: `
    <section>
      <div class="flex items-center justify-between mb-4 flex-wrap gap-3">
        <div>
          <h1 class="text-2xl font-bold text-night">Favoritos a ganar el Mundial</h1>
          <p class="text-sm text-slate-500">
            Puntaje 0–100 y probabilidad estimada de levantar la copa.
          </p>
        </div>
        <button (click)="recalculate()" [disabled]="loading"
                class="bg-emerald-600 hover:bg-emerald-700 disabled:opacity-50 text-white px-4 py-2 rounded-md text-sm font-semibold transition">
          {{ loading ? 'Calculando…' : '↻ Recalcular' }}
        </button>
      </div>

      <div *ngIf="error" class="bg-rose-100 text-rose-700 px-4 py-3 rounded mb-4 text-sm">
        {{ error }}
      </div>

      <div *ngIf="loading && !rankings.length" class="text-slate-500 py-10 text-center">
        Cargando ranking…
      </div>

      <div *ngIf="rankings.length" class="overflow-x-auto bg-white rounded-xl shadow">
        <table class="min-w-full text-sm">
          <thead class="bg-slate-100 text-slate-600 text-left">
            <tr>
              <th class="px-3 py-3 w-12">#</th>
              <th class="px-3 py-3">Selección</th>
              <th class="px-3 py-3 text-center">Grupo</th>
              <th class="px-3 py-3 text-center">Score</th>
              <th class="px-3 py-3 text-center">Prob. título</th>
              <th class="px-3 py-3">Últimos 5</th>
            </tr>
          </thead>
          <tbody>
            <tr *ngFor="let r of rankings"
                [routerLink]="['/equipo', r.teamId]"
                class="border-t border-slate-100 hover:bg-emerald-50 cursor-pointer"
                [class.opacity-50]="r.isEliminated">
              <td class="px-3 py-3 font-bold"
                  [class.text-amber-500]="r.position <= 3 && !r.isEliminated">{{ r.position }}</td>
              <td class="px-3 py-3">
                <div class="flex items-center gap-2">
                  <span class="text-xl" [class.grayscale]="r.isEliminated">{{ r.flagEmoji }}</span>
                  <div>
                    <div class="flex items-center gap-1">
                      <div class="font-semibold text-night" [class.line-through]="r.isEliminated">{{ r.name }}</div>
                      <span *ngIf="r.isEliminated" class="text-[10px] bg-rose-100 text-rose-600 px-1 rounded font-bold uppercase tracking-tighter">Eliminado</span>
                    </div>
                    <div class="text-xs text-slate-400">{{ r.confederation }}</div>
                  </div>
                </div>
              </td>
              <td class="px-3 py-3 text-center">
                <span class="inline-block bg-slate-200 text-slate-700 rounded px-2 py-0.5 text-xs font-bold">
                  {{ r.groupLetter }}
                </span>
              </td>
              <td class="px-3 py-3 text-center">
                <div class="font-bold text-night">{{ r.finalScore | number:'1.1-1' }}</div>
                <div class="w-24 mx-auto bg-slate-200 rounded-full h-1.5 mt-1">
                  <div class="bg-emerald-500 h-1.5 rounded-full"
                       [style.width.%]="r.finalScore"></div>
                </div>
              </td>
              <td class="px-3 py-3 text-center font-semibold text-emerald-700">
                {{ r.winProbability | number:'1.1-1' }}%
              </td>
              <td class="px-3 py-3">
                <app-form-badges [matches]="r.lastFive"></app-form-badges>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </section>
  `
})
export class RankingComponent implements OnInit {
  rankings: RankingEntry[] = [];
  loading = false;
  error = '';

  constructor(private api: ApiService) {}

  ngOnInit(): void {
    this.load();
  }

  load(): void {
    this.loading = true;
    this.error = '';
    this.api.getRankings().subscribe({
      next: (data) => {
        this.rankings = data;
        this.loading = false;
      },
      error: () => {
        this.error = 'No se pudo cargar el ranking. ¿El backend está arriba?';
        this.loading = false;
      }
    });
  }

  recalculate(): void {
    this.loading = true;
    this.api.recalculate().subscribe({
      next: () => this.load(),
      error: () => {
        this.error = 'No se pudo recalcular.';
        this.loading = false;
      }
    });
  }
}

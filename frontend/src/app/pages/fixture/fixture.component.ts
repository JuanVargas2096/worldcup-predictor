import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { ApiService } from '../../core/api.service';
import { GroupView, FixtureItem } from '../../models/models';

@Component({
  selector: 'app-fixture',
  standalone: true,
  imports: [CommonModule, RouterLink],
  template: `
    <section>
      <h1 class="text-2xl font-bold text-night mb-1">Fixture · Fase de grupos</h1>
      <p class="text-sm text-slate-500 mb-4">
        48 selecciones clasificadas, 12 grupos. Datos del sorteo oficial (05-dic-2025).
      </p>

      <div *ngIf="error" class="bg-rose-100 text-rose-700 px-4 py-3 rounded mb-4 text-sm">{{ error }}</div>
      <div *ngIf="loading" class="text-slate-500 py-10 text-center">Cargando fixture…</div>

      <div class="grid md:grid-cols-2 gap-5">
        <div *ngFor="let g of groups" class="bg-white rounded-xl shadow overflow-hidden">
          <div class="bg-night text-white px-4 py-2 font-bold flex items-center justify-between">
            <span>Grupo {{ g.groupLetter }}</span>
            <span class="text-xs text-slate-300">{{ g.teams.length }} equipos</span>
          </div>

          <!-- Equipos del grupo -->
          <div class="px-4 py-2 border-b border-slate-100">
            <div *ngFor="let t of g.teams"
                 [routerLink]="['/equipo', t.id]"
                 class="flex items-center justify-between py-1 cursor-pointer hover:text-emerald-700">
              <span class="flex items-center gap-2 text-sm">
                <span class="text-lg">{{ t.flagEmoji }}</span>{{ t.name }}
              </span>
              <span class="text-xs text-slate-400">FIFA #{{ t.fifaRanking }}</span>
            </div>
          </div>

          <!-- Calendario por jornada -->
          <div class="px-4 py-2">
            <div *ngFor="let md of [1,2,3]">
              <div class="text-xs uppercase tracking-wide text-slate-400 mt-2 mb-1">Jornada {{ md }}</div>
              <div *ngFor="let f of fixturesByMatchday(g, md)"
                   class="flex items-center justify-between text-sm py-1">
                <span class="flex items-center gap-1 flex-1 justify-end text-right">
                  {{ f.homeTeamName }} <span>{{ f.homeFlag }}</span>
                </span>
                <span class="mx-2 px-2 py-0.5 rounded bg-slate-100 text-slate-600 font-semibold text-xs min-w-[44px] text-center">
                  {{ f.played ? f.homeScore + '-' + f.awayScore : 'vs' }}
                </span>
                <span class="flex items-center gap-1 flex-1">
                  <span>{{ f.awayFlag }}</span> {{ f.awayTeamName }}
                </span>
              </div>
            </div>
            <div *ngIf="g.fixtures.length > 0" class="text-[11px] text-slate-400 mt-2">
              📅 {{ g.fixtures[0].scheduledDate }} · {{ g.fixtures[0].venue }}
            </div>
          </div>
        </div>
      </div>
    </section>
  `
})
export class FixtureComponent implements OnInit {
  groups: GroupView[] = [];
  loading = true;
  error = '';

  constructor(private api: ApiService) {}

  ngOnInit(): void {
    this.api.getGroups().subscribe({
      next: (g) => {
        this.groups = g;
        this.loading = false;
      },
      error: () => {
        this.error = 'No se pudo cargar el fixture.';
        this.loading = false;
      }
    });
  }

  fixturesByMatchday(g: GroupView, md: number): FixtureItem[] {
    return g.fixtures.filter((f) => f.matchday === md);
  }
}

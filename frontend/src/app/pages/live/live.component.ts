import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ApiService } from '../../core/api.service';
import { WorldCupFixtureItem } from '../../models/models';

interface RoundGroup {
  round: string;
  fixtures: WorldCupFixtureItem[];
}

@Component({
  selector: 'app-live',
  standalone: true,
  imports: [CommonModule],
  template: `
    <section>
      <div class="flex items-center justify-between mb-1 flex-wrap gap-3">
        <h1 class="text-2xl font-bold text-night">Mundial 2026 · Partidos reales</h1>
        <button (click)="sync()" [disabled]="syncing"
                class="bg-emerald-600 hover:bg-emerald-700 disabled:opacity-50 text-white px-4 py-2 rounded-md text-sm font-semibold transition">
          {{ syncing ? 'Sincronizando…' : '↻ Sincronizar ahora' }}
        </button>
      </div>
      <p class="text-sm text-slate-500 mb-4">
        Resultados y calendario reales sincronizados desde API-Football
        (se actualizan automáticamente hasta 6 veces al día).
      </p>

      <div *ngIf="message" class="px-4 py-3 rounded mb-4 text-sm"
           [class.bg-emerald-100]="!isError" [class.text-emerald-700]="!isError"
           [class.bg-rose-100]="isError" [class.text-rose-700]="isError">
        {{ message }}
      </div>

      <div *ngIf="loading" class="text-slate-500 py-10 text-center">Cargando partidos…</div>

      <div *ngIf="!loading && !fixtures.length"
           class="bg-white rounded-xl shadow p-8 text-center text-slate-500">
        <p class="font-semibold text-night mb-1">Aún no hay partidos sincronizados</p>
        <p class="text-sm">Pulsa <strong>Sincronizar ahora</strong> (requiere FOOTBALL_API_KEY configurada)
          o espera a la sincronización automática.</p>
      </div>

      <div *ngFor="let g of rounds" class="mb-6">
        <h2 class="text-sm uppercase tracking-wide text-slate-400 font-semibold mb-2">{{ g.round }}</h2>
        <div class="bg-white rounded-xl shadow divide-y divide-slate-100">
          <div *ngFor="let f of g.fixtures" class="flex items-center px-4 py-3 gap-3">
            <!-- Local -->
            <div class="flex items-center gap-2 flex-1 justify-end text-right">
              <span class="font-medium" [class.font-bold]="f.homeWinner">{{ f.homeTeamName }}</span>
              <img *ngIf="f.homeTeamLogo" [src]="f.homeTeamLogo" alt="" class="w-6 h-6 object-contain" />
            </div>
            <!-- Marcador / estado -->
            <div class="text-center min-w-[88px]">
              <div *ngIf="hasScore(f)" class="font-bold text-night text-lg">
                {{ f.goalsHome }} - {{ f.goalsAway }}
              </div>
              <div *ngIf="!hasScore(f)" class="text-xs text-slate-500">
                {{ f.fixtureDate | date:'dd/MM HH:mm' }}
              </div>
              <div class="text-[10px] uppercase tracking-wide"
                   [class.text-rose-600]="isLive(f)"
                   [class.text-slate-400]="!isLive(f)">
                {{ statusLabel(f) }}
              </div>
            </div>
            <!-- Visitante -->
            <div class="flex items-center gap-2 flex-1">
              <img *ngIf="f.awayTeamLogo" [src]="f.awayTeamLogo" alt="" class="w-6 h-6 object-contain" />
              <span class="font-medium" [class.font-bold]="f.awayWinner">{{ f.awayTeamName }}</span>
            </div>
          </div>
        </div>
      </div>
    </section>
  `
})
export class LiveComponent implements OnInit {
  fixtures: WorldCupFixtureItem[] = [];
  rounds: RoundGroup[] = [];
  loading = true;
  syncing = false;
  message = '';
  isError = false;

  constructor(private api: ApiService) {}

  ngOnInit(): void {
    this.load();
  }

  load(): void {
    this.loading = true;
    this.api.getWorldCupFixtures(2026).subscribe({
      next: (data) => {
        this.fixtures = data;
        this.rounds = this.groupByRound(data);
        this.loading = false;
      },
      error: () => {
        this.message = 'No se pudieron cargar los partidos.';
        this.isError = true;
        this.loading = false;
      }
    });
  }

  sync(): void {
    this.syncing = true;
    this.message = '';
    this.api.syncWorldCup().subscribe({
      next: (res) => {
        this.isError = res.status?.startsWith('ERROR') ?? false;
        this.message = this.isError
          ? `Sincronización con problemas: ${res.status}`
          : `Sincronizado: ${res.fixturesInserted} nuevos, ${res.fixturesUpdated} actualizados.`;
        this.syncing = false;
        this.load();
      },
      error: (e) => {
        this.message = e?.error?.error || 'Error al sincronizar.';
        this.isError = true;
        this.syncing = false;
      }
    });
  }

  private groupByRound(list: WorldCupFixtureItem[]): RoundGroup[] {
    const map = new Map<string, WorldCupFixtureItem[]>();
    for (const f of list) {
      const key = f.round || 'Sin ronda';
      if (!map.has(key)) map.set(key, []);
      map.get(key)!.push(f);
    }
    return Array.from(map.entries()).map(([round, fixtures]) => ({ round, fixtures }));
  }

  hasScore(f: WorldCupFixtureItem): boolean {
    return f.goalsHome !== null && f.goalsAway !== null;
  }

  isLive(f: WorldCupFixtureItem): boolean {
    return ['1H', '2H', 'HT', 'ET', 'P', 'LIVE'].includes(f.statusShort);
  }

  statusLabel(f: WorldCupFixtureItem): string {
    if (this.isLive(f)) return f.elapsed ? `EN VIVO ${f.elapsed}'` : 'EN VIVO';
    if (f.statusShort === 'FT' || f.statusShort === 'AET' || f.statusShort === 'PEN') return 'Finalizado';
    return f.statusLong || 'Programado';
  }
}

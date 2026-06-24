import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ApiService } from '../../core/api.service';
import { WorldCupFixtureItem, BracketRound, BracketMatchItem } from '../../models/models';

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
      <div class="flex items-start justify-between mb-1 gap-3 flex-wrap">
        <h1 class="text-xl sm:text-2xl font-bold text-night">Mundial {{ season }} · Partidos reales</h1>
        <button (click)="sync()" [disabled]="syncing"
                class="bg-emerald-600 hover:bg-emerald-700 disabled:opacity-50 text-white px-4 py-2 rounded-md text-sm font-semibold transition whitespace-nowrap">
          {{ syncing ? 'Sincronizando…' : '↻ Sincronizar ahora' }}
        </button>
      </div>

      <!-- Selector de Mundial -->
      <div class="inline-flex rounded-lg bg-slate-200 p-0.5 mb-3">
        <button *ngFor="let s of seasons" (click)="selectSeason(s)" [disabled]="syncing"
                class="px-3 sm:px-4 py-1.5 rounded-md text-sm font-semibold transition disabled:opacity-50"
                [class.bg-white]="s === season" [class.shadow]="s === season"
                [class.text-night]="s === season" [class.text-slate-500]="s !== season">
          Mundial {{ s }}
        </button>
      </div>

      <p class="text-xs sm:text-sm text-slate-500 mb-4">
        Resultados y calendario reales sincronizados desde API-Football.
        El Mundial 2026 se actualiza automáticamente; para el 2022 pulsa
        <strong>Sincronizar ahora</strong>. Se muestran los más recientes primero.
      </p>

      <div *ngIf="message" class="px-4 py-3 rounded mb-4 text-sm"
           [class.bg-emerald-100]="!isError" [class.text-emerald-700]="!isError"
           [class.bg-rose-100]="isError" [class.text-rose-700]="isError">
        {{ message }}
      </div>

      <!-- ======================= Eliminatorias · Predicciones ======================= -->
      <div *ngIf="bracket.length" class="mb-8">
        <h2 class="text-lg sm:text-xl font-bold text-night mb-1">Eliminatorias · Predicciones</h2>
        <p class="text-xs sm:text-sm text-slate-500 mb-4">
          Probabilidad de que cada equipo avance y los posibles rivales de la siguiente fase.
        </p>

        <div *ngFor="let r of bracket" class="mb-6">
          <h3 class="text-xs sm:text-sm uppercase tracking-wide text-slate-400 font-semibold mb-2">{{ r.round }}</h3>
          <div class="grid sm:grid-cols-2 gap-3">
            <div *ngFor="let m of r.matches" class="bg-white rounded-xl shadow p-3 sm:p-4">
              <!-- Equipos + marcador / fecha / estado -->
              <div class="grid grid-cols-[1fr_auto_1fr] items-center gap-2">
                <div class="flex items-center gap-1.5 min-w-0 justify-end text-right">
                  <span class="font-medium text-sm truncate"
                        [class.text-slate-400]="!m.home">{{ m.home?.name || 'Por definir' }}</span>
                  <img *ngIf="m.home?.logo" [src]="m.home!.logo" alt="" class="w-5 h-5 object-contain shrink-0" />
                </div>
                <div class="text-center px-1 min-w-[56px]">
                  <div *ngIf="hasGoals(m)" class="font-bold text-night text-base leading-tight">
                    {{ m.goalsHome }} - {{ m.goalsAway }}
                  </div>
                  <div *ngIf="!hasGoals(m)" class="text-[11px] text-slate-500 leading-tight">
                    {{ m.fixtureDate | date:'dd/MM HH:mm' }}
                  </div>
                  <div class="text-[9px] uppercase tracking-wide text-slate-400">{{ m.statusLong || 'Programado' }}</div>
                </div>
                <div class="flex items-center gap-1.5 min-w-0">
                  <img *ngIf="m.away?.logo" [src]="m.away!.logo" alt="" class="w-5 h-5 object-contain shrink-0" />
                  <span class="font-medium text-sm truncate"
                        [class.text-slate-400]="!m.away">{{ m.away?.name || 'Por definir' }}</span>
                </div>
              </div>

              <!-- Barras de probabilidad de avanzar -->
              <div *ngIf="m.winProbHome !== null && m.winProbAway !== null" class="mt-3">
                <div class="flex items-center justify-between text-xs font-semibold mb-1">
                  <span class="text-emerald-700">{{ m.winProbHome | number:'1.0-1' }}%</span>
                  <span class="text-[9px] text-slate-400 uppercase tracking-wide">Prob. avanzar</span>
                  <span class="text-sky-700">{{ m.winProbAway | number:'1.0-1' }}%</span>
                </div>
                <div class="flex h-2 rounded-full overflow-hidden bg-slate-200">
                  <div class="bg-emerald-500 h-2" [style.width.%]="m.winProbHome"></div>
                  <div class="bg-sky-500 h-2" [style.width.%]="m.winProbAway"></div>
                </div>
                <p *ngIf="m.advice" class="text-[11px] text-slate-500 mt-1.5">💡 {{ m.advice }}</p>
              </div>
              <div *ngIf="m.winProbHome === null && m.home && m.away" class="mt-3 text-[11px] text-slate-400">
                Predicción aún no disponible.
              </div>

              <!-- Posibles rivales de la siguiente fase -->
              <div *ngIf="m.hasNextRound" class="mt-3 pt-3 border-t border-slate-100">
                <div class="text-[10px] uppercase tracking-wide text-slate-400 font-semibold mb-1">
                  Si gana, su rival sería
                </div>
                <div *ngIf="m.nextOpponents.length; else porDefinir" class="flex flex-wrap items-center gap-x-2 gap-y-1">
                  <span *ngFor="let o of m.nextOpponents; let last = last"
                        class="inline-flex items-center gap-1 text-xs text-night">
                    <img *ngIf="o.logo" [src]="o.logo" alt="" class="w-4 h-4 object-contain" />
                    {{ o.name }}
                    <span *ngIf="!last" class="text-slate-400 font-semibold ml-1">o</span>
                  </span>
                </div>
                <ng-template #porDefinir><div class="text-xs text-slate-400">Por definir</div></ng-template>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- ============================================================================ -->

      <div *ngIf="loading" class="text-slate-500 py-10 text-center">Cargando partidos…</div>

      <div *ngIf="!loading && !fixtures.length"
           class="bg-white rounded-xl shadow p-8 text-center text-slate-500">
        <p class="font-semibold text-night mb-1">Aún no hay partidos sincronizados</p>
        <p class="text-sm">Pulsa <strong>Sincronizar ahora</strong> (requiere FOOTBALL_API_KEY configurada)
          o espera a la sincronización automática.</p>
      </div>

      <div *ngFor="let g of rounds" class="mb-6">
        <h2 class="text-xs sm:text-sm uppercase tracking-wide text-slate-400 font-semibold mb-2">{{ g.round }}</h2>
        <div class="bg-white rounded-xl shadow divide-y divide-slate-100">
          <div *ngFor="let f of g.fixtures"
               class="grid grid-cols-[1fr_auto_1fr] items-center px-2 sm:px-4 py-3 gap-2 sm:gap-3">
            <!-- Local -->
            <div class="flex items-center gap-1.5 sm:gap-2 min-w-0 justify-end text-right">
              <span class="font-medium text-sm sm:text-base truncate" [class.font-bold]="f.homeWinner">{{ f.homeTeamName }}</span>
              <img *ngIf="f.homeTeamLogo" [src]="f.homeTeamLogo" alt="" class="w-5 h-5 sm:w-6 sm:h-6 object-contain shrink-0" />
            </div>
            <!-- Marcador / estado -->
            <div class="text-center px-1 min-w-[64px] sm:min-w-[88px]">
              <div *ngIf="hasScore(f)" class="font-bold text-night text-base sm:text-lg leading-tight">
                {{ f.goalsHome }} - {{ f.goalsAway }}
              </div>
              <div *ngIf="!hasScore(f)" class="text-xs text-slate-500 leading-tight">
                {{ f.fixtureDate | date:'dd/MM HH:mm' }}
              </div>
              <div class="text-[9px] sm:text-[10px] uppercase tracking-wide"
                   [class.text-rose-600]="isLive(f)"
                   [class.text-slate-400]="!isLive(f)">
                {{ statusLabel(f) }}
              </div>
            </div>
            <!-- Visitante -->
            <div class="flex items-center gap-1.5 sm:gap-2 min-w-0">
              <img *ngIf="f.awayTeamLogo" [src]="f.awayTeamLogo" alt="" class="w-5 h-5 sm:w-6 sm:h-6 object-contain shrink-0" />
              <span class="font-medium text-sm sm:text-base truncate" [class.font-bold]="f.awayWinner">{{ f.awayTeamName }}</span>
            </div>
          </div>
        </div>
      </div>
    </section>
  `
})
export class LiveComponent implements OnInit {
  readonly seasons = [2026, 2022];
  season = 2026;
  fixtures: WorldCupFixtureItem[] = [];
  rounds: RoundGroup[] = [];
  bracket: BracketRound[] = [];
  loading = true;
  syncing = false;
  message = '';
  isError = false;

  constructor(private api: ApiService) {}

  ngOnInit(): void {
    this.load();
    this.loadBracket();
  }

  /** Cambia el Mundial mostrado y recarga partidos + bracket de esa temporada. */
  selectSeason(s: number): void {
    if (s === this.season || this.syncing) return;
    this.season = s;
    this.message = '';
    this.isError = false;
    this.fixtures = [];
    this.rounds = [];
    this.bracket = [];
    this.load();
    this.loadBracket();
  }

  load(): void {
    this.loading = true;
    this.api.getWorldCupFixtures(this.season).subscribe({
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

  /** Bracket de eliminatorias con predicciones (no bloquea la lista de partidos si falla). */
  loadBracket(): void {
    this.api.getWorldCupBracket(this.season).subscribe({
      next: (data) => (this.bracket = data),
      error: () => (this.bracket = [])
    });
  }

  hasGoals(m: BracketMatchItem): boolean {
    return m.goalsHome !== null && m.goalsAway !== null;
  }

  sync(): void {
    this.syncing = true;
    this.message = '';
    this.api.syncWorldCup(1, this.season).subscribe({
      next: (res) => {
        this.isError = res.status?.startsWith('ERROR') ?? false;
        this.message = this.isError
          ? `Sincronización con problemas: ${res.status}`
          : `Mundial ${this.season} sincronizado: ${res.fixturesInserted} nuevos, ${res.fixturesUpdated} actualizados.`;
        this.syncing = false;
        this.load();
        this.loadBracket();
      },
      error: (e) => {
        this.message = e?.error?.error || 'Error al sincronizar.';
        this.isError = true;
        this.syncing = false;
      }
    });
  }

  /** Orden descendente: los partidos más recientes primero, tanto entre rondas como dentro de cada una. */
  private groupByRound(list: WorldCupFixtureItem[]): RoundGroup[] {
    const sorted = [...list].sort((a, b) => this.time(b) - this.time(a));
    const map = new Map<string, WorldCupFixtureItem[]>();
    for (const f of sorted) {
      const key = f.round || 'Sin ronda';
      if (!map.has(key)) map.set(key, []);
      map.get(key)!.push(f);
    }
    // El Map preserva el orden de inserción → la primera ronda es la del partido más reciente.
    return Array.from(map.entries()).map(([round, fixtures]) => ({ round, fixtures }));
  }

  private time(f: WorldCupFixtureItem): number {
    const t = f.fixtureDate ? Date.parse(f.fixtureDate) : NaN;
    return isNaN(t) ? 0 : t;
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

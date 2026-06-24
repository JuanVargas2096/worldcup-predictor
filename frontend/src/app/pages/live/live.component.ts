import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ApiService } from '../../core/api.service';
import { WorldCupFixtureItem, BracketRound, BracketMatchItem } from '../../models/models';

interface RoundGroup {
  round: string;
  fixtures: WorldCupFixtureItem[];
}

interface BracketColumn {
  round: string;
  matches: BracketMatchItem[];
  pairs: boolean;
  leadin: boolean;
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

      <!-- ======================= Eliminatorias · Llave (bracket) ======================= -->
      <div *ngIf="bracket.length" class="mb-8">
        <h2 class="text-lg sm:text-xl font-bold text-night mb-1">Eliminatorias · Llave</h2>
        <p class="text-xs sm:text-sm text-slate-500 mb-1">
          Dos llaves que convergen hacia la final. El % es la probabilidad de avanzar; en verde, quien pasó de ronda.
        </p>
        <p class="text-[11px] text-slate-400 mb-3 sm:hidden">↔ Desliza horizontalmente para ver toda la llave.</p>

        <div class="overflow-x-auto pb-3">
          <div class="bk-row flex items-stretch w-max mx-auto">

            <!-- Mitad izquierda: rondas de fuera hacia el centro -->
            <div *ngFor="let col of leftColumns"
                 class="bk-col bk-left flex flex-col w-[140px] sm:w-[160px] shrink-0"
                 [class.bk-pairs]="col.pairs" [class.bk-single]="!col.pairs" [class.bk-leadin]="col.leadin">
              <div class="bk-head h-6 text-[10px] sm:text-[11px] uppercase tracking-wide text-slate-400 font-semibold text-center mb-1">{{ col.round }}</div>
              <div class="bk-body flex-1 flex flex-col">
                <div *ngFor="let m of col.matches; let i = index"
                     class="bk-m flex items-center"
                     [class.bk-top]="col.pairs && i % 2 === 0" [class.bk-bottom]="col.pairs && i % 2 === 1">
                  <ng-container [ngTemplateOutlet]="cell" [ngTemplateOutletContext]="{ m: m }"></ng-container>
                </div>
              </div>
            </div>

            <!-- Centro: Final -->
            <div *ngIf="finalMatch" class="bk-col flex flex-col w-[150px] sm:w-[180px] shrink-0">
              <div class="bk-head h-6 text-[11px] sm:text-xs uppercase tracking-wide text-amber-600 font-bold text-center mb-1">🏆 Final</div>
              <div class="bk-body flex-1 flex flex-col">
                <div class="bk-m bk-final flex items-center">
                  <ng-container [ngTemplateOutlet]="cell" [ngTemplateOutletContext]="{ m: finalMatch, big: true }"></ng-container>
                </div>
              </div>
            </div>

            <!-- Mitad derecha: rondas del centro hacia fuera -->
            <div *ngFor="let col of rightColumns"
                 class="bk-col bk-right flex flex-col w-[140px] sm:w-[160px] shrink-0"
                 [class.bk-pairs]="col.pairs" [class.bk-single]="!col.pairs" [class.bk-leadin]="col.leadin">
              <div class="bk-head h-6 text-[10px] sm:text-[11px] uppercase tracking-wide text-slate-400 font-semibold text-center mb-1">{{ col.round }}</div>
              <div class="bk-body flex-1 flex flex-col">
                <div *ngFor="let m of col.matches; let i = index"
                     class="bk-m flex items-center"
                     [class.bk-top]="col.pairs && i % 2 === 0" [class.bk-bottom]="col.pairs && i % 2 === 1">
                  <ng-container [ngTemplateOutlet]="cell" [ngTemplateOutletContext]="{ m: m }"></ng-container>
                </div>
              </div>
            </div>

          </div>
        </div>

        <!-- Campeón + tercer puesto (debajo, para no descentrar la final) -->
        <div *ngIf="champion(finalMatch) || thirdPlace" class="mt-4 flex flex-col items-center gap-3">
          <div *ngIf="champion(finalMatch) as champ" class="text-sm font-bold text-amber-600">🏆 Campeón: {{ champ }}</div>
          <div *ngIf="thirdPlace" class="w-[180px]">
            <div class="text-[10px] uppercase tracking-wide text-slate-400 font-semibold text-center mb-1">3.er puesto</div>
            <ng-container [ngTemplateOutlet]="cell" [ngTemplateOutletContext]="{ m: thirdPlace }"></ng-container>
          </div>
        </div>
      </div>

      <!-- Plantilla de celda de partido (reutilizada en ambas mitades y la final) -->
      <ng-template #cell let-m="m" let-big="big">
        <div class="bk-card w-full bg-white rounded-lg shadow-sm overflow-hidden" [title]="m.advice || ''"
             [class.border-2]="big" [class.border-amber-300]="big"
             [class.border]="!big" [class.border-slate-200]="!big">
          <!-- Local -->
          <div class="flex items-center gap-1.5 px-2 py-1 border-b border-slate-100" [class.bg-emerald-50]="m.homeWinner">
            <img *ngIf="m.home?.logo" [src]="m.home?.logo" alt="" class="w-4 h-4 object-contain shrink-0" />
            <span class="flex-1 truncate text-[11px] sm:text-xs" [class.font-bold]="m.homeWinner"
                  [class.text-slate-400]="!m.home">{{ m.home?.name || 'Por definir' }}</span>
            <span *ngIf="m.winProbHome !== null" class="text-[9px] text-emerald-700 tabular-nums shrink-0">{{ m.winProbHome | number:'1.0-0' }}%</span>
            <span *ngIf="hasGoals(m)" class="text-xs font-bold tabular-nums w-3 text-center shrink-0"
                  [class.text-slate-400]="m.awayWinner && !m.homeWinner">{{ m.goalsHome }}</span>
          </div>
          <!-- Visitante -->
          <div class="flex items-center gap-1.5 px-2 py-1" [class.bg-emerald-50]="m.awayWinner">
            <img *ngIf="m.away?.logo" [src]="m.away?.logo" alt="" class="w-4 h-4 object-contain shrink-0" />
            <span class="flex-1 truncate text-[11px] sm:text-xs" [class.font-bold]="m.awayWinner"
                  [class.text-slate-400]="!m.away">{{ m.away?.name || 'Por definir' }}</span>
            <span *ngIf="m.winProbAway !== null" class="text-[9px] text-sky-700 tabular-nums shrink-0">{{ m.winProbAway | number:'1.0-0' }}%</span>
            <span *ngIf="hasGoals(m)" class="text-xs font-bold tabular-nums w-3 text-center shrink-0"
                  [class.text-slate-400]="m.homeWinner && !m.awayWinner">{{ m.goalsAway }}</span>
          </div>
          <!-- Fecha si aún no se jugó -->
          <div *ngIf="!hasGoals(m) && (m.home || m.away)" class="text-[8px] text-slate-400 text-center py-0.5 bg-slate-50">
            {{ m.fixtureDate | date:'dd/MM HH:mm' }}
          </div>
        </div>
      </ng-template>
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
  `,
  styles: [`
    /* Separación fija entre columnas = 2× ancho de cada tramo de conector (1rem). */
    .bk-row { gap: 2rem; }
    /* Cada partido ocupa un slot de igual altura → los hermanos quedan centrados respecto
       al partido de la ronda interior (alineación exacta de los conectores). */
    .bk-m { position: relative; flex: 1 1 0%; min-height: 3.75rem; }

    /* ---------- IZQUIERDA: conectores hacia la derecha ---------- */
    .bk-left.bk-pairs .bk-top::after,
    .bk-left.bk-pairs .bk-bottom::after {
      content: ''; position: absolute; right: -1rem; width: 1rem; border-right: 2px solid #cbd5e1;
    }
    .bk-left.bk-pairs .bk-top::after    { top: 50%;    height: 50%; border-top: 2px solid #cbd5e1; }
    .bk-left.bk-pairs .bk-bottom::after { bottom: 50%; height: 50%; border-bottom: 2px solid #cbd5e1; }
    .bk-left.bk-single .bk-m::after {
      content: ''; position: absolute; right: -1rem; top: 50%; width: 1rem; border-top: 2px solid #cbd5e1;
    }
    .bk-left.bk-leadin .bk-m::before {
      content: ''; position: absolute; left: -1rem; top: 50%; width: 1rem; border-top: 2px solid #cbd5e1;
    }

    /* ---------- DERECHA: espejo, conectores hacia la izquierda ---------- */
    .bk-right.bk-pairs .bk-top::before,
    .bk-right.bk-pairs .bk-bottom::before {
      content: ''; position: absolute; left: -1rem; width: 1rem; border-left: 2px solid #cbd5e1;
    }
    .bk-right.bk-pairs .bk-top::before    { top: 50%;    height: 50%; border-top: 2px solid #cbd5e1; }
    .bk-right.bk-pairs .bk-bottom::before { bottom: 50%; height: 50%; border-bottom: 2px solid #cbd5e1; }
    .bk-right.bk-single .bk-m::before {
      content: ''; position: absolute; left: -1rem; top: 50%; width: 1rem; border-top: 2px solid #cbd5e1;
    }
    .bk-right.bk-leadin .bk-m::after {
      content: ''; position: absolute; right: -1rem; top: 50%; width: 1rem; border-top: 2px solid #cbd5e1;
    }

    /* ---------- FINAL: recibe un tramo de cada lado ---------- */
    .bk-final::before { content: ''; position: absolute; left: -1rem;  top: 50%; width: 1rem; border-top: 2px solid #cbd5e1; }
    .bk-final::after  { content: ''; position: absolute; right: -1rem; top: 50%; width: 1rem; border-top: 2px solid #cbd5e1; }
  `]
})
export class LiveComponent implements OnInit {
  readonly seasons = [2026, 2022];
  season = 2026;
  fixtures: WorldCupFixtureItem[] = [];
  rounds: RoundGroup[] = [];
  bracket: BracketRound[] = [];
  // Columnas de la llave (bracket de dos lados que converge en la final).
  // pairs = la columna emparejada dibuja conectores en "Y" hacia la ronda interior (len > 1);
  // leadin = la columna recibe un conector de su ronda exterior (todas menos la más externa).
  leftColumns: BracketColumn[] = [];
  rightColumns: BracketColumn[] = [];
  finalMatch: BracketMatchItem | null = null;
  thirdPlace: BracketMatchItem | null = null;
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
    this.buildBracketColumns();
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
      next: (data) => {
        this.bracket = data;
        this.buildBracketColumns();
      },
      error: () => {
        this.bracket = [];
        this.buildBracketColumns();
      }
    });
  }

  /**
   * Reparte las rondas en dos mitades para dibujar la llave: la primera mitad de cada ronda va a la
   * izquierda y la segunda a la derecha (mismo emparejamiento de hermanos del backend). La final queda
   * al centro y el 3.er puesto debajo de ella.
   */
  private buildBracketColumns(): void {
    const knockout = this.bracket.filter((r) => r.round !== 'Final' && r.round !== 'Tercer puesto');

    // Izquierda: rondas de fuera (más partidos) hacia el centro. La más externa (índice 0) no recibe
    // conector entrante (leadin = false).
    this.leftColumns = knockout.map((r, i, arr) => {
      const matches = r.matches.slice(0, Math.ceil(r.matches.length / 2));
      return { round: r.round, matches, pairs: matches.length > 1, leadin: i > 0 } as BracketColumn;
    });

    // Derecha: espejo. El orden es del centro hacia fuera; la más externa (última) no recibe leadin.
    const rev = [...knockout].reverse();
    this.rightColumns = rev.map((r, i) => {
      const matches = r.matches.slice(Math.ceil(r.matches.length / 2));
      return { round: r.round, matches, pairs: matches.length > 1, leadin: i < rev.length - 1 } as BracketColumn;
    });

    this.finalMatch = this.bracket.find((r) => r.round === 'Final')?.matches[0] ?? null;
    this.thirdPlace = this.bracket.find((r) => r.round === 'Tercer puesto')?.matches[0] ?? null;
  }

  hasGoals(m: BracketMatchItem): boolean {
    return m.goalsHome !== null && m.goalsAway !== null;
  }

  /** Nombre del equipo que ganó la final (campeón), o null si aún no se define. */
  champion(m: BracketMatchItem | null): string | null {
    if (!m) return null;
    if (m.homeWinner) return m.home?.name ?? null;
    if (m.awayWinner) return m.away?.name ?? null;
    return null;
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

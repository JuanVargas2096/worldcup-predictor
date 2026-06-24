import {
  AfterViewChecked,
  Component,
  ElementRef,
  NgZone,
  OnDestroy,
  OnInit,
  ViewChild
} from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { Chart, registerables } from 'chart.js';
import { ApiService } from '../../core/api.service';
import { TeamDetail } from '../../models/models';
import { FormBadgesComponent } from '../../components/form-badges.component';

Chart.register(...registerables);

interface BreakdownRow {
  label: string;
  value: number;
  color: string;
}

@Component({
  selector: 'app-team-detail',
  standalone: true,
  imports: [CommonModule, RouterLink, FormBadgesComponent],
  template: `
    <a routerLink="/ranking" class="text-sm text-emerald-700 hover:underline">&larr; Volver al ranking</a>

    <div *ngIf="error" class="bg-rose-100 text-rose-700 px-4 py-3 rounded my-4 text-sm">{{ error }}</div>
    <div *ngIf="loading" class="text-slate-500 py-10 text-center">Cargando detalle…</div>

    <section *ngIf="detail as d" class="mt-3 space-y-6">
      <!-- Cabecera -->
      <div class="bg-white rounded-xl shadow p-4 sm:p-5 flex items-center gap-3 sm:gap-4" [class.opacity-75]="d.ranking.isEliminated">
        <span class="text-4xl sm:text-5xl shrink-0" [class.grayscale]="d.ranking.isEliminated">{{ d.ranking.flagEmoji }}</span>
        <div class="flex-1 min-w-0">
          <div class="flex items-center gap-2 flex-wrap">
            <h1 class="text-xl sm:text-2xl font-bold text-night" [class.line-through]="d.ranking.isEliminated">{{ d.ranking.name }}</h1>
            <span *ngIf="d.ranking.isEliminated" class="text-xs bg-rose-100 text-rose-600 px-2 py-0.5 rounded-full font-bold uppercase tracking-wide">Eliminado</span>
          </div>
          <p class="text-xs sm:text-sm text-slate-500">
            {{ d.ranking.confederation }} · Grupo {{ d.ranking.groupLetter }} ·
            Posición #{{ d.ranking.position }}
          </p>
        </div>
        <div class="text-right shrink-0">
          <div class="text-2xl sm:text-3xl font-bold text-emerald-600" [class.text-slate-400]="d.ranking.isEliminated">{{ d.ranking.finalScore | number:'1.1-1' }}</div>
          <div class="text-[10px] sm:text-xs text-slate-500">Score · {{ d.ranking.winProbability | number:'1.1-1' }}% título</div>
        </div>
      </div>

      <!-- Stats rápidas -->
      <div class="grid grid-cols-2 md:grid-cols-4 gap-3">
        <div class="bg-white rounded-xl shadow p-4 text-center">
          <div class="text-2xl font-bold text-night">{{ d.wins }}-{{ d.draws }}-{{ d.losses }}</div>
          <div class="text-[10px] uppercase tracking-wider text-slate-400 font-semibold">V-E-D ({{ d.played }} part.)</div>
        </div>
        <div class="bg-white rounded-xl shadow p-4 text-center">
          <div class="text-2xl font-bold text-night">{{ d.goalsFor }}:{{ d.goalsAgainst }}</div>
          <div class="text-[10px] uppercase tracking-wider text-slate-400 font-semibold">Goles (Dif {{ d.goalDiff >= 0 ? '+' : '' }}{{ d.goalDiff }})</div>
        </div>
        <div class="bg-white rounded-xl shadow p-4 text-center">
          <div class="text-2xl font-bold text-night">{{ d.averageOpponentStrength | number:'1.0-1' }}</div>
          <div class="text-[10px] uppercase tracking-wider text-slate-400 font-semibold">Fuerza Rival</div>
        </div>
        <div class="bg-white rounded-xl shadow p-4 text-center">
          <div class="text-sm font-bold text-night truncate px-1">{{ d.previousWorldCupLabel }}</div>
          <div class="text-[10px] uppercase tracking-wider text-slate-400 font-semibold">Mundial 2022</div>
        </div>
      </div>

      <!-- Desglose del score -->
      <div class="bg-white rounded-xl shadow p-5">
        <h2 class="font-bold text-night mb-3">Desglose del puntaje</h2>
        <div class="space-y-2">
          <div *ngFor="let b of breakdownData">
            <div class="flex justify-between text-sm">
              <span class="text-slate-600">{{ b.label }}</span>
              <span class="font-semibold">{{ b.value | number:'1.1-1' }}</span>
            </div>
            <div class="w-full bg-slate-200 rounded-full h-2">
              <div class="h-2 rounded-full" [class]="b.color" [style.width.%]="b.value"></div>
            </div>
          </div>
        </div>
        <p class="mt-4 text-sm text-slate-600 bg-slate-50 rounded p-3 leading-relaxed">
          {{ d.ranking.explanation }}
        </p>
      </div>

      <!-- Evolución -->
      <div class="bg-white rounded-xl shadow p-5">
        <h2 class="font-bold text-night mb-3">Evolución del score</h2>

        <div *ngIf="!d.scoreHistory || d.scoreHistory.length < 2" class="text-sm text-slate-500 bg-emerald-50 p-4 rounded-lg border border-emerald-100">
          <p class="font-semibold text-emerald-800 mb-1">Gráfico de evolución</p>
          Aún no hay suficientes cálculos para graficar la evolución.
          Presiona el botón <strong>Recalcular</strong> en el ranking para generar un nuevo punto en el historial.
        </div>

        <div class="w-full" style="height: 250px;" *ngIf="d.scoreHistory && d.scoreHistory.length >= 2">
          <canvas #chart></canvas>
        </div>
      </div>

      <!-- Últimos 5 -->
      <div class="bg-white rounded-xl shadow p-5">
        <div class="flex items-center justify-between mb-3">
          <h2 class="font-bold text-night">Últimos 5 partidos</h2>
          <app-form-badges [matches]="d.ranking.lastFive"></app-form-badges>
        </div>
        <div *ngIf="!d.ranking.lastFive.length" class="text-sm text-slate-500 bg-slate-50 p-4 rounded-lg text-center">
          No se encontraron partidos recientes para esta selección.
          Asegúrate de haber importado los datos desde el panel de configuración o mediante el API.
        </div>
        <table *ngIf="d.ranking.lastFive.length" class="min-w-full text-sm">
          <tbody>
            <tr *ngFor="let m of d.ranking.lastFive" class="border-t border-slate-100 align-top">
              <td class="py-2 pr-2 text-xs sm:text-sm text-slate-400 whitespace-nowrap">{{ m.date }}</td>
              <td class="py-2">
                <div class="truncate">{{ m.opponentFlag }} {{ m.opponentName }}</div>
                <!-- Competición: bajo el rival en móvil (la columna dedicada se oculta) -->
                <div class="text-[11px] text-slate-400 truncate sm:hidden">{{ m.competition }}</div>
              </td>
              <td class="py-2 text-xs text-slate-400 hidden sm:table-cell">{{ m.competition }}</td>
              <td class="py-2 pl-2 text-right font-semibold whitespace-nowrap">{{ m.goalsFor }} - {{ m.goalsAgainst }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </section>
  `
})
export class TeamDetailComponent implements OnInit, AfterViewChecked, OnDestroy {
  // ViewChild SIN setter con efectos secundarios (un setter que crea el gráfico
  // provocaba un bucle de detección de cambios con la animación de Chart.js → cuelgue).
  @ViewChild('chart') chartRef?: ElementRef<HTMLCanvasElement>;

  detail?: TeamDetail;
  breakdownData: BreakdownRow[] = [];
  loading = true;
  error = '';
  private chart?: Chart;

  constructor(
    private route: ActivatedRoute,
    private api: ApiService,
    private zone: NgZone
  ) {}

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id')!;
    this.api.getTeamDetail(id).subscribe({
      next: (d) => {
        this.detail = d;
        this.breakdownData = this.buildBreakdown(d);
        this.loading = false;
        // El gráfico se dibuja en ngAfterViewChecked, cuando el <canvas> del *ngIf
        // ya está en el DOM con su tamaño calculado.
      },
      error: () => {
        this.error = 'No se pudo cargar el detalle del equipo.';
        this.loading = false;
      }
    });
  }

  ngAfterViewChecked(): void {
    // Se dispara tras cada detección de cambios; cuando el canvas del *ngIf existe
    // y aún no hay gráfico, lo crea una sola vez (guard `this.chart`).
    this.renderChart();
  }

  ngOnDestroy(): void {
    this.chart?.destroy();
  }

  private buildBreakdown(d: TeamDetail): BreakdownRow[] {
    const r = d.ranking;
    return [
      { label: 'Forma (últimos 5)', value: r.formScore, color: 'bg-emerald-500' },
      { label: 'Diferencia de goles', value: r.goalDiffScore, color: 'bg-sky-500' },
      { label: 'Fuerza de rivales', value: r.opponentStrengthScore, color: 'bg-violet-500' },
      { label: 'Mundial anterior', value: r.previousWorldCupScore, color: 'bg-amber-500' },
      { label: 'ELO / ranking', value: r.eloScore, color: 'bg-rose-500' }
    ];
  }

  private renderChart(): void {
    // Guard síncrono: si ya existe el gráfico o aún no está el canvas, no hacemos nada.
    if (this.chart || !this.detail || !this.chartRef) return;
    const history = this.detail.scoreHistory || [];
    if (history.length < 2) return;

    const labels = history.map((h) => {
      const date = new Date(h.calculatedAt);
      return isNaN(date.getTime())
        ? '—'
        : date.toLocaleDateString([], { day: '2-digit', month: '2-digit' });
    });
    const data = history.map((h) => h.finalScore);
    const canvas = this.chartRef.nativeElement;

    // Creamos el gráfico FUERA de la zona de Angular (su ResizeObserver/rAF interno
    // no debe disparar detección de cambios). this.chart se asigna de forma síncrona,
    // por lo que el guard evita crear el gráfico más de una vez.
    this.zone.runOutsideAngular(() => {
      this.chart = new Chart(canvas, {
        type: 'line',
        data: {
          labels,
          datasets: [
            {
              label: 'Score final',
              data,
              borderColor: '#059669',
              backgroundColor: 'rgba(5,150,105,0.15)',
              tension: 0.3,
              fill: true,
              pointRadius: history.length > 20 ? 0 : 3
            }
          ]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          animation: false,
          scales: { y: { beginAtZero: true, max: 100, ticks: { stepSize: 20 } } },
          plugins: { legend: { display: false } }
        }
      });
    });
  }
}

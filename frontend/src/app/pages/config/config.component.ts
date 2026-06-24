import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../core/api.service';
import { ScoringConfig } from '../../models/models';

interface WeightField {
  key: keyof ScoringConfig;
  label: string;
  hint: string;
}

@Component({
  selector: 'app-config',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
    <section class="max-w-xl mx-auto">
      <h1 class="text-2xl font-bold text-night mb-1">Configuración del modelo</h1>
      <p class="text-sm text-slate-500 mb-4">
        Ajusta el peso de cada componente. La suma debe ser exactamente 100%.
      </p>

      <div *ngIf="message" class="px-4 py-3 rounded mb-4 text-sm"
           [class.bg-emerald-100]="!isError" [class.text-emerald-700]="!isError"
           [class.bg-rose-100]="isError" [class.text-rose-700]="isError">
        {{ message }}
      </div>

      <div *ngIf="loading" class="text-slate-500 py-10 text-center">Cargando…</div>

      <form *ngIf="!loading" (ngSubmit)="save()" class="bg-white rounded-xl shadow p-5 space-y-5">
        <div *ngFor="let f of fields">
          <div class="flex justify-between mb-1">
            <label class="text-sm font-semibold text-night">{{ f.label }}</label>
            <span class="text-sm font-mono">{{ percent[f.key] }}%</span>
          </div>
          <input type="range" min="0" max="100" step="5"
                 [(ngModel)]="percent[f.key]" [name]="f.key"
                 class="w-full accent-emerald-600" />
          <p class="text-xs text-slate-400">{{ f.hint }}</p>
        </div>

        <div class="flex items-center justify-between border-t border-slate-100 pt-4">
          <span class="text-sm font-semibold">Suma total</span>
          <span class="text-lg font-bold"
                [class.text-emerald-600]="total === 100"
                [class.text-rose-600]="total !== 100">{{ total }}%</span>
        </div>

        <button type="submit" [disabled]="total !== 100 || saving"
                class="w-full bg-emerald-600 hover:bg-emerald-700 disabled:opacity-50 text-white py-2.5 rounded-md font-semibold transition">
          {{ saving ? 'Guardando…' : 'Guardar y recalcular' }}
        </button>
        <p *ngIf="total !== 100" class="text-xs text-rose-500 text-center">
          La suma debe ser 100% para poder guardar.
        </p>
      </form>

      <!-- Importación de datos -->
      <div class="mt-8 bg-white rounded-xl shadow p-5">
        <h2 class="font-bold text-night mb-1">Datos y Partidos</h2>
        <p class="text-xs text-slate-500 mb-4">
          Si algunas selecciones no muestran partidos recientes, puedes forzar una importación desde la API externa.
        </p>
        <button (click)="importData()" [disabled]="importing"
                class="w-full border border-emerald-600 text-emerald-600 hover:bg-emerald-50 disabled:opacity-50 py-2 rounded-md font-semibold transition text-sm">
          {{ importing ? 'Importando partidos…' : 'Importar partidos ahora' }}
        </button>
      </div>
    </section>
  `
})
export class ConfigComponent implements OnInit {
  fields: WeightField[] = [
    { key: 'formWeight', label: 'Forma (últimos 5)', hint: 'Resultados recientes.' },
    { key: 'goalDiffWeight', label: 'Diferencia de goles', hint: 'Goles a favor menos en contra.' },
    { key: 'opponentStrengthWeight', label: 'Fuerza de rivales', hint: 'Nivel de los rivales enfrentados.' },
    { key: 'previousWorldCupWeight', label: 'Mundial anterior', hint: 'Desempeño en Qatar 2022.' },
    { key: 'eloWeight', label: 'ELO / ranking', hint: 'Fuerza histórica de la selección.' }
  ];
  percent: Record<string, number> = {};
  loading = true;
  saving = false;
  importing = false;
  message = '';
  isError = false;

  constructor(private api: ApiService) {}

  get total(): number {
    return this.fields.reduce((acc, f) => acc + (this.percent[f.key] || 0), 0);
  }

  ngOnInit(): void {
    this.api.getScoringConfig().subscribe({
      next: (cfg) => {
        for (const f of this.fields) {
          this.percent[f.key] = Math.round((cfg[f.key] as number) * 100);
        }
        this.loading = false;
      },
      error: () => {
        this.message = 'No se pudo cargar la configuración.';
        this.isError = true;
        this.loading = false;
      }
    });
  }

  save(): void {
    if (this.total !== 100) return;
    this.saving = true;
    this.message = '';
    const payload: ScoringConfig = {
      formWeight: this.percent['formWeight'] / 100,
      goalDiffWeight: this.percent['goalDiffWeight'] / 100,
      opponentStrengthWeight: this.percent['opponentStrengthWeight'] / 100,
      previousWorldCupWeight: this.percent['previousWorldCupWeight'] / 100,
      eloWeight: this.percent['eloWeight'] / 100
    };
    this.api.updateScoringConfig(payload).subscribe({
      next: () => {
        this.message = 'Configuración guardada y ranking recalculado.';
        this.isError = false;
        this.saving = false;
      },
      error: (e) => {
        this.message = e?.error?.error || 'No se pudo guardar la configuración.';
        this.isError = true;
        this.saving = false;
      }
    });
  }

  importData(): void {
    this.importing = true;
    this.message = '';
    this.api.importMatches().subscribe({
      next: (res: any) => {
        this.message = `Importación completada: ${res.imported} partidos nuevos. Recalculando ranking...`;
        this.isError = false;
        // Recalculamos el ranking para que los nuevos partidos influyan
        this.api.recalculate().subscribe(() => {
          this.importing = false;
        });
      },
      error: (e) => {
        this.message = e?.error?.message || 'Error al importar datos de la API.';
        this.isError = true;
        this.importing = false;
      }
    });
  }
}

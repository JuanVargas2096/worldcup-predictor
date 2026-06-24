import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../core/api.service';
import { ScoringConfig, ApiKeyStatus } from '../../models/models';

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
      <h1 class="text-xl sm:text-2xl font-bold text-night mb-1">Configuración del modelo</h1>
      <p class="text-xs sm:text-sm text-slate-500 mb-4">
        Ajusta el peso de cada componente. La suma debe ser exactamente 100%.
      </p>

      <div *ngIf="message" class="px-4 py-3 rounded mb-4 text-sm"
           [class.bg-emerald-100]="!isError" [class.text-emerald-700]="!isError"
           [class.bg-rose-100]="isError" [class.text-rose-700]="isError">
        {{ message }}
      </div>

      <div *ngIf="loading" class="text-slate-500 py-10 text-center">Cargando…</div>

      <form *ngIf="!loading" (ngSubmit)="save()" class="bg-white rounded-xl shadow p-4 sm:p-5 space-y-5">
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

      <!-- API key (API-Football) — guardada en BD -->
      <div class="bg-white rounded-xl shadow p-4 sm:p-5 mt-6">
        <h2 class="text-sm font-bold text-night mb-1">API key (API-Football)</h2>
        <p class="text-xs text-slate-500 mb-3">
          Se guarda en la base de datos (no en variables de entorno). Necesaria para sincronizar
          partidos reales y predicciones.
        </p>

        <div class="flex items-center gap-2 mb-3 text-xs">
          <span class="font-semibold">Estado:</span>
          <span *ngIf="apiKeyStatus?.configured" class="text-emerald-700">
            Configurada ({{ apiKeyStatus?.masked }}) · origen: {{ apiKeyStatus?.source }}
          </span>
          <span *ngIf="apiKeyStatus && !apiKeyStatus.configured" class="text-rose-600">No configurada</span>
        </div>

        <div *ngIf="keyMessage" class="px-3 py-2 rounded mb-3 text-xs"
             [class.bg-emerald-100]="!keyError" [class.text-emerald-700]="!keyError"
             [class.bg-rose-100]="keyError" [class.text-rose-700]="keyError">
          {{ keyMessage }}
        </div>

        <div class="flex flex-col sm:flex-row gap-2">
          <input type="password" [(ngModel)]="apiKeyInput" name="apiKey" placeholder="Pega aquí tu API key"
                 class="flex-1 border border-slate-300 rounded-md px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500" />
          <button type="button" (click)="saveApiKey()" [disabled]="!apiKeyInput || savingKey"
                  class="bg-emerald-600 hover:bg-emerald-700 disabled:opacity-50 text-white px-4 py-2 rounded-md text-sm font-semibold transition whitespace-nowrap">
            {{ savingKey ? 'Guardando…' : 'Guardar key' }}
          </button>
        </div>
      </div>

      <!-- Los partidos/forma se actualizan automáticamente cada 6 horas (cron del backend). -->
      <p class="mt-6 text-xs text-slate-400 text-center">
        Los datos de partidos se sincronizan automáticamente cada 6&nbsp;horas.
      </p>
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
  message = '';
  isError = false;

  // API key (guardada en BD)
  apiKeyStatus: ApiKeyStatus | null = null;
  apiKeyInput = '';
  savingKey = false;
  keyMessage = '';
  keyError = false;

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
    this.loadApiKeyStatus();
  }

  loadApiKeyStatus(): void {
    this.api.getApiKeyStatus().subscribe({
      next: (s) => (this.apiKeyStatus = s),
      error: () => (this.apiKeyStatus = null)
    });
  }

  saveApiKey(): void {
    if (!this.apiKeyInput.trim()) return;
    this.savingKey = true;
    this.keyMessage = '';
    this.api.setApiKey(this.apiKeyInput.trim()).subscribe({
      next: (s) => {
        this.apiKeyStatus = s;
        this.apiKeyInput = '';
        this.keyError = false;
        this.keyMessage = 'API key guardada en la base de datos.';
        this.savingKey = false;
      },
      error: (e) => {
        this.keyError = true;
        this.keyMessage = e?.error?.error || 'No se pudo guardar la API key.';
        this.savingKey = false;
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

}

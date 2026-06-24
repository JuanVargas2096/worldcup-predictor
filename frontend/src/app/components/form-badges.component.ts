import { Component, Input } from '@angular/core';
import { NgFor } from '@angular/common';
import { MatchSummary } from '../models/models';

/** Muestra los últimos 5 resultados como badges W/D/L. */
@Component({
  selector: 'app-form-badges',
  standalone: true,
  imports: [NgFor],
  template: `
    <div class="flex gap-1">
      <span *ngFor="let m of (matches || []).slice().reverse()"
            [class]="badgeClass(m.result)"
            [title]="m.opponentFlag + ' ' + m.opponentName + ' ' + m.goalsFor + '-' + m.goalsAgainst">
        {{ m.result }}
      </span>
    </div>
  `
})
export class FormBadgesComponent {
  @Input() matches: MatchSummary[] = [];

  badgeClass(result: string): string {
    const base =
      'inline-flex items-center justify-center w-6 h-6 rounded text-xs font-bold text-white';
    if (result === 'W') return `${base} bg-emerald-600`;
    if (result === 'D') return `${base} bg-amber-500`;
    return `${base} bg-rose-600`;
  }
}

import { Routes } from '@angular/router';

export const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'ranking' },
  {
    path: 'ranking',
    loadComponent: () =>
      import('./pages/ranking/ranking.component').then((m) => m.RankingComponent)
  },
  {
    path: 'equipo/:id',
    loadComponent: () =>
      import('./pages/team-detail/team-detail.component').then((m) => m.TeamDetailComponent)
  },
  {
    path: 'fixture',
    loadComponent: () =>
      import('./pages/fixture/fixture.component').then((m) => m.FixtureComponent)
  },
  {
    path: 'mundial',
    loadComponent: () =>
      import('./pages/live/live.component').then((m) => m.LiveComponent)
  },
  {
    path: 'configuracion',
    loadComponent: () =>
      import('./pages/config/config.component').then((m) => m.ConfigComponent)
  },
  { path: '**', redirectTo: 'ranking' }
];

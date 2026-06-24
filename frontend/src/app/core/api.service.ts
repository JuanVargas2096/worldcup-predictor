import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import {
  RankingEntry,
  TeamDetail,
  GroupView,
  ScoringConfig,
  WorldCupFixtureItem,
  BracketRound,
  ApiKeyStatus,
  SyncResult
} from '../models/models';

/**
 * Cliente HTTP de la API. Base '/api': en producción nginx hace proxy al
 * backend; en desarrollo lo hace proxy.conf.json.
 */
@Injectable({ providedIn: 'root' })
export class ApiService {
  // El backend cuelga de su contexto /worldcup-service; nginx hace proxy de esta ruta.
  private readonly base = '/worldcup-service/api';

  constructor(private http: HttpClient) {}

  getRankings(): Observable<RankingEntry[]> {
    return this.http.get<RankingEntry[]>(`${this.base}/rankings`);
  }

  getTeamDetail(teamId: string): Observable<TeamDetail> {
    return this.http.get<TeamDetail>(`${this.base}/rankings/${teamId}`);
  }

  recalculate(): Observable<unknown> {
    return this.http.post(`${this.base}/rankings/recalculate`, {});
  }

  getGroups(): Observable<GroupView[]> {
    return this.http.get<GroupView[]>(`${this.base}/groups`);
  }

  getScoringConfig(): Observable<ScoringConfig> {
    return this.http.get<ScoringConfig>(`${this.base}/scoring-config`);
  }

  updateScoringConfig(cfg: ScoringConfig): Observable<ScoringConfig> {
    return this.http.put<ScoringConfig>(`${this.base}/scoring-config`, cfg);
  }

  /** Partidos reales del Mundial 2026 sincronizados (solo lectura de BD). */
  getWorldCupFixtures(season = 2026, status?: string): Observable<WorldCupFixtureItem[]> {
    let params = new HttpParams().set('season', season);
    if (status) {
      params = params.set('status', status);
    }
    return this.http.get<WorldCupFixtureItem[]>(`${this.base}/world-cup/fixtures`, { params });
  }

  /** Dispara una sincronización manual contra la API externa. */
  syncWorldCup(league = 1, season = 2026): Observable<SyncResult> {
    const params = new HttpParams().set('league', league).set('season', season);
    return this.http.post<SyncResult>(`${this.base}/world-cup/sync`, {}, { params });
  }

  /** Bracket de eliminatorias con predicciones por partido (solo lectura de BD). */
  getWorldCupBracket(season = 2026): Observable<BracketRound[]> {
    const params = new HttpParams().set('season', season);
    return this.http.get<BracketRound[]>(`${this.base}/world-cup/bracket`, { params });
  }

  /** Refresco manual de predicciones (HTTP a la API, acotado por cuota). */
  refreshPredictions(season = 2026): Observable<{ updated: number }> {
    const params = new HttpParams().set('season', season);
    return this.http.post<{ updated: number }>(`${this.base}/world-cup/predictions/refresh`, {}, { params });
  }

  /** Estado de la API key (guardada en BD, enmascarada). */
  getApiKeyStatus(): Observable<ApiKeyStatus> {
    return this.http.get<ApiKeyStatus>(`${this.base}/config/api-key`);
  }

  /** Guarda/actualiza la API key en BD. */
  setApiKey(value: string): Observable<ApiKeyStatus> {
    return this.http.put<ApiKeyStatus>(`${this.base}/config/api-key`, { value });
  }
}

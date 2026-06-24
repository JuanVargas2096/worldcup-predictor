import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import {
  RankingEntry,
  TeamDetail,
  GroupView,
  ScoringConfig
} from '../models/models';

/**
 * Cliente HTTP de la API. Base '/api': en producción nginx hace proxy al
 * backend; en desarrollo lo hace proxy.conf.json.
 */
@Injectable({ providedIn: 'root' })
export class ApiService {
  private readonly base = '/api';

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
}

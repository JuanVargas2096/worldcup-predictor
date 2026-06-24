export interface MatchSummary {
  date: string;
  result: 'W' | 'D' | 'L';
  goalsFor: number;
  goalsAgainst: number;
  opponentCode: string;
  opponentName: string;
  opponentFlag: string;
  competition: string;
  matchType: string;
}

export interface RankingEntry {
  position: number;
  teamId: string;
  code: string;
  name: string;
  flagEmoji: string;
  confederation: string;
  groupLetter: string;
  finalScore: number;
  winProbability: number;
  formScore: number;
  goalDiffScore: number;
  opponentStrengthScore: number;
  previousWorldCupScore: number;
  eloScore: number;
  lastFive: MatchSummary[];
  explanation: string;
  isEliminated: boolean;
}

export interface ScoreHistoryPoint {
  calculatedAt: string;
  finalScore: number;
  winProbability: number;
}

export interface TeamDetail {
  ranking: RankingEntry;
  played: number;
  wins: number;
  draws: number;
  losses: number;
  goalsFor: number;
  goalsAgainst: number;
  goalDiff: number;
  averageOpponentStrength: number;
  previousWorldCupLabel: string;
  scoreHistory: ScoreHistoryPoint[];
}

export interface FixtureItem {
  id: string;
  groupLetter: string;
  matchday: number;
  scheduledDate: string;
  venue: string;
  homeTeamId: string;
  homeTeamName: string;
  homeTeamCode: string;
  homeFlag: string;
  awayTeamId: string;
  awayTeamName: string;
  awayTeamCode: string;
  awayFlag: string;
  homeScore: number | null;
  awayScore: number | null;
  played: boolean;
}

export interface Team {
  id: string;
  code: string;
  name: string;
  confederation: string;
  fifaRanking: number;
  eloRating: number;
  previousWorldCupResult: string;
  groupLetter: string;
  pot: number;
  flagEmoji: string;
  isEliminated: boolean;
}

export interface GroupView {
  groupLetter: string;
  teams: Team[];
  fixtures: FixtureItem[];
}

export interface ScoringConfig {
  id?: string;
  formWeight: number;
  goalDiffWeight: number;
  opponentStrengthWeight: number;
  previousWorldCupWeight: number;
  eloWeight: number;
}

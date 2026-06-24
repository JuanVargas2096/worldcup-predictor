-- Configuración de pesos por defecto (única fila activa)
INSERT INTO scoring_config (form_weight, goal_diff_weight, opponent_strength_weight,
                            previous_world_cup_weight, elo_weight, active)
VALUES (0.40, 0.20, 0.15, 0.15, 0.10, true);

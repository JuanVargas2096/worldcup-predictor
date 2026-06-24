package com.worldcup.worldcup;

/**
 * Estructura del bracket de eliminación directa del Mundial 2026.
 *
 * La API de fútbol NO entrega el enlace partido→partido del bracket, así que la estructura se
 * codifica aquí. Para mostrar "los 2 posibles rivales de la siguiente fase" basta conocer el
 * <b>partido hermano</b> dentro de la misma ronda: en un bracket de eliminación simple los partidos
 * de una ronda se emparejan de forma consecutiva (0-1, 2-3, 4-5…) y cada par alimenta un partido de
 * la ronda siguiente. Por tanto el hermano del partido en el índice {@code i} es {@code i XOR 1}
 * (una vez ordenados los partidos de la ronda por fecha).
 *
 * NOTA: la correlación índice↔partido real asume que el orden cronológico de los fixtures de la API
 * coincide con el orden del bracket. Si no fuese así, se ajusta el emparejamiento en esta clase.
 */
public final class KnockoutBracket {

    private KnockoutBracket() {}

    /** Rondas de eliminación directa, en orden de avance del torneo. */
    public enum Round {
        ROUND_OF_32("16avos de final", 0),
        ROUND_OF_16("Octavos de final", 1),
        QUARTER_FINALS("Cuartos de final", 2),
        SEMI_FINALS("Semifinales", 3),
        THIRD_PLACE("Tercer puesto", 4),
        FINAL("Final", 5);

        public final String label;
        public final int order;

        Round(String label, int order) {
            this.label = label;
            this.order = order;
        }
    }

    /**
     * Clasifica el texto de ronda que devuelve la API (p. ej. "Round of 32", "Quarter-finals",
     * "3rd Place Final", "Final") en una {@link Round} de knockout. Devuelve {@code null} para fase
     * de grupos o rondas no reconocidas.
     */
    public static Round classify(String apiRound) {
        if (apiRound == null) return null;
        String r = apiRound.toLowerCase();
        if (r.contains("group")) return null;
        if (r.contains("32")) return Round.ROUND_OF_32;
        if (r.contains("16")) return Round.ROUND_OF_16;
        if (r.contains("quarter")) return Round.QUARTER_FINALS;
        if (r.contains("semi")) return Round.SEMI_FINALS;
        if (r.contains("3rd") || r.contains("third")) return Round.THIRD_PLACE;
        if (r.contains("final")) return Round.FINAL;
        return null;
    }

    /** True si el texto de ronda corresponde a una fase de eliminación directa. */
    public static boolean isKnockout(String apiRound) {
        return classify(apiRound) != null;
    }

    /**
     * Índice del partido hermano dentro de la ronda (emparejamiento consecutivo 0-1, 2-3, …).
     * El hermano de un índice par es el siguiente; el de uno impar, el anterior.
     */
    public static int siblingIndex(int index) {
        return index ^ 1;
    }

    /** Rondas que tienen una fase siguiente (la final y el tercer puesto no tienen rival posterior). */
    public static boolean hasNextRound(Round round) {
        return round != null && round != Round.FINAL && round != Round.THIRD_PLACE;
    }
}

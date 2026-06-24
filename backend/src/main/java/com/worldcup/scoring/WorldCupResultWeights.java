package com.worldcup.scoring;

/** Mapea el desempeño en el Mundial anterior a bonus crudo y a escala 0-100. */
public final class WorldCupResultWeights {

    private WorldCupResultWeights() {}

    /** Bonus crudo (-3..+15) según el enunciado. */
    public static int rawBonus(String result) {
        if (result == null) return 0;
        return switch (result) {
            case "CHAMPION" -> 15;
            case "RUNNER_UP" -> 12;
            case "SEMIFINAL" -> 8;
            case "QUARTERFINAL" -> 4;
            case "ROUND_OF_16" -> 2;
            case "GROUP_STAGE" -> 0;
            case "DID_NOT_QUALIFY" -> -3;
            default -> 0;
        };
    }

    /** Reescala el bonus crudo (-3..15) a 0..100 para ponderar en la misma escala. */
    public static double score0to100(String result) {
        int raw = rawBonus(result);
        double normalized = (raw - (-3.0)) / (15.0 - (-3.0)) * 100.0;
        return clamp(normalized);
    }

    public static String label(String result) {
        if (result == null) return "Sin dato";
        return switch (result) {
            case "CHAMPION" -> "Campeón 2022";
            case "RUNNER_UP" -> "Subcampeón 2022";
            case "SEMIFINAL" -> "Semifinalista 2022";
            case "QUARTERFINAL" -> "Cuartos 2022";
            case "ROUND_OF_16" -> "Octavos 2022";
            case "GROUP_STAGE" -> "Fase de grupos 2022";
            case "DID_NOT_QUALIFY" -> "No clasificó a 2022";
            default -> result;
        };
    }

    private static double clamp(double v) {
        return Math.max(0, Math.min(100, v));
    }
}

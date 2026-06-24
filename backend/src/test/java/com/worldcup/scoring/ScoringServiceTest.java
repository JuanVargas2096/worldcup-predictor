package com.worldcup.scoring;

import io.quarkus.test.junit.QuarkusTest;
import jakarta.inject.Inject;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

@QuarkusTest
public class ScoringServiceTest {

    @Inject
    ScoringService scoringService;

    @Test
    public void testNormalize() {
        // Value exactly at min
        Assertions.assertEquals(0.0, ScoringService.normalize(1000, 1000, 2000), 0.001);
        // Value exactly at max
        Assertions.assertEquals(100.0, ScoringService.normalize(2000, 1000, 2000), 0.001);
        // Value in middle
        Assertions.assertEquals(50.0, ScoringService.normalize(1500, 1000, 2000), 0.001);
        // Value outside (should clamp)
        Assertions.assertEquals(0.0, ScoringService.normalize(500, 1000, 2000), 0.001);
        Assertions.assertEquals(100.0, ScoringService.normalize(2500, 1000, 2000), 0.001);
    }

    @Test
    public void testWorldCupResultWeights() {
        Assertions.assertEquals(100.0, WorldCupResultWeights.score0to100("CHAMPION"), 0.001);
        Assertions.assertEquals(0.0, WorldCupResultWeights.score0to100("DID_NOT_QUALIFY"), 0.001);
        // GROUP_STAGE is 0 in raw bonus. normalized: (0 - (-3)) / (15 - (-3)) = 3 / 18 = 1/6 = 16.666...
        Assertions.assertEquals(16.666, WorldCupResultWeights.score0to100("GROUP_STAGE"), 0.01);
    }

    @Test
    public void testOpponentStrengthOf() {
        com.worldcup.team.Team t = new com.worldcup.team.Team();
        
        t.fifaRanking = 1;
        Assertions.assertEquals(100.0, scoringService.opponentStrengthOf(t));
        
        t.fifaRanking = 10;
        Assertions.assertEquals(90.0, scoringService.opponentStrengthOf(t));
        
        t.fifaRanking = 50;
        Assertions.assertEquals(55.0, scoringService.opponentStrengthOf(t));
        
        t.fifaRanking = 100;
        Assertions.assertEquals(35.0, scoringService.opponentStrengthOf(t));
    }

    @Test
    public void testComputeFormStats_Empty() {
        com.worldcup.team.Team t = new com.worldcup.team.Team();
        t.id = java.util.UUID.randomUUID();
        
        FormStats stats = scoringService.computeFormStats(t);
        Assertions.assertNotNull(stats);
        Assertions.assertEquals(0, stats.played());
        Assertions.assertEquals(0.0, stats.opponentStrength());
    }
}

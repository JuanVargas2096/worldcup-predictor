package com.worldcup.worldcup;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.worldcup.provider.dto.ApiFixture;
import io.quarkus.test.junit.QuarkusTest;
import jakarta.inject.Inject;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

@QuarkusTest
public class WorldCupSyncServiceTest {

    @Inject
    ObjectMapper objectMapper;

    @Test
    public void testParseApiFixture() throws Exception {
        String json = """
        {
            "fixture": {
                "id": 123,
                "referee": "John Doe",
                "timezone": "UTC",
                "date": "2026-06-11T16:00:00+00:00",
                "timestamp": 1775923200,
                "venue": {
                    "id": 1,
                    "name": "Azteca",
                    "city": "Mexico City"
                },
                "status": {
                    "long": "Match Finished",
                    "short": "FT",
                    "elapsed": 90
                }
            },
            "league": {
                "id": 1,
                "name": "World Cup",
                "country": "World",
                "season": 2026,
                "round": "Group Stage"
            },
            "teams": {
                "home": {
                    "id": 16,
                    "name": "Mexico",
                    "logo": "logo_mex",
                    "winner": true
                },
                "away": {
                    "id": 20,
                    "name": "Canada",
                    "logo": "logo_can",
                    "winner": false
                }
            },
            "goals": {
                "home": 2,
                "away": 1
            },
            "score": {
                "halftime": {"home": 1, "away": 0},
                "fulltime": {"home": 2, "away": 1}
            }
        }
        """;

        ApiFixture apiFixture = objectMapper.readValue(json, ApiFixture.class);
        
        Assertions.assertEquals(123, apiFixture.fixture().id());
        Assertions.assertEquals("FT", apiFixture.fixture().status().shortStatus());
        Assertions.assertEquals("Match Finished", apiFixture.fixture().status().longStatus());
        Assertions.assertEquals(2026, apiFixture.league().season());
        Assertions.assertEquals("Mexico", apiFixture.teams().home().name());
        Assertions.assertTrue(apiFixture.teams().home().winner());
        Assertions.assertEquals(2, apiFixture.goals().home());
        Assertions.assertEquals(1, apiFixture.score().halftime().home());
    }
}

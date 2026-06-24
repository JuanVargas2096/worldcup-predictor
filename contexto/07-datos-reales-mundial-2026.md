# 07 — Datos Reales del Mundial 2026

## Fuentes
- **Equipos clasificados y sorteo de grupos**: sorteo oficial del 5 de diciembre
  de 2025 (Kennedy Center, Washington D.C.). Fuentes consultadas:
  - FIFA.com — Final Draw results.
  - Wikipedia — "2026 FIFA World Cup draw" (composición exacta de grupos).
  - ESPN — match schedule.
- **Sede**: Canadá, México y Estados Unidos. 48 equipos, 12 grupos de 4.
- **Formato**: avanzan los 2 primeros de cada grupo + los 8 mejores terceros
  (ronda de 32).

> Estos datos (equipos y grupos) son **reales**. Las fechas/sedes exactas de cada
> partido del fixture son aproximadas (round-robin generado); pueden sustituirse
> por el calendario oficial sin cambiar el modelo.

## Composición de grupos (real)

| Grupo | Pot 1 | Equipo | Equipo | Equipo |
|---|---|---|---|---|
| A | México | Corea del Sur | Sudáfrica | Chequia* |
| B | Canadá | Suiza | Qatar | Bosnia* |
| C | Brasil | Marruecos | Haití | Escocia |
| D | Estados Unidos | Australia | Paraguay | Turquía* |
| E | Alemania | Ecuador | Curazao | Costa de Marfil |
| F | Países Bajos | Japón | Túnez | Suecia* |
| G | Bélgica | Irán | Egipto | Nueva Zelanda |
| H | España | Uruguay | Cabo Verde | Arabia Saudita |
| I | Francia | Senegal | Noruega | Irak* |
| J | Argentina | Austria | Argelia | Jordania |
| K | Portugal | Colombia | Uzbekistán | RD Congo* |
| L | Inglaterra | Croacia | Ghana | Panamá |

`*` = clasificado vía repechaje (Pot 4 / playoff).

## Confederaciones de los 48
- **UEFA (16)**: Austria, Bélgica, Bosnia, Croacia, Chequia, Inglaterra, Francia,
  Alemania, Países Bajos, Noruega, Portugal, Escocia, España, Suecia, Suiza, Turquía.
- **CONMEBOL (6)**: Argentina, Brasil, Colombia, Ecuador, Paraguay, Uruguay.
- **AFC (9)**: Australia, Irak, Irán, Japón, Jordania, Corea del Sur, Qatar,
  Arabia Saudita, Uzbekistán.
- **CAF (10)**: Argelia, Cabo Verde, RD Congo, Costa de Marfil, Egipto, Ghana,
  Marruecos, Senegal, Sudáfrica, Túnez.
- **CONCACAF (6)**: Canadá, México, Estados Unidos (anfitriones), Curazao, Haití, Panamá.
- **OFC (1)**: Nueva Zelanda.

## Desempeño Mundial 2022 (Qatar) usado en el scoring
- Campeón: **Argentina**. Subcampeón: **Francia**.
- Semifinalistas: **Croacia**, **Marruecos**.
- Cuartos: **Brasil, Países Bajos, Inglaterra, Portugal**.
- Octavos: **EE. UU., Senegal, Japón, Corea del Sur, Australia, Suiza, España**
  (y Polonia/Brasil ya contados).
- Fase de grupos (jugaron 2022): México, Ecuador, Uruguay, Ghana, Túnez, Camerún,
  Arabia Saudita, Irán, Qatar, Alemania, Bélgica, Canadá, Serbia, Dinamarca…
- No clasificaron a 2022 (DID_NOT_QUALIFY): Noruega, Suecia, Austria, Chequia,
  Bosnia, Turquía, Escocia, Colombia, Paraguay, Egipto, Argelia, Costa de Marfil,
  RD Congo, Cabo Verde, Curazao, Haití, Jordania, Uzbekistán, Irak, Sudáfrica,
  Nueva Zelanda, Panamá.

Valores exactos por equipo: ver `db/migration/V2__seed_teams.sql`.

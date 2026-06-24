-- Corregir mismatch de tipos entre Hibernate (String) y Postgres (CHAR)
-- Hibernate espera VARCHAR para mapear String por defecto.
ALTER TABLE teams ALTER COLUMN group_letter TYPE VARCHAR(1);
ALTER TABLE fixtures ALTER COLUMN group_letter TYPE VARCHAR(1);

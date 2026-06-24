-- Añadir flag de eliminación para equipos
ALTER TABLE teams ADD COLUMN is_eliminated BOOLEAN DEFAULT FALSE;

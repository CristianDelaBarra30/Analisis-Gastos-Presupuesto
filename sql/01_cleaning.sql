SELECT
    CASE 
        WHEN TRIM(LOWER(categoria)) IN ('admin', 'administracion', 'administración') 
             THEN 'administración'
        WHEN TRIM(LOWER(categoria)) IN ('af', 'activo fijo', 'activo_fijo', 'activo fijo') 
             THEN 'activo fijo'
        WHEN TRIM(LOWER(categoria)) IN ('personal', ' personal') 
             THEN 'personal'
        ELSE TRIM(LOWER(categoria))
    END AS categoria,
    REPLACE(TRIM(LOWER(centro_costo)), '-', '') AS centro_costo,
    CAST(monto AS DECIMAL(18,2)) AS monto,
    fecha
FROM gastos;


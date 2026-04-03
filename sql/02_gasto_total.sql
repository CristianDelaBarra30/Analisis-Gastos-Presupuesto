WITH clean AS (
    SELECT
        CASE 
            WHEN TRIM(LOWER(categoria)) IN ('admin','administracion','administración') 
                 THEN 'administración'
            WHEN TRIM(LOWER(categoria)) IN ('af','activo fijo','activo_fijo') 
                 THEN 'activo fijo'
            WHEN TRIM(LOWER(categoria)) IN ('personal',' personal') 
                 THEN 'personal'
            ELSE TRIM(LOWER(categoria))
        END AS categoria,
        CAST(monto AS DECIMAL(18,2)) AS monto
    FROM gastos
)
SELECT 
    categoria,
    SUM(monto) AS gasto_total
FROM clean
GROUP BY categoria
ORDER BY gasto_total DESC;

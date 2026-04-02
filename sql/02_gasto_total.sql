WITH clean AS (
    SELECT
        TRIM(LOWER(categoria)) AS categoria,
        monto
    FROM gastos
)

SELECT 
    categoria,
    SUM(monto) AS gasto_total
FROM clean
GROUP BY categoria
ORDER BY gasto_total DESC;

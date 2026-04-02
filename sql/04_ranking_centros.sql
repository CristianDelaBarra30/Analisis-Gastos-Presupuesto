WITH clean AS (
    SELECT
        REPLACE(TRIM(LOWER(centro_costo)),'-','') AS centro_costo,
        CAST(monto AS DECIMAL(18,2)) AS monto
    FROM gastos
),
ranking AS (
    SELECT 
        centro_costo,
        SUM(monto) AS gasto_total,
        RANK() OVER (ORDER BY SUM(monto) DESC) AS ranking
    FROM clean
    GROUP BY centro_costo
)

SELECT *
FROM ranking
WHERE ranking <= 5;

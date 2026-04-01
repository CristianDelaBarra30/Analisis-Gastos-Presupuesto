WITH ranking AS (
    SELECT 
        centro_costo,
        SUM(monto) AS gasto_total,
        RANK() OVER (ORDER BY SUM(monto) DESC) AS ranking
    FROM gastos
    GROUP BY centro_costo
)

SELECT *
FROM ranking
WHERE ranking <= 5;

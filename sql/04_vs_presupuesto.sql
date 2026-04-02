SELECT 
    g.categoria,
    SUM(g.monto) AS gasto_total,
    MAX(p.presupuesto_mensual) AS presupuesto,
    SUM(g.monto) - MAX(p.presupuesto_mensual) AS diferencia
FROM gastos g
JOIN presupuesto p 
    ON g.categoria = p.categoria
GROUP BY g.categoria
ORDER BY diferencia DESC;

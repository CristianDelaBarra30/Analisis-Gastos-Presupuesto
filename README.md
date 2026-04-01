Análisis de Gastos y Control Presupuestario

Descripción

Proyecto de análisis financiero enfocado en el control de gastos y desviaciones presupuestarias, simulando un entorno real de control de gestión en banca.
Se utilizan consultas SQL para analizar el comportamiento del gasto, identificar centros de costo relevantes y evaluar variaciones mensuales.

Objetivo
 
Analizar el gasto por categoría y centro de costo
Comparar gasto real vs presupuesto
Identificar desviaciones y patrones mensuales
Simular procesos reales de control financiero

Herramientas utilizadas

SQL (CTEs, JOINs, window functions)
Excel (generación y exploración de datos)
GitHub (documentación del proyecto)

Estructura del proyecto

data/ → dataset de gastos  
sql/ → queries de análisis  
notebooks/ → (opcional futuro)  
visuals/ → (opcional futuro)  

Análisis realizados

Gasto total por categoría
Comparación gasto vs presupuesto
Variaciones mensuales usando LAG()
Ranking de centros de costo con mayor gasto

Insights

La categoría Administración concentra el mayor gasto total del período.
Existen centros de costo que concentran una proporción significativa del gasto total.
Se observan variaciones mensuales relevantes en ciertas categorías, lo que podría indicar estacionalidad o eventos específicos.
Algunas desviaciones presupuestarias muestran oportunidades de mejora en el control del gasto.

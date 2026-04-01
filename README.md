# Análisis de Gastos y Control Presupuestario

## Contexto

Este proyecto está inspirado en procesos reales de control de gestión en banca, donde se analizan gastos operacionales, desviaciones presupuestarias y comportamiento por centros de costo.

---

## Descripción

Este proyecto simula un análisis de control de gestión sobre gastos operacionales, similar a los procesos realizados en banca.

Se utilizan consultas SQL para analizar el comportamiento del gasto, identificar desviaciones presupuestarias y evaluar variaciones mensuales.

---

## Objetivo

El objetivo es replicar un flujo básico de análisis financiero:

- Entender en qué se está gastando
- Comparar gasto real vs presupuesto
- Identificar desviaciones
- Analizar tendencias en el tiempo

---

## Dataset

El dataset fue generado en Excel simulando información de gastos, incluyendo:

- Categorías (Personal, Administración, Activo fijo)
- Centros de costo
- Fechas
- Montos

---

## Análisis realizados

Las consultas SQL incluyen:

- Gasto total por categoría
- Comparación contra presupuesto
- Variaciones mes a mes usando funciones como LAG()
- Ranking de centros de costo con mayor gasto

---

## Insights

- La categoría Personal concentra el mayor nivel de gasto, explicado principalmente por sueldos y beneficios, lo cual es consistente con estructuras organizacionales intensivas en capital humano.

- A nivel de centros de costo, los asociados a Inmuebles presentan el mayor gasto total, probablemente impulsado por arriendos y costos operacionales relacionados.

- Se observan picos de gasto en el mes de octubre en los centros de mayor impacto, lo que podría estar relacionado con eventos específicos, ajustes contables o estacionalidad del negocio.

---

### Visualizaciones

![Gasto por categoría](visuals/Gasto_por_categorias.png)

![Top centros de costo](visuals/Centros_de_costos.png)

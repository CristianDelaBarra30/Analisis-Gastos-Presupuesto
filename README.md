# Análisis de Gastos y Control Presupuestario

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

A partir del análisis se pueden observar patrones como:

- Concentración del gasto en ciertas categorías
- Centros de costo con mayor impacto financiero
- Variaciones mensuales que podrían indicar eventos específicos o estacionalidad

---

## Siguientes pasos

- Incorporar visualizaciones
- Automatizar el análisis
- Trabajar con datasets más grandes y complejos

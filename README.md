# Real Estate Transfer Tax & Land Values: Empirical Evidence from German Municipalities

An econometric panel data analysis examining the capitalization of real estate transfer taxes (*Grunderwerbsteuer*) into local land values across German administrative districts (*Landkreise*) from 2014 to 2024.

## 📌 Research Question & Identification
Does an increase in the real estate transfer tax rate lead to lower municipal land values, and to what extent is the tax burden capitalized?

Following the 2006 federal reform in Germany, individual federal states (*Bundesländer*) gained the autonomy to set transfer tax rates independently. This decentralization created substantial quasi-experimental variation across time and regions.

## 📊 Data & Sample
* **Source:** Federal Statistical Office of Germany (*Destatis*), Regional Database.
* **Sample Size:** ~12,000 observations.
* **Coverage:** ~400 German districts (*Gebietskörperschaften*) over a 10-year period.
* **Dependent Variable:** Logged average municipal land values (`log_land_value`).
* **Macro Controls:** Regional gross wages/income, local employment/unemployment rates, net migration balance.

## ⚙️ Econometric Model
The empirical specification relies on a **Two-Way Fixed Effects (TWFE)** framework estimated with `fixest` in R:

$$\log(\text{LandValue}_{it}) = \alpha_i + \lambda_t + \beta \cdot \text{TaxRate}_{it} + X'_{it}\gamma + \varepsilon_{it}$$

* $\alpha_i$: District fixed effects (controlling for time-invariant local characteristics).
* $\lambda_t$: Year fixed effects (controlling for nationwide macroeconomic shocks and interest rate cycles).
* $X'_{it}$: Vector of regional macroeconomic control variables.
* Standard errors are **clustered at the district level** to account for serial correlation.

## 📈 Key Findings

* **Capitalization Effect:** Consistent with economic theory, changes in the real estate transfer tax rate exhibit a negative and statistically significant effect on local land values.
* **Robustness:** Results remain robust after controlling for demographic shifts and regional labor market dynamics.

## 🛠 Tech Stack
* **Language:** R (v4.x)
* **Core Packages:** `fixest` (TWFE estimations), `tidyverse` (`dplyr`, `tidyr` for data wrangling), `ggplot2` (data visualization).

---
*Author: Henri Karl Böttger – Goethe-Universität Frankfurt*

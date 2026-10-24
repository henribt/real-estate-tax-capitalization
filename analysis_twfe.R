library(tidyverse)
library(fixest)

panel_data <- readRDS("panel_data.rds")

# Modell mit repariertem Wanderungssaldo
fe_modell_neu <- feols(
  log(Kaufwert_sqm) ~ Steuersatz + log(Einkommen_Tsd) + log(Beschaeftigte + 1) + Wanderungssaldo | AGS + Jahr,
  data = panel_data,
  cluster = ~BL_AGS
)

summary(fe_modell_neu)
# 1. Baseline-Modell ohne Kontrollvariablen zum Vergleich schätzen
fe_modell_base <- feols(
  log(Kaufwert_sqm) ~ Steuersatz | AGS + Jahr,
  data = panel_data,
  cluster = ~BL_AGS
)

# 2. Punktschätzer und Standardfehler extrahieren
results_plot <- tibble(
  Model = c("1. Baseline (TWFE)", "2. Mit Makro-Kontrollen"),
  Estimate = c(coef(fe_modell_base)["Steuersatz"], coef(fe_modell_neu)["Steuersatz"]),
  SE = c(se(fe_modell_base)["Steuersatz"], se(fe_modell_neu)["Steuersatz"])
) %>%
  mutate(
    ci_lower = Estimate - 1.96 * SE,
    ci_upper = Estimate + 1.96 * SE
  )

# 3. Visualisierung mit ggplot2
p_coef <- ggplot(results_plot, aes(x = Model, y = Estimate, ymin = ci_lower, ymax = ci_upper)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey50", linewidth = 0.8) +
  geom_pointrange(color = "#1f4e79", size = 0.9, linewidth = 1.1) +
  coord_flip() +
  theme_minimal(base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold", size = 14),
    axis.title.x = element_text(margin = margin(t = 10))
  ) +
  labs(
    title = "Kapitalisierungseffekt der Grunderwerbsteuer auf Bodenwerte",
    subtitle = "Punktschätzer mit 95%-Konfidenzintervall (Two-Way Fixed Effects)",
    x = "",
    y = "Geschätzter Effekt auf log(Kaufwert/qm)",
    caption = "Destatis Paneldaten (12.017 Beobachtungen, 400 Gebietskörperschaften, 10 Jahre)"
  )

# 4. Plot im Viewer anzeigen und als Bilddatei speichern
print(p_coef)
ggsave("coefficient_plot.png", plot = p_coef, width = 8, height = 4.5, dpi = 300)
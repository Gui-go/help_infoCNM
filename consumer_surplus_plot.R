library(tidyverse)

# Contantes
cl = 200; ca = -2

# Função Demanda
D <- function(p){
  demand = cl + ca * p
  return(demand)
}

# Função Preço
P <- function(d){
  price = (d - cl) / ca
  return(price)
}

# Pontos em que a curva Demanda cruza os eixos x e y 
D(10); P(D(10))
D(0); P(D(0))

# alores iniciais
p1 = 90; p2 = 70

# Tabela root
df <- data.frame(
  y = c(P(0), 0, p1, p1, 0, p2, p2, 0, min(p1, p2)),
  x = c(0, D(0), D(p1), 0, D(p1), D(p2), 0, D(p2), min(D(p1), D(p2))),
  leg = c("preço_max", "preço_min", "input1", "lin_hor1", "lin_ver1", "input2", "lin_hor2", "lin_ver2", "mid_pt")
); df

# Triangle data
triang <- data.frame(
  y = c(df$y[3], df$y[6], df$y[9]),
  x = c(df$x[3], df$x[6], df$x[9])
); triang

# gráfico do Consumer Surplus
ggplot()+
  geom_segment(aes(x = df$x[1], y = df$y[1], xend = df$x[2], yend = df$y[2]))+ # Curva Demanda
  # geom_segment(aes(x = df$x[3], y = df$y[3]), xend = df$x[4], yend = df$y[4], size = 1, linetype=2) + # Linha horizontal
  # geom_segment(aes(x = df$x[3], y = df$y[3]), xend = df$x[5], yend = df$y[5], size = 1, linetype=2) + # Linha vertical
  geom_rect(aes(xmin = 0, ymin = 0, xmax = df$x[5], ymax = df$y[4]), alpha = 0.3, fill = "royalblue4") + # Quadrado principal
  # geom_segment(aes(x = df$x[6], y = df$y[6]), xend = df$x[7], yend = df$y[7], size = 1, linetype=2) + # Linha horizontal
  # geom_segment(aes(x = df$x[6], y = df$y[6]), xend = df$x[8], yend = df$y[8], size = 1, linetype=2) + # Linha vertical
  geom_rect(aes(xmin = 0, ymin = 0, xmax = df$x[8], ymax = df$y[7]), alpha = 0.3, fill = "steelblue") + # Quadrado principal
  geom_point(aes(x = df$x[3], y = df$y[3]))+
  geom_point(aes(x = df$x[6], y = df$y[6]))+
  # geom_polygon(aes(x = c(df$x[c(3, 6)], 0), y = c(df$y[c(3, 6)], 0))) +
  geom_polygon(aes(x = triang$x, y = triang$y), fill = "seagreen3", alpha = 0.3) +
  labs(
    title = "Consumer Surplus Explained", 
    caption = "help_infoCNM", 
    x = "Quantidade", 
    y= "Preço"
  ) +
  theme_minimal()

windowsFonts(TNR = windowsFont("Times New Roman"))

sesu_q = readr::read_csv('./data/SESU_GD.csv')

loessf = stats::loess(qv ~ su, data = sesu_q)
loessrate = (loessf$fitted - dplyr::lag(loessf$fitted)) / dplyr::lag(loessf$fitted)
sesu_q$rate = loessrate

maxrate = max(sesu_q$rate, na.rm = TRUE)
maxqv = max(sesu_q$qv)

fig_sesu = ggplot2::ggplot(data = sesu_q, ggplot2::aes(x = su)) +
  ggplot2::geom_line(ggplot2::aes(y = qv, color = "qv")) +
  ggplot2::geom_point(ggplot2::aes(y = qv, color = "qv")) +
  ggplot2::geom_line(ggplot2::aes(y = rate * maxqv / maxrate, color = "rate")) +
  ggplot2::geom_point(ggplot2::aes(y = rate * maxqv / maxrate, color = "rate")) +
  ggplot2::geom_hline(yintercept = 0.05 * maxqv / maxrate, 
                      color = "grey40", linetype = "dashed") +
  ggplot2::scale_color_manual(values = c("qv" = "#f8766d", "rate" = "#6598cc"), 
                              labels = c("Q value", "Increase rate"), name = "") +
  ggplot2::scale_x_continuous(
    name = "Size of spatial unit",
    breaks = sesu_q$su
  ) +
  ggplot2::scale_y_continuous(
    name = "Q value",
    sec.axis = ggplot2::sec_axis(~ . * maxrate / maxqv, 
                                 name = "Increase rate")
  ) +
  ggplot2::theme_bw() +
  ggplot2::theme(
    axis.title.y.right = ggplot2::element_text(color = "#6598cc"),
    axis.text.y.right = ggplot2::element_text(color = "#6598cc"),
    axis.title.y.left = ggplot2::element_text(color = "#f8766d"),
    axis.text.y.left = ggplot2::element_text(color = "#f8766d"),
    axis.text = ggplot2::element_text(family = "TNR"),
    axis.title = ggplot2::element_text(family = "TNR"),
    panel.grid = ggplot2::element_blank(),
    legend.text = ggplot2::element_text(family = "TNR"),
    legend.position = "inside",
    legend.justification = c('left','bottom'),
    legend.background = ggplot2::element_rect(fill = 'transparent')
  )

ggview::ggview(fig_sesu,width = 6.25,height = 4.25)

ggplot2::ggsave('./figure/fig_sesu.png',width = 6.25,height = 4.25,dpi=300)
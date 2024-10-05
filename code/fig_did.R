windowsFonts(TNR = windowsFont("Times New Roman"))

did_coef = readr::read_csv('./data/DID_Treat.csv')

fig_did = ggplot2::ggplot(did_coef, ggplot2::aes(x = term, 
                                              y = estimate)) +
  ggplot2::geom_point(size = 3, color = "blue") +
  ggplot2::geom_errorbar(ggplot2::aes(ymin = conf.low, 
                                      ymax = conf.high), 
                         width = 0.2) + 
  ggplot2::geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  ggplot2::theme_bw() +
  ggplot2::labs(title = "", x = "Terms", y = "Estimates") +
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1, family = "TNR"),
                 axis.text = ggplot2::element_text(family = "TNR"),
                 axis.title = ggplot2::element_text(family = "TNR")) +
  ggview::canvas(width = 6, height = 4.25, bg = 'transparent')

ggview::save_ggplot(fig_did,'./figure/fig_did.png')
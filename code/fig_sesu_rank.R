windowsFonts(TNR = windowsFont("Times New Roman"))

qs = readr::read_csv('./data/H1N1_Qs.csv')

q_col = c(rep('grey',4),"#ff0000","#0000ff","#0ecf0e","#E6AB02","#3effff")
names(q_col) = c("medicost","temp","prec","humi","sensepop","urbanpop","popd","rdds","gdpd")

fig_sesu_rank = ggplot2::ggplot(qs, ggplot2::aes(x = su, y = rank, group = variable)) +
  ggplot2::geom_line(ggplot2::aes(color = variable), lwd = 3.5, alpha = 0.65) +
  ggplot2::geom_point(ggplot2::aes(color = variable), size = 4.5, alpha = 0.85) +  
  ggplot2::geom_text(data = dplyr::filter(qs,su == 50), 
                     ggplot2::aes(x = 50, y = rank, label = variable),
                     hjust = 1.2, size = 5, family = "TNR", fontface = "bold") +
  ggplot2::geom_text(data = dplyr::filter(qs,su == 150), 
                     ggplot2::aes(x = 150, y = rank, label = variable),
                     hjust = -0.2, size = 5, family = "TNR", fontface = "bold") +
  ggplot2::scale_color_manual(values = q_col) +
  ggplot2::scale_x_continuous(breaks = c(50, 100, 150),
                              expand = ggplot2::expansion(mult = c(0.45, 0.45))) +
  ggplot2::scale_y_reverse(breaks = 1:9) +
  ggplot2::labs(x = "Size of spatial unit(km)", y = "Rank") +
  ggplot2::theme_minimal() +
  ggplot2::theme(
    legend.position = "none",
    axis.text.y = ggplot2::element_text(size = 12,family = "TNR",face = "bold.italic"),
    axis.text.x = ggplot2::element_text(size = 12,family = "TNR",face = "bold"),
    axis.title.x = ggplot2::element_text(size = 15,family = "TNR",face = "bold"),
    axis.title.y = ggplot2::element_text(size = 15,family = "TNR",face = "bold")
  )+
  ggview::canvas(width = 5.5,height = 4.5)

ggview::save_ggplot(fig_sesu_rank,'./figure/fig_sesu_rank.pdf',device = cairo_pdf)
pdftools::pdf_convert('./figure/fig_sesu_rank.pdf', dpi = 100,
                      filenames = './figure/fig_sesu_rank.png') 
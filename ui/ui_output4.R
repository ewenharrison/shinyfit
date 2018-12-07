tabPanel("Glimpse", value = "glimpse",
				 h4('Numerics'),
				 DT::dataTableOutput("glimpse1"),
				 h4('Factors'),
				 DT::dataTableOutput("glimpse2")
)

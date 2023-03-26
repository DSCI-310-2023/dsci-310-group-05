# Defining input data
data_set <- data.frame(
  x = c(1, 2, 3),
  y = c(4, 5, 6),
  z = c(7, 8, 9)
)

write.csv(data_set, "./data/data_set.csv", row.names = FALSE)

# Defining column names
col_names <- c("col1", "col2", "col3")

# Defining expected data
expected_data <- data.frame(
  col1 = c(1, 2, 3),
  col2 = c(4, 5, 6),
  col3 = c(7, 8, 9)
)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Title: Day 1
# Author: Aidan Mison
# Date: 2021-12-22
#
# Description: 
# Running through the challenges from the AOC day 1
# 
# Contents:
#   0. Load through the data
#   1. Get the count of scans greater than the previous
#   2. Same as 1 but sum three sequential days
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 0. Load through the data
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Load through the data
d1_data <- 
  fread(
    file.path('Day 1', 'day_1_data.txt'),
    col.names = 'sub_depth'
  )

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 1. Get the count of scans greater than the previous
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
d1_data %>% 
  .[, shift_sub_depth := fifelse(sub_depth > shift(d1_data$sub_depth), 1, 0)]

d1_data %>% 
  .[, .(rows = .N)
    , by = .(shift_sub_depth)]

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2. Same as 1 but sum three sequential days
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
d1_data %>% 
  .[, sum_sub_depth := Reduce(`+`, shift(d1_data$sub_depth, n = 0:2, type = "lead"))] %>% 
  .[, shift_sum_sub_depth := fifelse(sum_sub_depth > shift(d1_data$sum_sub_depth), 1, 0)]

d1_data %>% 
  .[, .(rows = .N)
    , by = .(shift_sum_sub_depth)]
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
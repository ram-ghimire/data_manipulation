install.packages("tidyverse")
library(tidyverse)

nycflights13::flights #loading flights data

flights <- tbl_df(flights) #convert to local data frame
flights

print(flights, n=20) #specify to see more than usual 10 rows of data

data.frame(head(flights)) # convert to a normal data frame to see all columns

filter(flights,month==1,day==1) #filter data to see all flights of 1 January
filter(flights, month==1 & day==1)

filter(flights,carrier=="UA" | carrier=="DL") # or condition

filter(flights,carrier %in% c("UA","DL")) # giving vector function

select(flights,dep_time,arr_time,tailnum) # select certain columns

select(flights,year:time_hour,contains("time"),contains("delay"))

flights %>% # use of piping ( %>% ) function 
  select(carrier,dep_delay) %>% 
  filter(dep_delay>2)

filter(select(flights,carrier,dep_delay),dep_delay>2) # use of nesting funtion

x1 <- 1:5;x2 <- 2:6  #calculate Euclidian distance between two points by nested method
sqrt(sum((x1-x2)^2))

(x1-x2)^2 %>% sum() %>% sqrt() #chaining method for the same function is much easier to operate

flights %>% # using arrange function
  select(carrier,dep_delay) %>% 
  arrange(dep_delay)

flights %>%  # using arrange function in desc order
  select(carrier,dep_delay) %>% 
  arrange(desc(dep_delay))

flights %>% 
  select(distance,air_time) %>% 
  mutate(speed=distance/air_time*60)

flight_speed <- flights %>% 
  mutate(speed=distance/air_time*60)
flight_speed

#group_by: creates the group that will be operated on
#summarise: uses the provided aggregation function to summarise each group

??na.rm

flights %>%
  group_by(dest) %>% 
  summarise(avg_delay=mean(arr_delay,na.rm=T)) # removes NA in average delay

flights %>%
  group_by(carrier) %>%
  summarise_each(funs(mean),dep_delay,arr_delay)

delay_flights <- flights %>% #calculate minimum and maximum arrival and departure delays
  group_by(carrier) %>%
  summarise_each(funs(min(.,na.rm = T),max(.,na.rm = T)),matches("delay"))
 delay_flights 

 flight_count <- flights %>% #count flights for that month and day.
   group_by(month,day) %>% 
   summarise(flight_count=n()) %>% 
   arrange(flight_count)
 flight_count
   
 flights %>% 
   group_by(month,day) %>% 
   summarise(flight_count=n()) %>% 
   arrange(desc(flight_count))
 
  glimpse(flights)
glimpse(flight_speed)  
glimpse(delay_flights)


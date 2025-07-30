---
  title: "History of Himalayan Mountaineering Expeditions"
author: jibiki ayato
format: docx
---
  
  ```{r}
#| label: setup
#| echo: false
#| message: false

# Load packages
library(tidyverse)
library(janitor)
library(tidytuesdayR)
```

# Load the dataset
gapminder <- read_csv("https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-01-21/readme.md")

# Load the data (Tidy Tuesday 2025 Week 3: January 21, 2025)
tt <- tidytuesdayR::tt_load(2025, week = 3)

# Extract and clean the expeditions dataset
exped <- tt$exped_tidy %>% 
  clean_names()

## Introduction

 The Himalayan Expeditions dataset includes records of climbs in the Himalayas from r min(exped$year, na.rm = TRUE) to r max(exped$year, na.rm = TRUE).
 It was published by The Himalayan Database and shared through Tidy Tuesday on January 21, 2025.
 
 -How success rates differ by season?
 -How elevation relates to success?
 -Which countries or years had the most expeditions?
 
 
## Data visualization
   #| echo: false
 exped %>%
   mutate(success = if_else(termreason == 1, "Success", "Failure")) %>%
   ggplot(aes(x = max_elevation_m, y = success, color = season_factor)) +
   geom_jitter(alpha = 0.5, height = 0.1) +
   labs(
     title = "Figure 1",
     subtitle = "Relationship between Max Elevation and Expedition Success by Season",
     x = "Max Elevation (meters)",
     y = "Expedition Outcome",
     color = "Season"
   ) +
   theme_minimal()
 {{< pagebreak >}}
 
 {r}
 #| echo: false
 #| fig-height: 7
 #| fig-dpi: 500
 
 success_rate <- exped %>%
   mutate(success = termreason == 1) %>%
   group_by(season_factor) %>%
   summarise(success_rate = mean(success, na.rm = TRUE)) %>%
   arrange(desc(success_rate))
 
 ggplot(success_rate, aes(x = reorder(season_factor, success_rate), y = success_rate, fill = season_factor)) +
   geom_col(show.legend = FALSE) +
   coord_flip() +
   scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
   labs(
     title = "Figure 2",
     subtitle = "Success Rate of Expeditions by Season",
     x = "Season",
     y = "Success Rate"
   ) +
   theme_minimal()
 {{< pagebreak >}}
 

## Discussion

 Figure 1 shows that higher elevations generally mean lower success rates. Spring expeditions tend to succeed more often than those in other seasons at similar heights.
 
 Figure 2 confirms that spring has the highest success rate, followed by autumn. Other seasons have lower success, likely due to worse weather.
 
 In summary, season and altitude strongly affect expedition success in the Himalayas.
  
  ## References
 Beidleman, B. (2004). High Exposure: An Enduring Passion for Everest and Unforgiving Places. Mountaineers Books.
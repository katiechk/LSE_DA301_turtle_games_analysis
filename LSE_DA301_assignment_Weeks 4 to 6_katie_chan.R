## LSE Data Analytics Online Career Accelerator 

# DA301:  Advanced Analytics for Organisational Impact

###############################################################################

# Assignment template

## Scenario
## You are a data analyst working for Turtle Games, a game manufacturer and 
## retailer. They manufacture and sell their own products, along with sourcing
## and selling products manufactured by other companies. Their product range 
## includes books, board games, video games and toys. They have a global 
## customer base and have a business objective of improving overall sales 
##performance by utilising customer trends. 

## In particular, Turtle Games wants to understand:
## - how customers accumulate loyalty points (Week 1)
## - how useful are remuneration and spending scores data (Week 2)
## - can social data (e.g. customer reviews) be used in marketing 
##     campaigns (Week 3)
## - what is the impact on sales per product (Week 4)
## - the reliability of the data (e.g. normal distribution, Skewness, Kurtosis)
##     (Week 5)
## - if there is any possible relationship(s) in sales between North America,
##     Europe, and global sales (Week 6).

################################################################################

# Week 4 assignment: EDA using R

## The sales department of Turtle games prefers R to Python. As you can perform
## data analysis in R, you will explore and prepare the data set for analysis by
## utilising basic statistics and plots. Note that you will use this data set 
## in future modules as well and it is, therefore, strongly encouraged to first
## clean the data as per provided guidelines and then save a copy of the clean 
## data for future use.

# Instructions
# 1. Load and explore the data.
##  - Remove redundant columns (Ranking, Year, Genre, Publisher) by creating 
##      a subset of the data frame.
##  - Create a summary of the new data frame.
# 2. Create plots to review and determine insights into data set.
##  - Create scatterplots, histograms and boxplots to gain insights into
##      the Sales data.
##  - Note your observations and diagrams that could be used to provide
##      insights to the business.
# 3. Determine the impact on sales per product_id.
##  - Use the group_by and aggregate functions to sum the values grouped by
##      product.
##  - Create a summary of the new data frame.
# 4. Create plots to review and determine insights into the data set.
##  - Create scatterplots, histograms, and boxplots to gain insights into 
##     the Sales data.
##  - Note your observations and diagrams that could be used to provide 
##     insights to the business.
# 5. Include your insights and observations.

###############################################################################

# 1. Load and explore the data

# Install and import Tidyverse.
install.packages("tidyverse")
library(tidyverse)

# Check the working directory
getwd()

# Set the working directory where my files are
setwd(dir='/Users/chanhiukiu/Documents/professional development/learning/lse data analytics career accelerator/course 3/assignment 3/LSE_DA301_assignment_files')

# Import the data set.
turtle_sales <- read.csv('turtle_sales.csv', header=T)

# Print the data frame.
turtle_sales

# Sense check the data frame
View(turtle_sales)
str(turtle_sales)
dim(turtle_sales)
typeof(turtle_sales)
class(turtle_sales)

# Create a new data frame from a subset of the sales data frame.
# Remove unnecessary columns. 
turtle_sales_2 <- select(turtle_sales, -Ranking, -Year, -Genre, -Publisher)

# View the data frame.
head(turtle_sales_2)

# View the descriptive statistics.
summary(turtle_sales_2)

# Review the data by product, platform and genre
count(turtle_sales %>%
        group_by(Product))

count(turtle_sales %>%
        group_by(Platform))

count(turtle_sales %>%
        group_by(Genre))

################################################################################

# 2. Review plots to determine insights into the data set.

## 2a) Scatterplots
# Create scatterplots.
qplot(Product, NA_Sales, colour=Genre, data=turtle_sales)
qplot(Product, EU_Sales, colour=Genre, data=turtle_sales)
qplot(Product, Global_Sales, colour=Genre, data=turtle_sales)

## 2b) Histograms
# Create histograms.
qplot(NA_Sales, bins=10, data=turtle_sales_2)
qplot(EU_Sales, bins=10, data=turtle_sales_2)
qplot(Global_Sales, bins=10, data=turtle_sales_2)

## 2c) Boxplots
# Create boxplots.
qplot(NA_Sales, data=turtle_sales_2, geom='boxplot')
qplot(EU_Sales, data=turtle_sales_2, geom='boxplot')
qplot(Global_Sales, data=turtle_sales_2, geom='boxplot')

## 2d) Heatmap
# Create heatmap
qplot(Year, Genre, fill=NA_Sales, data=turtle_sales, geom='raster')
qplot(Year, Genre, fill=EU_Sales, data=turtle_sales, geom='raster')
qplot(Year, Genre, fill=Global_Sales, data=turtle_sales, geom='raster')

###############################################################################

# 3. Determine the impact on sales per product_id.

## 3a) Use the group_by and aggregate functions.
# Group data based on Product and determine the sum per Product.
turtle_product_sales <- turtle_sales_2 %>% group_by(Product) %>%
summarise(count = n(),
          Total_EU_Sales = sum(EU_Sales),
          Total_NA_Sales = sum(NA_Sales),
          Total_Global_Sales = sum(Global_Sales),
          .groups = 'drop')

# View the data frame.
View(turtle_product_sales)

# Explore the data frame.
str(turtle_product_sales)
summary(turtle_product_sales)

## 3b) Determine which plot is the best to compare game sales.
# Create scatterplots.
qplot(Product, Total_NA_Sales, data=turtle_product_sales)
qplot(Product, Total_EU_Sales, data=turtle_product_sales)
qplot(Product, Total_Global_Sales, data=turtle_product_sales)

# Create histograms.
qplot(Total_NA_Sales, bins=10, data=turtle_product_sales)
qplot(Total_EU_Sales, bins=10, data=turtle_product_sales)
qplot(Total_Global_Sales, bins=10, data=turtle_product_sales)

# Create boxplots.
qplot(Total_NA_Sales, data=turtle_product_sales, geom='boxplot')
qplot(Total_EU_Sales, data=turtle_product_sales, geom='boxplot')
qplot(Total_Global_Sales, data=turtle_product_sales, geom='boxplot')

###############################################################################

# 4. Additional deep dive

# See the best seller in different market
turtle_sales[which.max(turtle_sales$NA_Sales),]
turtle_sales[which.max(turtle_sales$EU_Sales),]
turtle_sales[which.max(turtle_sales$Global_Sales),]

# See the worst selling game in different market
turtle_sales[which.min(turtle_sales$NA_Sales),]
turtle_sales[which.min(turtle_sales$EU_Sales),]
turtle_sales[which.min(turtle_sales$Global_Sales),]

# Review the sales by platform 
platform_product_sales <- turtle_sales %>% group_by(Platform) %>%
summarise(count = n(),
          Total_EU_Sales = sum(EU_Sales),
          Total_NA_Sales = sum(NA_Sales),
          Total_Global_Sales = sum(Global_Sales),
          .groups = 'drop')

View(platform_product_sales)

# Count number of games by platform
x <- ggplot(platform_product_sales, aes(x = reorder(Platform, -count), y = count))
x <- x + geom_bar(stat="identity", color='antiquewhite3',fill='antiquewhite3')
x <- x + theme(axis.text.x=element_text(angle=45, hjust=0.9))
x

# NA_Sales by platform
x <- ggplot(platform_product_sales, aes(x = reorder(Platform, -Total_NA_Sales), y = Total_NA_Sales))
x <- x + geom_bar(stat="identity", color='darkseagreen',fill='darkseagreen')
x <- x + theme(axis.text.x=element_text(angle=45, hjust=0.9))
x

# EU_Sales by platform
x <- ggplot(platform_product_sales, aes(x = reorder(Platform, -Total_EU_Sales), y = Total_EU_Sales))
x <- x + geom_bar(stat="identity", color='lightblue2',fill='lightblue2')
x <- x + theme(axis.text.x=element_text(angle=45, hjust=0.9))
x

# Global_Sales by platform
x <- ggplot(platform_product_sales, aes(x = reorder(Platform, -Total_Global_Sales), y = Total_Global_Sales))
x <- x + geom_bar(stat="identity", color='lightpink2',fill='lightpink2')
x <- x + theme(axis.text.x=element_text(angle=45, hjust=0.9))
x

# Review the sales by Genre 
genre_product_sales <- turtle_sales %>% group_by(Genre) %>%
  summarise(count = n(),
            Total_EU_Sales = sum(EU_Sales),
            Total_NA_Sales = sum(NA_Sales),
            Total_Global_Sales = sum(Global_Sales),
            .groups = 'drop')

View(genre_product_sales)

# Count number of games by genre
x <- ggplot(genre_product_sales, aes(x = reorder(Genre, -count), y = count))
x <- x + geom_bar(stat="identity", color='antiquewhite3',fill='antiquewhite3')
x <- x + theme(axis.text.x=element_text(angle=45, hjust=0.9))
x

# NA_Sales by genre
x <- ggplot(genre_product_sales, aes(x = reorder(Genre, -Total_NA_Sales), y = Total_NA_Sales))
x <- x + geom_bar(stat="identity", color='darkseagreen',fill='darkseagreen')
x <- x + theme(axis.text.x=element_text(angle=45, hjust=0.9))
x

# EU_Sales by genre
x <- ggplot(genre_product_sales, aes(x = reorder(Genre, -Total_EU_Sales), y = Total_EU_Sales))
x <- x + geom_bar(stat="identity", color='lightblue2',fill='lightblue2')
x <- x + theme(axis.text.x=element_text(angle=45, hjust=0.9))
x

# Global_Sales by genre
x <- ggplot(genre_product_sales, aes(x = reorder(Genre, -Total_Global_Sales), y = Total_Global_Sales))
x <- x + geom_bar(stat="identity", color='lightpink2',fill='lightpink2')
x <- x + theme(axis.text.x=element_text(angle=45, hjust=0.9))
x

# Review the sales by Year 
year_product_sales <- turtle_sales %>% group_by(Year) %>%
  summarise(count = n(),
            Total_EU_Sales = sum(EU_Sales),
            Total_NA_Sales = sum(NA_Sales),
            Total_Global_Sales = sum(Global_Sales),
            .groups = 'drop')

View(year_product_sales)

# Count number of games by year
x <- ggplot(year_product_sales, aes(x = reorder(Year, -count), y = count))
x <- x + geom_bar(stat="identity", color='antiquewhite3',fill='antiquewhite3')
x <- x + theme(axis.text.x=element_text(angle=45, hjust=0.9))
x

# NA_Sales by year
x <- ggplot(year_product_sales, aes(x = reorder(Year, -Total_NA_Sales), y = Total_NA_Sales))
x <- x + geom_bar(stat="identity", color='darkseagreen',fill='darkseagreen')
x <- x + theme(axis.text.x=element_text(angle=45, hjust=0.9))
x

# EU_Sales by year
x <- ggplot(year_product_sales, aes(x = reorder(Year, -Total_EU_Sales), y = Total_EU_Sales))
x <- x + geom_bar(stat="identity", color='lightblue2',fill='lightblue2')
x <- x + theme(axis.text.x=element_text(angle=45, hjust=0.9))
x

# Global_Sales by year
x <- ggplot(year_product_sales, aes(x = reorder(Year, -Total_Global_Sales), y = Total_Global_Sales))
x <- x + geom_bar(stat="identity", color='lightpink2',fill='lightpink2')
x <- x + theme(axis.text.x=element_text(angle=45, hjust=0.9))
x

###############################################################################

# 5. Observations and insights

## Your observations and insights here ......

# The data set includes the games that are available on 10 platforms in 12 different genre. Some games are available on multiple platforms while some of them are only available on one platform_product_sales
# The 3 market sales share similar trend yet there are difference between market that indicate the difference in customers behaviour including the preferred platform and genre preference. Product 107 launched in 2006 by Nintendo is the best seller across all markets with a total global sales of GBP 67.85M.
# Based on the scatterplots, there seems to have a slightly negative relationship between the product ID and sales that the smaller product ID tend to have higher sales. It is interesting to further investigate and understand the rationale of product ID. 

# Shooter, Action and Sports are the top 3 genre with large volume of game available. Although there are only 38 games that are in the Platform genre, it still managed to be the top 2 genre in the global sales market.
# Generally, X360 and Wii are the most common gaming platform for the market, PS3 remains to be the top 2 gaming platform in the EU market.
# We can also see that the mid-2000s to early-2010s are the years that having a great growth in the gaming market with more games launched in the market and remained to be the top seller till now.

###############################################################################
###############################################################################


# Week 5 assignment: Cleaning and maniulating data using R

## Utilising R, you will explore, prepare and explain the normality of the data
## set based on plots, Skewness, Kurtosis, and a Shapiro-Wilk test. Note that
## you will use this data set in future modules as well and it is, therefore, 
## strongly encouraged to first clean the data as per provided guidelines and 
## then save a copy of the clean data for future use.

## Instructions
# 1. Load and explore the data.
##  - Continue to use the data frame that you prepared in the Week 4 assignment. 
##  - View the data frame to sense-check the data set.
##  - Determine the `min`, `max` and `mean` values of all the sales data.
##  - Create a summary of the data frame.
# 2. Determine the normality of the data set.
##  - Create and explore Q-Q plots for all sales data.
##  - Perform a Shapiro-Wilk test on all the sales data.
##  - Determine the Skewness and Kurtosis of all the sales data.
##  - Determine if there is any correlation between the sales data columns.
# 3. Create plots to gain insights into the sales data.
##  - Compare all the sales data (columns) for any correlation(s).
##  - Add a trend line to the plots for ease of interpretation.
# 4. Include your insights and observations.

################################################################################

# 1. Load and explore the data

# View data frame created in Week 4.
View(turtle_sales_2)

# Check output: Determine the min, max, and mean values.
# NA_Sales
min(turtle_sales_2$NA_Sales)
max(turtle_sales_2$NA_Sales)
mean(turtle_sales_2$NA_Sales)

# EU_Sales
min(turtle_sales_2$EU_Sales)
max(turtle_sales_2$EU_Sales)
mean(turtle_sales_2$EU_Sales)

# Global_Sales
min(turtle_sales_2$Global_Sales)
max(turtle_sales_2$Global_Sales)
mean(turtle_sales_2$Global_Sales)

# View the descriptive statistics.
summary(turtle_sales_2)

###############################################################################

# 2. Determine the normality of the data set.

## 2a) Create Q-Q Plots
# Create Q-Q Plots.
# NA Sales
qqnorm(turtle_sales_2$NA_Sales, main="NA Sales Q-Q Plot")
qqline(turtle_sales_2$NA_Sales)

# EU Sales
qqnorm(turtle_sales_2$EU_Sales, main="EU Sales Q-Q Plot")
qqline(turtle_sales_2$EU_Sales)

# Global Sales
qqnorm(turtle_sales_2$Global_Sales, main="Global Sales Q-Q Plot")
qqline(turtle_sales_2$Global_Sales)

## 2b) Perform Shapiro-Wilk test
# Install and import Moments.
install.packages("moments")
library(moments)

# Perform Shapiro-Wilk test.
# NA Sales
shapiro.test(turtle_sales_2$NA_Sales)

# EU Sales
shapiro.test(turtle_sales_2$EU_Sales)

# Global Sales
shapiro.test(turtle_sales_2$Global_Sales)

## 2c) Determine Skewness and Kurtosis
# Skewness and Kurtosis.

# NA Sales
skewness(turtle_sales_2$NA_Sales)
kurtosis(turtle_sales_2$NA_Sales)

# EU Sales
skewness(turtle_sales_2$EU_Sales)
kurtosis(turtle_sales_2$EU_Sales)

# Global Sales
skewness(turtle_sales_2$Global_Sales)
kurtosis(turtle_sales_2$Global_Sales)

## 2d) Determine correlation
# Determine correlation.
# NA Sales & EU Sales
round(cor(turtle_sales_2$NA_Sales, turtle_sales$EU_Sales), digits=2)

# NA Sales & Global Sales
round(cor(turtle_sales_2$NA_Sales, turtle_sales$Global_Sales), digits=2)

# EU Sales & Global Sales
round(cor(turtle_sales_2$EU_Sales, turtle_sales$Global_Sales), digits=2)

###############################################################################

# 3. Plot the data
# Create plots to gain insights into data.

# NA Sales & EU Sales
ggplot(turtle_sales_2, 
       mapping=aes(x=NA_Sales, y=EU_Sales)) +
  geom_point(colour = "darkseagreen3") +
  geom_smooth() +
  labs(title ='Correlation between NA Sales and EU Sales',
       x = 'NA Sales',
       y = 'EU Sales') 

# NA Sales & Global Sales
ggplot(turtle_sales_2, 
       mapping=aes(x=NA_Sales, y=Global_Sales)) +
  geom_point(colour = "darkseagreen3") +
  geom_smooth() +
  labs(title ='Correlation between NA Sales and Global Sales',
       x = 'NA Sales',
       y = 'Global Sales') 

# EU Sales & Global Sales
ggplot(turtle_sales_2, 
       mapping=aes(x=EU_Sales, y=Global_Sales)) +
  geom_point(colour = "darkseagreen3") +
  geom_smooth() +
  labs(title ='Correlation between EU Sales and Global Sales',
       x = 'EU Sales',
       y = 'Global Sales') 

###############################################################################

# 4. Observations and insights
# Your observations and insights here...

# The Q-Q Plot indicate that the data is not normally distributed with positive skewness. 
# To further explore the data distribution, we have reviewed the data using Shapiro-Wilk test. The 3 sales data shared similar result with a low p value that is way below the significance level. 
# With the use of Skewness and Kurtosis method, we can see that the data is heavily skewed and the distribution is too peaked. 

# We can see the positive correlation between the sales across market. 
# North America market is having a stronger positive correlation with the Global sales which indicates the North America market might be bigger than the Europe market and hence have more effect on the global sales.
# The correlation between NA and EU market sales is relatively weak.

###############################################################################
###############################################################################

# Week 6 assignment: Making recommendations to the business using R

## The sales department wants to better understand if there is any relationship
## between North America, Europe, and global sales. Therefore, you need to
## investigate any possible relationship(s) in the sales data by creating a 
## simple and multiple linear regression model. Based on the models and your
## previous analysis (Weeks 1-5), you will then provide recommendations to 
## Turtle Games based on:
##   - Do you have confidence in the models based on goodness of fit and
##        accuracy of predictions?
##   - What would your suggestions and recommendations be to the business?
##   - If needed, how would you improve the model(s)?
##   - Explain your answers.

# Instructions
# 1. Load and explore the data.
##  - Continue to use the data frame that you prepared in the Week 5 assignment. 
# 2. Create a simple linear regression model.
##  - Determine the correlation between the sales columns.
##  - View the output.
##  - Create plots to view the linear regression.
# 3. Create a multiple linear regression model
##  - Select only the numeric columns.
##  - Determine the correlation between the sales columns.
##  - View the output.
# 4. Predict global sales based on provided values. Compare your prediction to
#      the observed value(s).
##  - NA_Sales_sum of 34.02 and EU_Sales_sum of 23.80.
##  - NA_Sales_sum of 3.93 and EU_Sales_sum of 1.56.
##  - NA_Sales_sum of 2.73 and EU_Sales_sum of 0.65.
##  - NA_Sales_sum of 2.26 and EU_Sales_sum of 0.97.
##  - NA_Sales_sum of 22.08 and EU_Sales_sum of 0.52.
# 5. Include your insights and observations.

###############################################################################

# 1. Load and explor the data
# View data frame created in Week 5.
view(turtle_sales_2)
view(turtle_product_sales)

# Determine a summary of the data frame.
summary(turtle_sales_2)
summary(turtle_product_sales)

###############################################################################

# 2. Create a simple linear regression model
## 2a) Determine the correlation between columns
# Create a linear regression model on the original data.

# NA Sales & EU Sales
linear_reg_1 <- select(turtle_sales_2, NA_Sales, EU_Sales)
str(linear_reg_1)
linear_reg_1 %>% cor()

# NA Sales & Global Sales
linear_reg_2 <- select(turtle_sales_2, NA_Sales, Global_Sales)
str(linear_reg_2)
linear_reg_2 %>% cor()

# EU Sales & Global Sales
linear_reg_3 <- select(turtle_sales_2, EU_Sales, Global_Sales)
str(linear_reg_3)
linear_reg_3 %>% cor()

## 2b) Create a plot (simple linear regression)
# Basic visualisation.

# NA Sales & EU Sales
ggplot (turtle_sales_2, aes(NA_Sales, EU_Sales)) + 
  geom_point()

# NA Sales & Global Sales
ggplot (turtle_sales_2, aes(NA_Sales, Global_Sales)) + 
  geom_point()

# EU Sales & Global Sales
ggplot (turtle_sales_2, aes(EU_Sales, Global_Sales)) + 
  geom_point()

###############################################################################

# 3. Create a multiple linear regression model
# Select only numeric columns from the original data frame.
turtle_sales_3 <- select(turtle_sales_2, -Product, -Platform)

View(turtle_sales_3)
attach(turtle_sales_3)
cor(turtle_sales_3)

# Multiple linear regression model.
mlr_model <- lm(Global_Sales ~ EU_Sales + NA_Sales, data=turtle_sales_3)
summary(mlr_model)

mlr_model$coef

par(mfrow=c(2,2))
plot(mlr_model)
mtext("Multiple Regression", side = 3, 
      line = -2, outer = TRUE)

###############################################################################

# 4. Predictions based on given values
# Compare with observed values for a number of records.

# Create new data frame with the provided value
Product <- c(107, 3267, 6815, 2877, 326)
NA_Sales <- c(34.02, 3.93, 2.73, 2.26, 22.08)
EU_Sales <- c(23.80, 1.56, 0.65, 0.97, 0.52)

predict_df <- data.frame(Product, NA_Sales, EU_Sales)
predict_df

# Predict the Global Sales value based on the provided data
predict(mlr_model, newdata=predict_df, interval='confidence')
predict_df$Predict_Global_Sales <- predict(mlr_model, newdata = predict_df)
predict_df

# Filter Global Sales from recorded data
filter(turtle_sales_3, NA_Sales == 34.02, EU_Sales==23.80)
filter(turtle_sales_3, NA_Sales == 3.93, EU_Sales==1.56)
filter(turtle_sales_3, NA_Sales == 2.73, EU_Sales==0.65)
filter(turtle_sales_3, NA_Sales == 2.26, EU_Sales==0.97)
filter(turtle_sales_3, NA_Sales == 22.08, EU_Sales==0.52)

# Add the Actual_Global_Sales column to evaluate the prediction accuracy
Actual_Global_Sales <- c(67.85, 6.04, 4.32, 3.53, 23.21)
predict_df$Actual_Global_Sales <- Actual_Global_Sales
predict_df

###############################################################################

# 5. Observations and insights
# Your observations and insights here...

# NA Sales is having a strong positive correlation to Global Sales with index of over 93%. EU Sales also have a strong positive correlation with Global Sales with index of approx. 88%. The correlation between NA Sales and EU Sales is relatively weak with index of approx. 70%

# To further explore the best model that can fit with the data, we tried with the multople regression linear model to review the NA Sales, EU Sales and Global Sales. The multiple regression linear model is having a tendency of minor megaphone pattern, which indicates it will be less accurate for larger values.
# Having said that, the adjusted R-squared is 0.9685 and the residual standard error is 1.112, which is considered to be an accurate model. 
# We also compared the predicted global sales with the actual global sales to better evaluate the accuracy of the model.

# Overall, the multiple regression linear model is the better model for prediction purpose compared with the linear regression. There are strong correlation between the market sales, the use of NA Sales and EU Sales help to predict the total Sales for the Product
# It will be great to build a similar model with the grouped product data and see if this helps to improve the model accuracy. 

###############################################################################
###############################################################################
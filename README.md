## Week 1

- Both spending scores and annual income do have positive relationship with the loyalty points. This indicates that customers with higher spending scores or higher annual income tend to have a higher loyalty points with them. The impact of annual income is slightly more than spending scores givent that the difference in coefficient. Yet the Adj. R-squared is too low that the model might not be accurate enough. We recommend to try with different model for a more accurate result.
- In contrast, age has a relatively weak and negative relationship with score points with a negative coefficient. This indicates customers tend to lower their loyalty when they get older, this might due to the increase in shopping option. Similar with the above, the Adj. R-squared is not credible enough to fully trust the model.
- It is interesting to further explore if other variables such as gender and education will have strong relationship with the loyalty points. It will be good to also explore other model for better accuracy.
- Overall, we will say that the correlation is too weak to have any further deep dive



## Week 2

#### Elbow Method & Silhoutte Method
The curve start to straighten after 5 in Elbow Method and hence I have test the data again with Silhoutte Method that it is clearly indiciate 5 clusuters are the best for the considered dataset
The 2 method helps to categorise the data into 5 clusters so that we can further deep dive into the data and understand the customer segmentations for Turtle Games

### The 5 Clusters
1. Low annual income and high spending score
2. Low annual income and low spending score
3. Average annual income and spending score
4. High annual income and high spending score
5. High annual income and low spending score

Moving forward, we should target the customers cluster with different marketing approach to maximise the sales from each group.



## Week 3

Overall, we are seeing a positive sentiment on both summary and review for the Turtle Games. Over 80% of the reviews and 54% of the summary are positive. This can also be reflected in the Wordcloud that majority of the words are positive, including fun, excellent, great, cute, kid...

To further explore the audience sentiment towards the Turtle Game, we deep dive into the top 20 positive and negative review and summary. Generally, we can see that the game is commonly used as a gifting present, people also enjoyed the design and found the game awesome. On the contrast, the negative sentiment stated that the game is boring, disappointing, difficult and complicated to follow.

For our next step, to better improve the Turtle Game customer experience, it will be great to conduct another survey with customers to have a better understanding on what worked the best and what can be further improve.



## Week 4

The data set includes the games that are available on 10 platforms in 12 different genre. Some games are available on multiple platforms while some of them are only available on one platform_product_sales

The 3 market sales share similar trend yet there are difference between market that indicate the difference in customers behaviour including the preferred platform and genre preference. Product 107 launched in 2006 by Nintendo is the best seller across all markets with a total global sales of GBP 67.85M.

Based on the scatterplots, there seems to have a slightly negative relationship between the product ID and sales that the smaller product ID tend to have higher sales. It is interesting to further investigate and understand the rationale of product ID. 

Shooter, Action and Sports are the top 3 genre with large volume of game available. Although there are only 38 games that are in the Platform genre, it still managed to be the top 2 genre in the global sales market.

Generally, X360 and Wii are the most common gaming platform for the market, PS3 remains to be the top 2 gaming platform in the EU market.

We can also see that the mid-2000s to early-2010s are the years that having a great growth in the gaming market with more games launched in the market and remained to be the top seller till now.



## Week 5

The Q-Q Plot indicate that the data is not normally distributed with positive skewness. 
To further explore the data distribution, we have reviewed the data using Shapiro-Wilk test. The 3 sales data shared similar result with a low p value that is way below the significance level. 
With the use of Skewness and Kurtosis method, we can see that the data is heavily skewed and the distribution is too peaked. 

We can see the positive correlation between the sales across market. 
North America market is having a stronger positive correlation with the Global sales which indicates the North America market might be bigger than the Europe market and hence have more effect on the global sales.
The correlation between NA and EU market sales is relatively weak.



## Week 6

NA Sales is having a strong positive correlation to Global Sales with index of over 93%. EU Sales also have a strong positive correlation with Global Sales with index of approx. 88%. The correlation between NA Sales and EU Sales is relatively weak with index of approx. 70%

To further explore the best model that can fit with the data, we tried with the multople regression linear model to review the NA Sales, EU Sales and Global Sales. The multiple regression linear model is having a tendency of minor megaphone pattern, which indicates it will be less accurate for larger values.
Having said that, the adjusted R-squared is 0.9685 and the residual standard error is 1.112, which is considered to be an accurate model. 
We also compared the predicted global sales with the actual global sales to better evaluate the accuracy of the model.

Overall, the multiple regression linear model is the better model for prediction purpose compared with the linear regression. There are strong correlation between the market sales, the use of NA Sales and EU Sales help to predict the total Sales for the Product
It will be great to build a similar model with the grouped product data and see if this helps to improve the model accuracy. 



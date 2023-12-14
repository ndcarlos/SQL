/*
Assume you're given a table Twitter tweet data, write a query to obtain a histogram 
of tweets posted per user in 2022. Output the tweet count per user as the bucket and 
the number of Twitter users who fall into that bucket.

In other words, group the users by the number of tweets they posted in 2022 and 
count the number of users in each group.
*/

WITH tweet_count AS(
  SELECT 
  user_id,
  COUNT(tweet_id) AS total_tweet
  FROM tweets
  WHERE tweet_date BETWEEN '2022-01-01' AND '2022-12-31'
  GROUP BY user_id
)


SELECT 
  total_tweet AS tweet_bucket,
  COUNT(user) AS user_nums
FROM tweet_count
GROUP BY total_tweet

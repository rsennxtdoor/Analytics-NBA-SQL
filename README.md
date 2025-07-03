# SQL Portfolio Project: 2022-2023 NBA Player Stats Analysis

## 📜 Project Overview
This project provides an in-depth analysis of NBA player statistics from the 2022-2023 season. The primary goal is to extract valuable insights by comparing player performance between the regular season and the high-stakes playoffs.

The entire workflow, from data import to analysis, was conducted using SQL within a SQLite database engine. This project showcases proficiency in data manipulation, aggregation, table joins (`JOIN`), and the use of Common Table Expressions (CTEs) to answer key analytical questions.

## 💾 The Dataset
The analysis is based on two separate `.csv` files:
 `2022-2023 NBA Player Stats - Regular.csv`: Contains individual player stats across the regular season.
 `2022-2023 NBA Player Stats - Playoffs.csv`: Contains stats for players whose teams qualified for the playoffs.

Data Source: (Mention the source if you know it, e.g., 'Downloaded from Kaggle' or 'Sourced from Basketball-Reference.com')

## 🛠️ Tools Used
 Query Language: SQL
 Database: SQLite
 GUI: DB Browser for SQLite
 Version Control: Git & GitHub

## ⚙️ Methodology
This project follows a standard data analysis workflow:
1.  Database Setup: Created a new SQLite database (`nba_stats.db`).
2.  ETL (Extract, Transform, Load): Imported both `.csv` datasets into SQLite, creating two distinct tables: `regular_season_stats` and `playoff_stats`.
3.  Data Analysis & Querying: Executed a series of SQL queries to explore the data, answer specific questions, and uncover interesting patterns.
4.  Documentation: Documented all queries, findings, and conclusions in this comprehensive report.

---

## 🔬 Analysis & Findings
Below are the detailed analyses performed to derive insights from the data.

### Analysis 1: The Elites - Top 10 Scorers
Objective: To identify the 10 most prolific point-scorers during the 82-game regular season.

SQL Query:
```sql
-- Retrieve the top 10 players by total points (PTS)
SELECT
  Player,
  Tm AS Team,
  PTS
FROM
  regular_season_stats
ORDER BY
  PTS DESC
LIMIT 10;
```
Finding:
Jayson Tatum led the league in total points, reflecting his role as the primary offensive option for his team. Superstars like Joel Embiid and Luka Dončić also dominated the leaderboard, confirming their elite scoring status.
Analysis 2: Positional Roles - Average Statistical Contributions
Objective: To understand how average statistical contributions (points, rebounds, assists) differ across player positions (Guard, Forward, Center).


SQL Query:
```sql
-- Calculate the average Points (PTS), Rebounds (TRB), and Assists (AST) per position
SELECT
  Pos AS Position,
  ROUND(AVG(PTS), 1) AS Avg_Points,
  ROUND(AVG(TRB), 1) AS Avg_Rebounds,
  ROUND(AVG(AST), 1) AS Avg_Assists
FROM
  regular_season_stats
WHERE
  Pos IS NOT NULL AND Pos != 'Pos' -- Clean up invalid position data
GROUP BY
  Position
ORDER BY
  Avg_Points DESC;
```
Finding:
The results clarify traditional basketball roles: Guards (G) significantly lead in average assists, while Centers (C) dominate the boards with the highest average rebounds. Forwards (F) show a balanced contribution in both scoring and rebounding.
Analysis 3: The Playoff Risers - Biggest Performance Jumps
Objective: To identify players whose scoring performance increased most significantly in the playoffs compared to the regular season, often known as "clutch" players.


SQL Query:
```sql
-- Join regular season and playoff data to compare total points
SELECT
  r.Player,
  r.Tm AS Team,
  r.PTS AS Regular_Season_PTS,
  p.PTS AS Playoff_PTS,
  (p.PTS - r.PTS) AS Point_Difference
FROM
  regular_season_stats AS r
JOIN
  playoff_stats AS p ON r.Player = p.Player
WHERE
  r.G > 40 -- Include only players with significant regular season game time
ORDER BY
  Point_Difference DESC
LIMIT 15;
```
Finding:
Jimmy Butler and Devin Booker showed a remarkable increase in total points during the playoffs, underscoring their reputations as players who thrive under pressure. This data provides evidence that some players truly 'level up' when the stakes are highest.
Analysis 4: Shooting Efficiency - The Playoff Sharpshooters
Objective: To find the most efficient shooters (by field goal percentage) among players who took a significant number of shots during the playoffs.


SQL Query:
```sql
-- Use a CTE to filter for players averaging at least 5 shot attempts per game
WITH PlayoffShooters AS (
  SELECT
    Player,
    Tm AS Team,
    "FG%" AS Field_Goal_Percentage,
    "3P%" AS Three_Point_Percentage,
    FGA AS Field_Goals_Attempted,
    G AS Games_Played
  FROM
    playoff_stats
  WHERE
    G > 0 -- Avoid division by zero
)
SELECT
  Player,
  Team,
  Field_Goal_Percentage,
  Three_Point_Percentage
FROM
  PlayoffShooters
WHERE
  (Field_Goals_Attempted / Games_Played) >= 5.0 -- Min. 5 FG attempts per game
ORDER BY
  Field_Goal_Percentage DESC
LIMIT 15;
```
Finding:
Nikola Jokić was not only a high-volume scorer but also incredibly efficient, as shown by his leading Field Goal Percentage. This analysis highlights players who combine productivity with smart shot selection.

📈 Conclusion


This project successfully demonstrates how SQL can be a powerful tool for sports analytics. Key takeaways include:
Regular season performance is not always a direct predictor of playoff success.
Specialist players exist who significantly elevate their game when the competition intensifies.
Both fundamental stats (like total points) and efficiency metrics (like shooting percentages) provide valuable, complementary insights.

🚀 Future Work


Trend Analysis: Compare this season's data with previous years to identify long-term player or league-wide trends.
Correlation Analysis: Investigate relationships between different stats (e.g., does a high assist rate correlate with more efficient team scoring?).
Data Visualization: Export query results to a visualization tool like Tableau or Power BI to create an interactive dashboard.

📂 How to Run This Project


Clone the Repository: git clone https://github.com/YourUsername/YourRepoName.git
Open the Database: Use DB Browser for SQLite to open the nba_stats.db file.
Execute Queries: Navigate to the "Execute SQL" tab to run the queries provided in this report or write your own for further exploration.


{\rtf1\ansi\ansicpg1252\cocoartf2639
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 -- Analisis 1: 10 Pencetak Poin Tertinggi\
SELECT\
  Player,\
  Tm AS Team,\
  PTS\
FROM\
  regular_season_stats\
ORDER BY\
  PTS DESC\
LIMIT 10;\
\
-- Analisis 2: Statistik Rata-Rata Berdasarkan Posisi\
SELECT\
  Pos AS Position,\
  ROUND(AVG(PTS), 1) AS Avg_Points,\
  ROUND(AVG(TRB), 1) AS Avg_Rebounds,\
  ROUND(AVG(AST), 1) AS Avg_Assists\
FROM\
  regular_season_stats\
WHERE\
  Pos IS NOT NULL AND Pos != 'Pos'\
GROUP BY\
  Position\
ORDER BY\
  Avg_Points DESC;\
\
-- Analisis 3: \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 Perbandingan Performa Musim Reguler vs. Playoff\
SELECT\
  r.Player,\
  r.Tm AS Team,\
  r.PTS AS Regular_PTS,\
  p.PTS AS Playoff_PTS,\
  (p.PTS - r.PTS) AS Difference\
FROM\
  regular_season_stats AS r\
JOIN\
  playoff_stats AS p ON r.Player = p.Player\
WHERE\
  r.G > 40\
ORDER BY\
  Difference DESC\
LIMIT 15;\
\
\'97 Analisis 4: Analisis Efisiensi (Menunjukkan Kemampuan Perhitungan Kompleks dan 
\fs26 \strokec2 CTE
\fs24 \strokec2 )\
WITH PlayoffShooters AS (\
  SELECT\
    Player,\
    Tm AS Team,\
    "3P%" AS Three_Point_Percentage,\
    "FG%" AS Field_Goal_Percentage,\
    FGA AS Field_Goals_Attempted,\
    G AS Games_Played\
  FROM\
    playoff_stats\
)\
SELECT\
  Player,\
  Team,\
  Three_Point_Percentage,\
  Field_Goal_Percentage\
FROM\
  PlayoffShooters\
WHERE\
  (Field_Goals_Attempted / Games_Played) >= 5.0 -- Rata-rata minimal 5 tembakan per game\
ORDER BY\
  Three_Point_Percentage DESC, Field_Goal_Percentage DESC\
LIMIT 15;}
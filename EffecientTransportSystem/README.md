# 🚌 Efficient Transport System & Traffic Analytics

An Exploratory Data Analysis (EDA) project on municipal urban transportation networks, traffic flow dynamics, and smart card ticketing transactions. This project evaluates road congestion bottlenecks, public transport load capacity, accident patterns, and smart card fare collection trends to support data-driven urban planning, safety improvements, and transit optimization.

---

## 📌 Project Overview
This project analyzes urban transit efficiency across multiple interconnected datasets. It involves:

- Multi-dataset correlation across road networks, vehicle speeds, transit rides, accidents, and smart card ticketing
- Traffic flow bottleneck identification (speed thresholds < 20 km/h)
- Public transport capacity utilization analysis (overcrowded vs. underutilized routes)
- Accident correlation analysis with hourly time slots, weather conditions, and region
- Financial revenue trends from digital Smart Card fare transactions

---

## 🎯 Objectives
- Identify high-congestion road segments and peak traffic slowdown hours
- Evaluate passenger load versus route capacity to highlight overcrowded transit lines
- Analyze accident occurrences by time of day, road segment, and regional clusters
- Calculate peak revenue hours and fare collection totals from Smart Card transactions
- Generate actionable urban planning recommendations for transit authorities

---

## 📁 Dataset & Files Included

### 1. `Road_Segments.csv`
- Road Segment ID, Street Name, City Region, Designated Capacity Limit

### 2. `Vehicles_Traffic.csv`
- Vehicle Record ID, Road Segment ID, Recorded Speed (km/h), Time of Observation

### 3. `Public_Transport_Rides.csv`
- Trip ID, Bus/Train Route ID, On-board Passenger Count, Trip Timestamp

### 4. `SmartCards.csv`
- Smart Card Account ID, Trip ID, Fare Amount Charged ($), Transaction Timestamp

### 5. `Accidents.csv`
- Incident Report ID, Road Segment ID, Timestamp of Incident, Weather Conditions

---

## 🛠️ Tools & Technologies
- **Data Engine**: Relational Database Engine
- **Analysis Environment**: Database Workbench
- **Documentation**: Microsoft Word Project Report (`efficient-transport-system.docx`)

---

## 🔍 Key Analysis Topics Covered

### 1. 🚦 Traffic Flow & Bottleneck Analysis
- Identifies severe traffic congestion where average vehicle speed drops below 20 km/h during peak commute hours.

### 2. 🚌 Public Transport Load & Overcrowding
- Compares average passenger volume against designated route capacity limits to flag overcrowded vs. underutilized transit lines.

### 3. ⚠️ Accident Patterns & Safety Correlations
- Correlates accident frequencies with hourly time slots, road types, weather conditions, and regional clusters.

### 4. 💳 Fare Collection & Busiest Ticketing Hours
- Calculates total revenue collected via Smart Card payments and isolates the busiest peak earning hours.

---

## 📊 Summary Output Metrics

| Analysis Dimension | Key Finding / Summary Output |
| :--- | :--- |
| **Severe Congestion Zones** | Road segments with average speeds **< 20 km/h** during morning & evening commute hours |
| **Overcrowded Transit Routes** | Select arterial bus routes consistently exceed maximum passenger load capacity |
| **Peak Accident Hours** | High incident spikes recorded between **8 AM - 10 AM** and **5 PM - 7 PM** during rush hours |
| **Busiest Fare Collection Hour** | Peak Smart Card revenue is generated during the **8:00 AM - 9:00 AM** commute window |

---

## 📌 Key Insights
- **Congestion Bottlenecks**: Central city arterial corridors experience severe traffic slowdowns below 20 km/h during morning commute peak hours.
- **Capacity Imbalance**: Certain public bus routes suffer from chronic overcrowding, while peripheral suburban routes remain underutilized.
- **Accident Risk Timing**: Traffic accidents heavily correlate with peak rush hour volume and adverse weather conditions in high-density regions.
- **Digital Ticketing Revenue**: Over 80% of transit revenue is collected via automated Smart Card payments during morning commute hours.

---

## ✅ Recommendations
- **Adjust Bus Fleet Dispatch**: Deploy additional feeder buses to overcrowded routes during morning peak hours (7:30 AM - 9:30 AM).
- **Traffic Signal Timing**: Optimize traffic light signaling on low-speed corridors (< 20 km/h) to improve vehicle throughput.
- **Targeted Road Safety**: Increase traffic enforcement and safety warning signs in high-accident regional zones during peak hours.
- **Off-Peak Smart Card Discounts**: Introduce off-peak fare discounts on Smart Cards to encourage non-essential commuters to travel outside rush hours.

  ## 🎓 Key Learnings
Through this project, I gained valuable practical experience in:
- **Complex Multi-Table Data Modeling**: Linking multiple relational datasets (`Accidents`, `Public_Transport_Rides`, `Road_Segments`, `SmartCards`, `Vehicles_Traffic`) using primary and foreign key relationships.
- **Threshold-Based Analytical Filtering**: Establishing quantitative performance indicators (e.g. flagging congestion when vehicle speeds drop below 20 km/h).
- **Capacity Utilization Assessment**: Comparing passenger demand against infrastructure design limits to identify urban operational bottlenecks.
- **Financial & Operational Analytics**: Combining transactional fare revenue with temporal hourly trends to pinpoint peak financial performance windows.
- **Translating Data to Actionable Strategy**: Converting technical database query findings into real-world business and municipal urban policy recommendations.

👤 **Author**: Rishita Choksi  

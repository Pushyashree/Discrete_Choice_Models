# 🚀 Multinomial Logit Model Analysis on User Preferred Mode for eVTOL Air Taxis  

This project presents a **Multinomial Logit (MNL) Model** analysis on mode choice behavior for the introduction of **electric vertical take-off and landing (eVTOL) air taxis** in Munich. The study investigates **urban vs. suburban mode choice behavior**, evaluating key socio-demographic and travel-related factors influencing the adoption of eVTOLs.

---

## 📌 Project Overview  

Urban Air Mobility (**UAM**) aims to address urban congestion by introducing **eVTOL air taxis**. This study explores user acceptance of this technology by analyzing stated preference survey data from **two geographical regions**:  
- **Urban Region:** Moosach  
- **Suburban Region:** Herrsching  

Using a **Discrete Choice Experiment (DCE)**, respondents were asked to choose between **four transportation modes**:  
1. **Public Transit**  
2. **eVTOL Air Taxi**  
3. **Private Car**  
4. **Private Taxi**  

A **Multinomial Logit Model (MNL)** was applied to estimate the probability of choosing each mode based on individual socio-economic attributes and travel conditions.

---

## 📂 Data and Methodology  

### 🔹 **Data Collection**  
- A **Stated Preference Survey (SC)** was conducted to collect mode choice data.  
- Data was sampled from **112 respondents in Moosach** (urban) and **52 respondents in Herrsching** (suburban).  
- The study included **age, income, travel time, and auto availability** as key attributes.

### 🔹 **Data Preprocessing**  
- Over- and under-sampling **adjusted using weighting factors**.  
- Data converted into **mlogit format** for discrete choice modeling.  
- Training and testing data split **(70% training, 30% testing)** to validate the model.

### 🔹 **Model Estimation**  
- **Baseline models** estimated using **R (mlogit package)** with different predictor combinations.  
- **Final models** included interaction effects between **age, income, and travel time**.  
- Mode shares were analyzed for each **urban and suburban region**.

---

## 📊 Key Findings  

### 📍 **Urban Region (Moosach)**  
- **Young individuals (18-25 years)** and **high-income individuals (>€3000/month)** were **significantly more likely** to choose eVTOL air taxis.  
- **Travel time** had a **negative impact**—longer waiting times reduced the likelihood of choosing eVTOLs.  
- **Public transport remained the dominant choice**, indicating strong existing infrastructure.  

### 📍 **Suburban Region (Herrsching)**  
- Similar to Moosach, **young and high-income individuals** showed a preference for eVTOLs.  
- **Higher reliance on private cars**—residents in Herrsching preferred cars due to limited public transport options.  
- Lower eVTOL adoption rates compared to urban areas.  

---
## 🛠️ Technologies Used
R Programming
Packages: mlogit, ggplot2, corrplot, reshape2
Discrete Choice Analysis: Multinomial Logit (MNL) Model
Survey Data Analysis & Visualization

## ✍️ Author
👤 Pushya Shree Konasale Jayaramu
📧 pushyashree.kj.2000@gmail.com
🔗 https://www.linkedin.com/in/pushya-shree-konasale-jayaramu-6a61881a8/



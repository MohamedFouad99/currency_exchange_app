# 💱 Currency Exchange App


## A Flutter application that allows users to track and convert currency exchange rates in real-time.

# 🚀 Features

### 🔹 Real-Time Exchange Rates – Fetches up-to-date currency exchange rates.

### 🔹 Currency Conversion – Converts amounts between different currencies.

### 🔹 Historical Data – Displays past exchange rates for a selected date range.

### 🔹 Pagination – Loads exchange rate data efficiently in chunks.

### 🔹 User-Friendly Interface – Intuitive and responsive design.

# 📂 Project Structure
## 📂 lib/  
### ├── 📂 core/                              # Core utilities and configurations  
│   ├── 📂 network/                      # API service (Dio)  
│   ├── 📂 error/                       # Error handling (Failure, Exceptions)  
│   ├── 📂 utils/                 # Helper functions and constants  
│   ├── 📂 theme/                 # App themes and styles  
│   ├── 📂 di/                    # Dependency Injection (GetIt)  
│   ├── 📂 usecases/              # Base use case classes  
│   ├── 📂 navigation/            # App navigation and routes  
│   └── 📂 widgets/               # Global reusable widgets  
│  
### ├── 📂 features/                   # Application features  
#### │   ├── 📂 exchange_rate/          # Exchange rate feature  
##### │   │   ├── 📂 data/               # Data layer (repositories, data sources, models)  
│   │   │   ├── 📂 models/         # Data models  
│   │   │   ├── 📂 data_sources/   # Remote & local data sources  
│   │   │   ├── 📂 repositories/   # Repository implementation  
│   │   │   └── 📂 api/            # API integration  
##### │   │   ├── 📂 domain/             # Business logic layer  
│   │   │   ├── 📂 entities/       # Core application entities  
│   │   │   ├── 📂 usecases/       # Application use cases  
│   │   │   └── 📂 repositories/   # Abstract repository contracts  
##### │   │   ├── 📂 presentation/       # UI layer  
│   │   │   ├── 📂 pages/          # Screens & pages  
│   │   │   ├── 📂 cubit/          # State management (Cubit)  
│   │   │   ├── 📂 widgets/        # UI components  
│   │   │   └── 📂 controllers/    # UI logic controllers  
│  
├── 📄 main.dart                   # App entry point  



# 📡 API Integration

## The app integrates with ExchangeRate.host API to fetch real-time currency exchange rates.


### 🔹 Base URL: https://api.exchangerate.host/

### 🔹 Endpoints:

#### /timeframe → Retrieves historical exchange rates.


# 🛠️ Example API Request:

## https://api.exchangerate.host/timeframe?start_date=2024-12-01&end_date=2025-01-04&source=USD


# 📌 Dependencies

### 🔹 Flutter – The core framework.

### 🔹 Dio – For making HTTP requests.

### 🔹 intl – Date formatting and localization.

### 🔹 bloc – State management.

### 🔹 get_it – Dependency injection.





# 🤝 Contributing

## Contributions are welcome! Follow these steps:


### 1️⃣ Fork the repository.

### 2️⃣ Create a feature branch

### 3️⃣ Commit your changes

### 4️⃣ Push to GitHub

### 5️⃣ Create a Pull Request.

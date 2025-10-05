# 🎓 Lehrstuhl Management App

Eine moderne Ruby on Rails Anwendung zur Verwaltung von Studierenden, Abschlussarbeiten und universitären Prozessen mit integriertem KI-Assistenten.

[![Ruby Version](https://img.shields.io/badge/Ruby-3.4.1-red.svg)](https://www.ruby-lang.org/)
[![Rails Version](https://img.shields.io/badge/Rails-7.2-red.svg)](https://rubyonrails.org/)
[![Database](https://img.shields.io/badge/Database-PostgreSQL-blue.svg)](https://www.postgresql.org/)
[![Deployment](https://img.shields.io/badge/Deployed%20on-Fly.io-blueviolet.svg)](https://fly.io/)

---

## 🚀 Features

### ✅ **Aktuell implementiert:**
- **👥 Studierende-Verwaltung** - Vollständige CRUD-Operationen mit modernem UI
- **📋 Abschlussarbeiten-Management** - Konkrete & Abstrakte Arbeiten
- **🤖 KI-Assistent** - OpenAI-Integration für Benutzerunterstützung  
- **🔍 Erweiterte Suche & Filter** - Echtzeit-Filterung mit JavaScript
- **📊 Dashboard & Statistiken** - Übersichtliche Datenvisualisierung
- **📱 Responsive Design** - Bootstrap 5 + moderne CSS
- **🔐 Benutzer-Authentifizierung** - Session-basierte Anmeldung

### 🛠 **In Entwicklung:**
- Vue.js Frontend-Integration
- Testing Suite (RSpec + Vitest)  
- Export/Import Funktionen
- Multi-Language Support (i18n)

---

## 🛠 Tech Stack

| Kategorie | Technologie | Version |
|-----------|-------------|---------|
| **Backend** | Ruby on Rails | 7.2.x |
| **Frontend** | Bootstrap 5 | 5.3.x |
| **JavaScript** | ES6+ Modules | - |
| **Database** | PostgreSQL | 14+ |
| **Storage** | Active Storage | - |
| **AI** | OpenAI API | GPT-4o-mini |
| **Deployment** | Fly.io | - |
| **Styling** | Sass (SCSS) | - |

---

## ⚡ Quick Start

### **Voraussetzungen**
- Ruby 3.4.1+
- PostgreSQL 14+
- Node.js 18+
- Git

### **1. Repository klonen**
```bash
git clone https://github.com/username/lehrstuhl-app.git
cd lehrstuhl-app
```

### **2. Dependencies installieren**
```bash
# Ruby Gems
bundle install

# JavaScript Packages  
npm install
# oder yarn install
```

### **3. Umgebung konfigurieren**
```bash
# Environment Variables kopieren
cp .env.example .env

# .env editieren:
# DATABASE_URL=postgresql://user:password@localhost/lehrstuhl_app_development
# OPENAI_API_KEY=sk-your-openai-key-here
# SECRET_KEY_BASE=your-secret-key
```

### **4. Datenbank einrichten**
```bash
# Datenbank erstellen und Migrations ausführen
rails db:setup

# Oder manuell:
rails db:create
rails db:migrate
rails db:seed
```

### **5. Server starten**
```bash
rails server
# Läuft auf: http://localhost:3000
```

---

## 🔐 Login-Daten (Development)

| Rolle | Email | Passwort |
|-------|-------|----------|
| **Admin** | `admin@example.de` | `password` |
| **Benutzer** | `user@example.de` | `password` |

---

## 🧪 Testing

```bash
# Alle Tests ausführen (wenn implementiert)
bundle exec rspec

# Mit Coverage-Report
COVERAGE=true bundle exec rspec

# JavaScript Tests
npm test
```

---

### **Datenbank-Konfiguration**
```yaml
# config/database.yml
development:
  adapter: postgresql
  encoding: unicode
  database: lehrstuhl_app_development
  username: postgres
  password: password
  host: localhost
  port: 5432
```

---

## 🎯 Verwendung

### **Dashboard**
- Übersicht aller wichtigen Kennzahlen
- Schnellzugriff auf häufige Aktionen
- Letzte Aktivitäten

### **Studierende verwalten**
- Hinzufügen, Bearbeiten, Löschen von Studierenden
- Erweiterte Filter (Name, Email, Geburtsjahr)
- Grid- und Listen-Ansicht
- Datenexport (geplant)

### **KI-Assistent**
- Natürlichsprachige Queries
- Kontextuelles Verständnis der App
- Hilfe bei Navigation und Funktionen
- Powered by OpenAI GPT-4o-mini

### **Abschlussarbeiten**
- Verwaltung konkreter und abstrakter Arbeiten
- Status-Tracking
- Studierenden-Zuordnung

---

## 🛠 Entwicklung

### **Code-Style**
- Folge Rails-Konventionen
- Verwende RuboCop für Ruby-Code
- ESLint für JavaScript (geplant)
- SCSS-Lint für Styles

</div>
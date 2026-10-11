# TexMash — Pure Java Web Application

**TexMash** is an anonymous campus communication and social networking web application designed for university students. It allows students to broadcast candid thoughts, discover trending campus discussions, express empathy via the "Relate" system, and build anonymous mutual connections ("Mates") without exposing their real identity.

This project is a **pure Java Jakarta EE (Servlet / JSP / JDBC) 4-tier MVC application** built without heavy frameworks (no Spring, no Hibernate) for clear academic examination and viva presentation.

---

## 📚 Project Architecture & Grading Documentation

* **Problem & System Design**: [`docs/PROBLEM_AND_DESIGN.md`](docs/PROBLEM_AND_DESIGN.md) (Architecture, Class Diagram, ER Diagram, User Journey, Decisions).
* **Evaluator Marks Mapping**: [`docs/MARKS_MAPPING.md`](docs/MARKS_MAPPING.md) (Complete matrix mapping each grading criterion to exact source classes).

---

## 🛠️ Technology Stack & Prerequisites

* **Java Version**: Java 17 or Java 21 (LTS)
* **Web Layer**: Jakarta Servlet API 6.0, Jakarta JSTL 3.0, JSP Views (`WEB-INF/views/`)
* **Persistence / Database**: Pure JDBC with `PreparedStatement`, Multi-Table `JOIN`s, and explicit ACID Transactions (`setAutoCommit(false)`, `commit()`, `rollback()`)
* **Database Engine**: Embedded H2 Database (zero installation needed, runs in-memory/file with standard SQL) — easily switchable to MySQL or PostgreSQL via `src/main/resources/db.properties`
* **Servlet Container**: Apache Tomcat 10+ (or any Jakarta EE 10 compliant web container)
* **Build Tool**: Apache Maven 3.8+

---

## 🚀 Quick Start & Build Instructions

### 1. Build the WAR Package
From the `java-app/` directory:
```bash
mvn clean package
```
This runs all JUnit 5 test suites and generates the deployment archive:
`target/texmash.war`

### 2. Deploy & Run on Apache Tomcat 10+
1. Copy `target/texmash.war` into your Tomcat `webapps/` folder:
   ```bash
   cp target/texmash.war /path/to/tomcat10/webapps/
   ```
2. Start Tomcat:
   ```bash
   /path/to/tomcat10/bin/startup.sh   # (or startup.bat on Windows)
   ```
3. Open your browser and navigate to:
   ```
   http://localhost:8080/texmash/
   ```

---

## 🗄️ Database Configuration (`db.properties`)

The database connection is managed by [`com.texmash.util.DBConnection`](src/main/java/com/texmash/util/DBConnection.java) and configured in `src/main/resources/db.properties`:

```properties
db.driver=org.h2.Driver
db.url=jdbc:h2:mem:texmashdb;DB_CLOSE_DELAY=-1;MODE=MySQL
db.user=sa
db.password=
db.init.schema=true
db.schema.path=schema.sql
db.data.path=sample_data.sql
```

> **Note**: When `db.init.schema=true`, the application automatically creates all tables from `schema.sql` and loads the initial seed records from `sample_data.sql` on startup.

---

## 🧪 Sample Test Inputs & Expected Results (Live Demo Guide)

Use these test scenarios during demonstration and evaluation:

### Test Case 1: Quick Student Authentication
* **Input (Quick Entry)**: Enter `21SCSE1010757` in the Student Admission ID field.
* **Expected Result**: Authenticates successfully, automatically creates a new pseudonymous identity (e.g. *"Silent Wolf 427"*), generates an avatar, creates a session, and redirects to `/feed`.

### Test Case 2: Pre-seeded User Login
* **Input (Account Login)**:
  - Email / ID: `alex.21scse1010001@galgotiasuniversity.ac.in`
  - Password: `password123`
* **Expected Result**: Successfully logs in as **Silent Wolf 427**, loads his connected mate (*Neon Hawk 819* / Priya), and displays pending mate request from *Cosmic Nova 105* (Rahul).

### Test Case 3: Thought Broadcasting & Hashtag Extraction
* **Input**: Click **Broadcast** tab, type: `Studying for the algorithms exam at the library! #exams #coding #allnighter`, and click **Broadcast Thought**.
* **Expected Result**: Thought appears instantly at the top of the feed with interactive `#exams`, `#coding`, and `#allnighter` tags highlighted in blue.

### Test Case 4: "Relate" (Like) Interaction
* **Input**: Click the **Relate** heart button on any post.
* **Expected Result**: Heart highlights in white/blue, count increments by 1. Clicking it again removes the relate and decrements the count.

### Test Case 5: Algorithmic Feed Sorting (Recent vs. Trending)
* **Input**: Switch between **For You** (Recent) and **Trending 🔥** buttons.
* **Expected Result**: 
  - **For You**: Orders posts in strict reverse chronological order.
  - **Trending**: Orders posts using the time-decay relevance score $\frac{\text{likes} \times 10}{\text{hours} + 1}$, ranking high-engagement recent posts at the top.

### Test Case 6: Mate System (Accept & Connect)
* **Input**: Under the **Mates** sidebar panel, click **Accept** on Rahul's pending request.
* **Expected Result**: Pending request disappears; Rahul (*Cosmic Nova 105*) is atomically added to your mutual Mates list (badge counter updates to 2).

### Test Case 7: Authorization Protection
* **Input**: Try to edit or delete a post authored by another user.
* **Expected Result**: Edit/Delete menu is completely hidden from non-authors; any direct manipulated request to `/posts?action=delete` by a non-author throws a 403 / `AuthenticationException`.

---

## 🧪 Running Automated Unit Tests
To execute all service layer tests:
```bash
mvn test
```
All tests in `UserServiceTest`, `PostServiceTest`, `MateServiceTest`, and `ValidationUtilTest` will run and pass.

---

## 🏛️ Package Architecture Overview

```
com.texmash/
├── model/        -> BaseEntity, User, Post, MateRequest, Hashtag (OOP & Encapsulation)
├── enums/        -> UserRole, MateRequestStatus, FeedFilterMode
├── dao/          -> GenericDao, UserDao, PostDao, MateDao (Abstraction & Interfaces)
├── dao/impl/     -> UserDaoImpl, PostDaoImpl, MateDaoImpl (JDBC & Transactions)
├── service/      -> UserService, PostService, MateService (Business Logic)
├── service/impl/ -> UserServiceImpl, PostServiceImpl, MateServiceImpl
├── servlet/      -> AuthServlet, PostServlet, MateServlet, FeedServlet, ProfileServlet
├── filter/       -> AuthFilter, CharacterEncodingFilter
├── util/         -> DBConnection, PasswordUtil, NameGenerator, ValidationUtil, JsonUtil
└── exception/    -> TexMashException and domain exception hierarchy
```

CasaBatangueño — Apartment & Dormitory Rental Management System

Customer portal (/) — search/filter Batangas City listings, Leaflet + OpenStreetMap map, property details, online rental application with reference number.

Owner portal (/owner.html) — JWT login with roles (owner, admin, staff), dashboard KPIs, 6 Chart.js charts with date filters, CRUD for properties, buildings, rooms, tenants, applications, payments (with printable receipts) and expenses, financial reports with Print / PDF / Excel export.

Stack: HTML5, CSS3, vanilla JavaScript (frontend) · Node.js + Express (backend) · bcryptjs + jsonwebtoken (security) · Chart.js, Leaflet, jsPDF, SheetJS (loaded from CDN).

Run locally

Requirements: Git Bash and Node.js

To run this code locally, open the terminal in the project folder and type:

npm install
npm start



(If cloning from GitHub for the first time, run git clone <your-repo-url> and cd <project-folder> first; once dependencies are installed, just type npm start.)

Customer portal: http://localhost:3000

Owner portal: http://localhost:3000/owner.html

Optional: create a .env file in the root folder to override PORT (defaults to 3000) or JWT_SECRET.

Demo accounts

Owner: owner@casa-bat.com / Owner123! 

Admin: admin@casa-bat.com / Admin123!

Staff: staff@casa-bat.com / Staff123!

"Reset demo data" in the top bar restores server/seed.json. If you edited server/seed.json locally and still see old data, delete server/data/store.json and restart npm start.

Folder structure

server/app.js      Express app: auth, public API, dashboard, CRUD, reports
server/server.js   Starts the server (npm start)
server/db.js       Data layer (JSON file) — the only file that touches storage
server/seed.json   Demo data; live data is written to server/data/store.json
public/            index.html (customer), owner.html (dashboard), css/, js/, images/
api/index.js       Vercel serverless entry (re-uses server/app.js)
database/          schema.sql + seed.sql: 19-table MySQL design for XAMPP/phpMyAdmin



API (Bearer token for everything except /public and /auth/login)

GET /api/health

GET /api/public/properties · GET /api/public/properties/:id · POST /api/public/applications

POST /api/auth/login · GET /api/auth/me

GET /api/dashboard/summary?range=today|week|month|year|all|custom&start&end

/api/properties · /api/buildings · /api/rooms · /api/tenants (POST /:id/move-out)

/api/applications (PATCH /:id/status, POST /:id/convert) · /api/payments · /api/expenses

GET /api/reports/financial · /api/users (admin) · POST /api/demo/reset



Using MySQL instead

database/schema.sql and database/seed.sql are ready to import in phpMyAdmin. To switch, replace the functions in server/db.js / the s() calls in server/app.js with mysql2/promise queries (parameterised ? placeholders).

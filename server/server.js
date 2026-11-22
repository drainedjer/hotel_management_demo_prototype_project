require('dotenv').config();
const app = require('./app');
const PORT = Number(process.env.PORT) || 3000;
app.listen(PORT, () => console.log(`HavenStay running at http://localhost:${PORT}`));

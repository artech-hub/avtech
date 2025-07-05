#!/usr/bin/env node

const express = require('express');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 8080;

// Serve static files from docs directory
app.use('/avtech', express.static(path.join(__dirname, 'docs')));

// Handle Angular routing - serve index.html for all routes
app.get('/avtech/*', (req, res) => {
  res.sendFile(path.join(__dirname, 'docs', 'index.html'));
});

// Redirect root to /avtech
app.get('/', (req, res) => {
  res.redirect('/avtech/');
});

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
  console.log(`Your app is available at: http://localhost:${PORT}/avtech/`);
});

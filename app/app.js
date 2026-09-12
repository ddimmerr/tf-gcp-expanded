const http = require('http');

// 8080 is the standard default for Google Cloud Run
const port = process.env.PORT || 8080; 
const NODE_ENV = process.env.NODE_ENV || 'unknown';

const server = http.createServer((req, res) => {
  try {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end(`hello GCP - ${NODE_ENV}\n`);
  } catch (err) {
    console.error('Request error:', err);
    res.statusCode = 500;
    res.end('Internal Server Error\n');
  }
});

// Handle server-wide errors (e.g., port already in use)
server.on('error', (err) => {
  console.error('Server error:', err);
});

server.listen(port, () => {
  console.log(`Server running on port ${port} in ${NODE_ENV} environment.`);
});
import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import { SearchController } from './controllers/SearchController';
import { authMiddleware } from './middlewares/authMiddleware';
import { searchLimiter } from './middlewares/rateLimiter';

const app = express()
app.set('trust proxy', 1);

app.use(cors({
    origin: '*',
    methods: ['GET', 'POST']
})); // Permite que o servidor aceite requisições de outros domínios
app.use(express.json()); // Permite que o servidor aceite requisições JSON

const searchController = new SearchController();

app.post('/search', authMiddleware, searchLimiter, (req, res) => {

    console.log("====================================");
    console.log("REQUISIÇÃO RECEBIDA NO /SEARCH!");
    console.log("Corpo da requisição:", req.body);
    console.log("====================================");

    return searchController.handle(req, res);
});

app.get('/health', (_req, res) => {
    res.json({ status: 'ok', message: 'Working' });
});

const PORT = Number(process.env.PORT) || 3000;

app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server running on port em http://0.0.0.0:${PORT}`);
    console.log('Server started successfully');
});
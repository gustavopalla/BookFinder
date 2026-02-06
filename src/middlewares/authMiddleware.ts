import { Request, Response, NextFunction } from 'express';

export const authMiddleware = (req: Request, res: Response, next: NextFunction) => {

    const apiKey = req.headers['x-api-key'];

    if (!apiKey || apiKey !== process.env.API_ACESS_KEY) {
        return res.status(403).json({
            erro: 'Não autorizado',
            details: 'Você precisa de uma x-api-key valida para acessar esta rota'
        })
    }

    return next();
}
import rateLimit from "express-rate-limit";

export const searchLimiter = rateLimit({
    windowMs: 1 * 60 * 1000,
    max: 10,
    message: {
        error: 'Você excedeu o limite de requisições. Tente novamente mais tarde.',
        details: 'Você pode fazer 10 requisições por minuto'
    },
    standardHeaders: true,
    legacyHeaders: false,
})
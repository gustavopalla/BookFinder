import { SearchService } from "../services/SearchService";
import { SearchQuerySchema } from "../schemas/SearchQuerySchema";
import { Request, Response } from "express";
import z from "zod";

export class SearchController {
    async handle(req: Request, res: Response): Promise<Response> {
        try {

            const validatedData = SearchQuerySchema.parse(req.body);

            //const { query } = req.body;
            console.log(`🔎 Nova busca recebida: ${validatedData.query}`);

            const searchService = new SearchService();
            const results = await searchService.execute(validatedData.query);
            return res.status(200).json(results);
        } catch (error) {

            if (error instanceof z.ZodError) {
                return res.status(400).json({
                    error: 'Dados inválidos',
                    details: error.issues.map(e => e.message)
                });
            }

            console.error('Error executing search:', error);
            return res.status(500).json({ error: 'Internal server error' });
        }
    }
}
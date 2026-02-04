import { SearchService } from "../services/SerachService";
import { Request, Response } from "express";

export class SearchController {
    async handle(req: Request, res: Response): Promise<Response> {
        const { query } = req.body;

        if (!query) {
            return res.status(400).json({ error: 'Query is required', details: 'Please provide a query' });
        }

        try {
            const searchService = new SearchService();
            const results = await searchService.execute(query);
            return res.status(200).json(results);
        } catch (error) {
            console.error('Error executing search:', error);
            return res.status(500).json({ error: 'Internal server error' });
        }

        return res.status(200).json({ message: 'Search executed successfully' });
    }
}
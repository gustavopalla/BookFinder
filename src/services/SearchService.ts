import { Book as BookResult } from "../models/Book";
import axios from "axios";

export class SearchService {
    private readonly API_KEY = process.env.API_KEY;
    private readonly API_URL = 'https://google.serper.dev/search';

    async execute(query: string): Promise<BookResult[]> {
        try {
            console.log(`Buscando PDFs: ${query}`);

            const data = JSON.stringify({
                "q": `${query} filetype:pdf`,
            });

            const config = {
                method: 'post',
                url: this.API_URL,
                headers: {
                    'Content-Type': 'application/json',
                    'X-API-Key': this.API_KEY,
                },
                data: data,
            };

            const response = await axios.request(config);

            return (response.data.organic || []).map((result: any) => ({
                title: result.title,
                link: result.link,
                displayLink: result.domain || new URL(result.link).hostname,
            }));

        } catch (error) {
            console.error('Error executing search:', error);
            throw error;
        }
    }
}

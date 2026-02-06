import { z } from 'zod';

export const SearchQuerySchema = z.object({
    query: z
        .string()
        .min(2, { message: "Busca muito curta" })
        .max(50, { message: "Busca muito longa" })
        .regex(/^[a-zA-Z0-9 áéíóúÁÉÍÓÚâêîôûÂÊÎÔÛãõÃÕçÇ]+$/, {
            message: "A busca contém caracteres inválidos",
        })
        .transform((val) => val.trim()),
});

export type SearchInput = z.infer<typeof SearchQuerySchema>;
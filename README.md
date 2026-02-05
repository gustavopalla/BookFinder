Um buscador livros desenvolvido para facilitar a localização de arquivos PDF na internet. A ideia desse projeto veio de uma necessidade real. Minha namorada precisava facilitar a busca dela por PDFs para colocar subir no kindle que ela tem. Como ela tem Iphone, então não queria pagar uma taxa para a apple para subir minha aplicação para IOS. Então subi o projeto na vercel para que ela pudesse utilizar via web e o projeto ficou responsivo para computador e para mobile.

- **Frontend:** Flutter (Web & Android)
- **Backend:** Node.js + TypeScript
- **Hospedagem:** Render (Backend) & Vercel (Frontend Web)
- **API de Busca:** Serper.dev

## Desafios e Aprendizados
O maior desafio deste projeto não foi o código em si, mas encontrar a **infraestrutura de dados** correta:

1. **A Saga das APIs e o Erro 500:** O início foi frustrante. Tentei a *Google Custom Search* e outras ferramentas que retornavam erros constantes. Enfrentei muitos **Status 500** e falhas de conexão. O aprendizado real veio aqui: aprendi a analisar **logs de servidor**, identificar onde a requisição morria e ajustar a lógica até encontrar a **Serper API**, que finalmente trouxe estabilidade.
2. **Debug em Produção:** Aprendi que o código funcionar na minha máquina não garantia que funcionaria no **Render**. Tive que aprender a monitorar os logs em tempo real para entender por que a API falhava no deploy e como as chaves de ambiente eram lidas pelo servidor.
3. **Segurança de Elite:** O uso de variáveis de ambiente (`.env`) foi uma prioridade desde o primeiro commit para proteger o projeto.
4. **Resiliência Técnica:** O maior aprendizado foi não desistir quando o código retornava erro. Cada falha me ensinou a ler melhor a documentação das APIs e a entender como as requisições HTTP funcionam por debaixo dos panos.

## 📦 Como rodar o projeto
1. **API Key:** Crie uma conta no [Serper.dev](https://serper.dev/) e pegue sua chave.
2. **Backend:** - `npm install`
   - Crie um `.env` com o campo: `API_KEY:sua api aqui` (Ver aquivo .env.example).
   - `npm start`
3. **Frontend:** - No Flutter, aponte a URL para o seu servidor (Local ou Render).
   - `flutter pub get`
   - `flutter run`
4. **APK**
    - Para gerar o APK, digite no terminal:
        - flutter build apk --release;
        - Logo vá até a pasta build/app/output/flutter_apk.
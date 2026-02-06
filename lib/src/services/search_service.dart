import 'package:dio/dio.dart';
import 'package:find_book_pdf/src/data/models/book_model.dart';

class SearchService {
  final String _baseUrl = 'https://bookfinder-phai.onrender.com/search';
  final String _apiKey = String.fromEnvironment('API_ACCESS_KEY');
  late final Dio _dio = Dio(
    BaseOptions(
      headers: {'x-api-key': _apiKey},
      connectTimeout: const Duration(
        seconds: 15,
      ), // Tempo para achar o servidor
      receiveTimeout: const Duration(
        seconds: 15,
      ), // Tempo para o servidor responder
      contentType: 'application/json',
    ),
  );

  Future<List<BookModel>> fetchBooks(String query) async {
    try {
      final response = await _dio.post(_baseUrl, data: {'query': query});

      print('DEBUG: Resposta recebida! Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        List items = response.data;

        return items.map((item) => BookModel.fromJson(item)).toList();
      } else {
        throw Exception('Erro ao buscar livros');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        throw Exception(
          'Você excedeu o limite de requisições. Tente novamente mais tarde.',
        );
      }
      return [];
    } catch (e) {
      print('--- ERRO GERAL ---');
      print('Mensagem: $e');
      return [];
    }
  }
}

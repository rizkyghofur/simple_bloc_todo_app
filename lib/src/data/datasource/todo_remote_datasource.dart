import '../../core/error/exceptions.dart';
import '../../core/constants/api_constants.dart';
import '../models/todo_model.dart';
import '../../core/network/dio_client.dart';
import '../models/todo_detail_model.dart';

abstract class TodoRemoteDataSource {
  Future<TodoModel> get();

  Future<TodoDetailModel> detail(int id);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final DioClient dioClient;

  TodoRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<TodoModel> get() async {
    try {
      final response = await dioClient.get(ApiConstants.getTodoEndpoint);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return TodoModel.fromJson(response.data);
      } else {
        throw ServerException('Failed to get todo');
      }
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<TodoDetailModel> detail(int id) async {
    try {
      final response = await dioClient.get(ApiConstants.detailTodoEndpoint(id));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return TodoDetailModel.fromJson(response.data);
      } else {
        throw ServerException('Failed to detail todo');
      }
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

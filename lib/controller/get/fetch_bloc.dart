import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobber/controller/get/fetch_event.dart';
import 'package:hobber/controller/get/fetch_state.dart';
import 'package:http/http.dart' as http;

import '../../model/create_user_model.dart';
import '../../model/get_model.dart';

class FetchBloc extends Bloc<FetchEvent, FetchState> {
  FetchBloc() : super(FetchInitial()) {
    /// Fetch User List
    on<FetchDataEvent>((event, emit) async {
      emit(FetchLoading());
      try {
        final response = await http.get(
          Uri.parse('https://emergingideas.ae/test_apis/read.php?email=mike.hsch@gmail.com'),
        );
        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body) as List;
          final data = jsonData.map((json) => GetModel.fromJson(json)).toList();
          emit(FetchSuccess(data));
        } else {
          emit(FetchError('Error fetching data: ${response.statusCode}'));
          print('Error fetching data: ${response.statusCode}');
        }
      } catch (error) {
        emit(FetchError('Error: $error'));
        print('Error: $error');
      }
    });

    /// Delete user list
    on<DeleteItemEvent>((event, emit) async {
      emit(FetchLoading());
      try {
        final response = await http.get(
          Uri.parse(
            'https://emergingideas.ae/test_apis/delete.php?email=mike.hsch@gmail.com&id=${event.id}',
          ),
        );
        if (response.statusCode == 200) {
          final updatedResponse = await http.get(
            Uri.parse('https://emergingideas.ae/test_apis/read.php?email=mike.hsch@gmail.com'),
          );
          if (updatedResponse.statusCode == 200) {
            final jsonData = jsonDecode(updatedResponse.body) as List;
            final updatedData = jsonData.map((json) => GetModel.fromJson(json)).toList();
            emit(FetchSuccess(updatedData));
          } else {
            emit(FetchError('Error fetching updated data: ${updatedResponse.statusCode}'));
          }
        } else {
          emit(FetchError('Error deleting item: ${response.statusCode}'));
        }
      } catch (error) {
        emit(FetchError('Error: $error'));
      }
    });

    /// Create user list
    on<CreateListEvent>((event, emit) async {
      emit(CreateListLoading());
      try {
        final response = await http.post(
          Uri.parse('https://emergingideas.ae/test_apis/create.php'),
          body: {
            'email': event.email,
            'description': event.description,
            'title': event.title,
            'img_link': event.imgLink,
          },
        );
        if (response.statusCode == 200) {
          emit(CreateListSuccess());
          print('Response after creating user: ${response.body}');
          final fetchDataResponse = await http.get(
            Uri.parse('https://emergingideas.ae/test_apis/read.php?email=mike.hsch@gmail.com'),
          );
          if (fetchDataResponse.statusCode == 200) {
            final jsonData = jsonDecode(fetchDataResponse.body) as List;
            final data = jsonData.map((json) => GetModel.fromJson(json)).toList();
            emit(FetchSuccess(data));
          } else {
            emit(FetchError('Error fetching updated data: ${fetchDataResponse.statusCode}'));
          }
        } else {
          emit(CreateListError('Error creating list: ${response.statusCode}'));
          print('Error creating list: ${response.statusCode}');
        }
      } catch (error) {
        emit(CreateListError('Error: $error'));
        print('Error: $error');
      }
    });
  }
}

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'checkout_event.dart';
// import 'checkout_state.dart';
// import '../../repositories/order_repository.dart';

// class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
//   final OrderRepository repository;
//   CheckoutBloc({required this.repository}) : super(CheckoutInitial()) {
//     on<PlaceOrder>(_onPlaceOrder);
//   }

//   Future<void> _onPlaceOrder(PlaceOrder event, Emitter<CheckoutState> emit) async {
//     if (event.items.isEmpty) {
//       emit(CheckoutFailure('Cart is empty'));
//       return;
//     }
//     emit(CheckoutLoading());
//     try {
//       final order = await repository.placeOrder(event.restaurantId, event.items);
//       emit(CheckoutSuccess(order));
//     } catch (e) {
//       emit(CheckoutFailure(e.toString()));
//     }
//   }
// }

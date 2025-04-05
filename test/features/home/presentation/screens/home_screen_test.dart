import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wendys_challenge/core/entities/product_entity.dart';
import 'package:wendys_challenge/core/widgets/exception_widget.dart';
import 'package:wendys_challenge/core/widgets/loading_widget.dart';
import 'package:wendys_challenge/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:wendys_challenge/features/cart/presentation/widgets/cart_icon.dart';
import 'package:wendys_challenge/features/home/domain/entities/category_entity.dart';
import 'package:wendys_challenge/features/home/domain/exceptions/home_exceptions.dart';
import 'package:wendys_challenge/features/home/presentation/cubit/get_menus_cubit.dart';
import 'package:wendys_challenge/features/home/presentation/screens/home_screen.dart';

class MockGetMenusCubit extends Mock implements GetMenusCubit {}

class MockCartCubit extends Mock implements CartCubit {}

void main() {
  late MockGetMenusCubit mockCubit;
  late MockCartCubit mockCartCubit;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockCubit = MockGetMenusCubit();
    mockCartCubit = MockCartCubit();
    when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockCartCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget buildTestableWidget() {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<GetMenusCubit>.value(value: mockCubit),
          BlocProvider<CartCubit>.value(value: mockCartCubit),
        ],
        child: const HomeScreen(),
      ),
    );
  }

  group('Home Screen', () {
    final mockProducts = [
      const ProductEntity(
        id: 1,
        name: 'Product 1',
        description: '',
        menuItemId: 1,
      ),
      const ProductEntity(
        id: 1,
        name: 'Product 1',
        description: '',
        menuItemId: 1,
      ),
    ];

    final mockCategories = [
      const CategoryEntity(name: 'Category 1', products: []),
      const CategoryEntity(name: 'Category 2', products: []),
    ];

    testWidgets('shows loading widget initially', (tester) async {
      when(() => mockCubit.state).thenReturn(const GetMenusState.initial());
      when(() => mockCartCubit.state).thenReturn(const []);

      await tester.pumpWidget(buildTestableWidget());

      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets('shows loading widget when loading', (tester) async {
      when(
        () => mockCubit.state,
      ).thenReturn(const GetMenusState.loadInProgress());
      when(() => mockCartCubit.state).thenReturn(const []);

      await tester.pumpWidget(buildTestableWidget());

      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets('shows exception widget on failure', (tester) async {
      when(
        () => mockCubit.state,
      ).thenReturn(const GetMenusState.loadFailure(HomeExceptions.generic()));
      when(() => mockCartCubit.state).thenReturn(const []);

      await tester.pumpWidget(buildTestableWidget());

      expect(find.byType(ExceptionWidget), findsOneWidget);
    });

    testWidgets('shows list of categories on success', (tester) async {
      when(
        () => mockCubit.state,
      ).thenReturn(GetMenusState.loadSuccess(mockCategories));
      when(() => mockCartCubit.state).thenReturn(const []);

      await tester.pumpWidget(buildTestableWidget());

      expect(find.text('Category 1'), findsOneWidget);
      expect(find.text('Category 2'), findsOneWidget);
    });

    testWidgets('shows cart icon with item count', (tester) async {
      when(
        () => mockCubit.state,
      ).thenReturn(GetMenusState.loadSuccess(mockCategories));
      when(() => mockCubit.state).thenReturn(const GetMenusState.initial());
      when(() => mockCartCubit.state).thenReturn(mockProducts);

      await tester.pumpWidget(buildTestableWidget());

      expect(find.byType(CartIcon), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
    });
  });
}

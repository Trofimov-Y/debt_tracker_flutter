//TODO Remove test code
import 'dart:math';

const debt = 4884.54;
const owed = 3016.31;

class Contact {
  Contact(
    this.id, {
    required this.name,
    required this.avatarUrl,
  });
  final int id;
  final String name;
  final String avatarUrl;
}

class Operation {
  Operation({
    required this.contact,
    required this.type,
    required this.value,
    required this.date,
  });

  final Contact contact;
  final OperationType type;
  final double value;
  final DateTime date;
}

enum OperationType {
  owed,
  debt;

  @override
  String toString() {
    switch (this) {
      case OperationType.owed:
        return 'Owed';
      case OperationType.debt:
        return 'Debt';
    }
  }
}

final operations = List.generate(
  25,
  (index) {
    final contact = contacts[index % contacts.length];
    final type = index.isEven ? OperationType.owed : OperationType.debt;
    final value = index * 100.0;
    final date = DateTime.now().subtract(Duration(hours: index * 8));
    return Operation(
      contact: contact,
      type: type,
      value: index.isOdd ? value : -value,
      date: date,
    );
  },
);

Map<DateTime, List<Operation>> getOperationsByDay(List<Operation> operations) {
  final operationsByDay = <DateTime, List<Operation>>{};
  for (final operation in operations) {
    final date = DateTime(operation.date.year, operation.date.month, operation.date.day);
    if (!operationsByDay.containsKey(date)) {
      operationsByDay[date] = [];
    }
    operationsByDay[date]!.add(operation);
  }
  return operationsByDay;
}

final List<String> commonNames = [
  'John',
  'Mary',
  'James',
  'Elizabeth',
  'William',
  'Margaret',
  'George',
  'Anne',
  'Thomas',
  'Catherine',
  'Richard',
  'Jane',
  'Henry',
  'Sarah',
  'Edward',
  'Frances',
  'Robert',
  'Martha',
  'Charles',
  'Dorothy',
];

final List<String> commonDebtDescriptions = [
  'Dinner at restaurant',
  'Loan for car repair',
  'Borrowed for rent',
  'Paid for concert tickets',
  'Lent for medical expenses',
  'Covered grocery expenses',
  'Borrowed for vacation',
  'Paid for hotel stay',
  'Lent for tuition fees',
  'Covered utility bills',
];

final contacts = List.generate(
  10,
  (index) {
    final name = commonNames[Random().nextInt(commonNames.length)];
    final avatarUrl = 'https://picsum.photos/id/$index/200/200';
    return Contact(
      index,
      name: name,
      avatarUrl: avatarUrl,
    );
  },
);

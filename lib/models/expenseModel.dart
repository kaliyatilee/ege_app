// "id":3,"expense_id":"09128130","description":"Shipping wnf","date_captured":"2023-01-19 00:00:00","branch_id":"1","amount":"332","added_by":"3","edited_by":null,"bln_active":1,"created_at":"2023-01-09 14:55:21","updated_at":"2023-01-11 06:30:37","name":"Admin","email":"admin@egerecords.com","email_verified_at":null,"password":"$2y$10$uCRVUkIjDX6KHVdxTPykcuD49AUq3A5WnBaNZIdVoyBxFIeK2AZ.6","remember_token":nullclass 
class Expenses {
  final int id;
  final String expense_id;
  final String amount;
  final String description;
  final String branch_id;
  final String name;
  final String date_captured;

  Expenses({
    required this.id,
    required this.expense_id,
    required this.amount,
    required this.description,
    required this.branch_id,
    required this.name,
    required this.date_captured
  });

  factory Expenses.fromJson(Map<String, dynamic> json) {
  return Expenses(
    id: int.parse(json['id'].toString()),
    expense_id: json['expense_id'] as String,
    amount: json['amount'],
    description: json['description'] as String,
    branch_id: json['branch_id'] as String,
    name: json['name'] as String,
    date_captured: json['date_captured'] as String
  );
}
}
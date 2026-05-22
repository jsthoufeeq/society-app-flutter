import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'payment_model.g.dart';

enum PaymentStatus { pending, success, failed }
enum PaymentType  { subscription, maintenance, other }

@JsonSerializable()
class PaymentModel extends Equatable {
  final String id;
  final double amount;
  final String currency;
  final PaymentStatus status;
  final PaymentType type;
  @JsonKey(name: 'razorpay_order_id')   final String? razorpayOrderId;
  @JsonKey(name: 'razorpay_payment_id') final String? razorpayPaymentId;
  final String description;
  @JsonKey(name: 'member_id')   final String memberId;
  @JsonKey(name: 'society_id')  final String societyId;
  @JsonKey(name: 'created_at')  final DateTime createdAt;

  const PaymentModel({
    required this.id,
    required this.amount,
    required this.currency,
    required this.status,
    required this.type,
    this.razorpayOrderId,
    this.razorpayPaymentId,
    required this.description,
    required this.memberId,
    required this.societyId,
    required this.createdAt,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);

  @override
  List<Object?> get props => [id, amount, status];
}

@JsonSerializable()
class RazorpayOrder {
  final String id;
  final int amount;       // in paise
  final String currency;
  final String receipt;
  @JsonKey(name: 'key_id') final String keyId; // Razorpay public key

  const RazorpayOrder({
    required this.id,
    required this.amount,
    required this.currency,
    required this.receipt,
    required this.keyId,
  });

  factory RazorpayOrder.fromJson(Map<String, dynamic> json) =>
      _$RazorpayOrderFromJson(json);
}

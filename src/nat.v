Require Import prelude ssreflect datatypes number.

Inductive nat :=
| O
| S of nat.

Register nat as num.nat.type.
Register O as num.nat.O.
Register S as num.nat.S.

Declare Scope nat_scope.

Arguments S _%nat_scope.

Fixpoint tail_add (m n: nat) : nat :=
  if m is S m' then tail_add m' (S n) else n.

Fixpoint tail_addmul (r m n: nat) : nat :=
  if m is S m' then tail_addmul (tail_add n r) m' n else r.

Definition tail_mul n m := tail_addmul O n m.

(** ** Conversion with a decimal representation for printing/parsing *)

Local Notation ten := (S (S (S (S (S (S (S (S (S (S O)))))))))).

Fixpoint of_uint_acc (d: decimal.uint) (acc: nat) :=
  match d with
  | decimal.Nil => acc
  | decimal.D0 d => of_uint_acc d (tail_mul ten acc)
  | decimal.D1 d => of_uint_acc d (S (tail_mul ten acc))
  | decimal.D2 d => of_uint_acc d (S (S (tail_mul ten acc)))
  | decimal.D3 d => of_uint_acc d (S (S (S (tail_mul ten acc))))
  | decimal.D4 d => of_uint_acc d (S (S (S (S (tail_mul ten acc)))))
  | decimal.D5 d => of_uint_acc d (S (S (S (S (S (tail_mul ten acc))))))
  | decimal.D6 d => of_uint_acc d (S (S (S (S (S (S (tail_mul ten acc)))))))
  | decimal.D7 d => of_uint_acc d (S (S (S (S (S (S (S (tail_mul ten acc))))))))
  | decimal.D8 d => of_uint_acc d (S (S (S (S (S (S (S (S (tail_mul ten acc)))))))))
  | decimal.D9 d => of_uint_acc d (S (S (S (S (S (S (S (S (S (tail_mul ten acc))))))))))
  end.

Definition of_uint (d: decimal.uint) := of_uint_acc d O.

Local Notation sixteen := (S (S (S (S (S (S (S (S (S (S (S (S (S (S (S (S O)))))))))))))))).

Fixpoint of_hex_uint_acc (d:hexadecimal.uint)(acc:nat) :=
  match d with
  | hexadecimal.Nil => acc
  | hexadecimal.D0 d => of_hex_uint_acc d (tail_mul sixteen acc)
  | hexadecimal.D1 d => of_hex_uint_acc d (S (tail_mul sixteen acc))
  | hexadecimal.D2 d => of_hex_uint_acc d (S (S (tail_mul sixteen acc)))
  | hexadecimal.D3 d => of_hex_uint_acc d (S (S (S (tail_mul sixteen acc))))
  | hexadecimal.D4 d => of_hex_uint_acc d (S (S (S (S (tail_mul sixteen acc)))))
  | hexadecimal.D5 d => of_hex_uint_acc d (S (S (S (S (S (tail_mul sixteen acc))))))
  | hexadecimal.D6 d => of_hex_uint_acc d (S (S (S (S (S (S (tail_mul sixteen acc)))))))
  | hexadecimal.D7 d => of_hex_uint_acc d (S (S (S (S (S (S (S (tail_mul sixteen acc))))))))
  | hexadecimal.D8 d => of_hex_uint_acc d (S (S (S (S (S (S (S (S (tail_mul sixteen acc)))))))))
  | hexadecimal.D9 d => of_hex_uint_acc d (S (S (S (S (S (S (S (S (S (tail_mul sixteen acc))))))))))
  | hexadecimal.Da d => of_hex_uint_acc d (S (S (S (S (S (S (S (S (S (S (tail_mul sixteen acc)))))))))))
  | hexadecimal.Db d => of_hex_uint_acc d (S (S (S (S (S (S (S (S (S (S (S (tail_mul sixteen acc))))))))))))
  | hexadecimal.Dc d => of_hex_uint_acc d (S (S (S (S (S (S (S (S (S (S (S (S (tail_mul sixteen acc)))))))))))))
  | hexadecimal.Dd d => of_hex_uint_acc d (S (S (S (S (S (S (S (S (S (S (S (S (S (tail_mul sixteen acc))))))))))))))
  | hexadecimal.De d => of_hex_uint_acc d (S (S (S (S (S (S (S (S (S (S (S (S (S (S (tail_mul sixteen acc)))))))))))))))
  | hexadecimal.Df d => of_hex_uint_acc d (S (S (S (S (S (S (S (S (S (S (S (S (S (S (S (tail_mul sixteen acc))))))))))))))))
  end.

Definition of_hex_uint (d:hexadecimal.uint) := of_hex_uint_acc d O.

Definition of_num_uint (d:number.uint) :=
  match d with
  | number.UIntDec d => of_uint d
  | number.UIntHex d => of_hex_uint d
  end.

Definition to_little_uint (n: nat) (acc: decimal.uint) : decimal.uint :=
  nat_rect acc (λ _, decimal.Little.succ) n.

Definition to_uint (n: nat) : decimal.uint :=
  decimal.rev (to_little_uint n decimal.zero).

Definition to_num_uint n := number.UIntDec (to_uint n).

Number Notation nat of_num_uint to_num_uint : nat_scope.

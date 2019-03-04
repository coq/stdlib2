(************************************************************************)
(*         *   The Coq Proof Assistant / The Coq Development Team       *)
(*  v      *   INRIA, CNRS and contributors - Copyright 1999-2018       *)
(* <O___,, *       (see CREDITS file for the list of authors)           *)
(*   \VV/  **************************************************************)
(*    //   *    This file is distributed under the terms of the         *)
(*         *     GNU Lesser General Public License Version 2.1          *)
(*         *     (see LICENSE file for the text of the license)         *)
(************************************************************************)

Require Import prelude ssreflect prop equality.

(** [unit] is a singleton datatype with sole inhabitant [tt] *)

Variant unit : Set :=
  tt : unit.

Lemma unitE : all_equal_to tt. Proof. by case. Qed.

(** [option A] is the extension of [A] with an extra element [None] *)

Variant option (A : Type) : Type :=
  | Some of A
  | None.

Arguments Some {A} _.
Arguments None {A}.

Register option as core.option.type.
Register Some as core.option.Some.
Register None as core.option.None.

Module Option.

Definition apply aT rT (f : aT -> rT) x u := if u is Some y then f y else x.

Definition default T := apply (fun x : T => x).

Definition bind aT rT (f : aT -> option rT) := apply f None.

Definition map aT rT (f : aT -> rT) := bind (fun x => Some (f x)).

End Option.

Notation oapp := Option.apply.
Notation odflt := Option.default.
Notation obind := Option.bind.
Notation omap := Option.map.
Notation some := (@Some _) (only parsing).

(** Inversion principles *)
Definition optionI A (oa oa': option A) (e: oa = oa') :
  if oa is Some a then if oa' is Some a' then a = a' else False else if oa' is Some _ then False else True
  :=
    let: eq_refl := e in
    if oa is Some a then eq_refl else I.

(** [prod A B], written [A * B], is the product of [A] and [B];
    the pair [pair A B a b] of [a] and [b] is abbreviated [(a,b)] *)

#[universes(template)]
Record prod (A B : Type) : Type :=
  pair { fst : A; snd : B }.

Arguments pair {A B} _ _.

Declare Scope pair_scope.
Delimit Scope pair_scope with PAIR.
Open Scope pair_scope.

Reserved Notation "x * y" (at level 40, left associativity).
Notation "x * y" := (prod x y) : type_scope.

Reserved Notation "( x , y , .. , z )" (at level 0).
Notation "( x , y , .. , z )" := (pair .. (pair x y) .. z) : pair_scope.

Notation "p .1" := (fst p)
  (at level 2, left associativity, format "p .1") : pair_scope.
Notation "p .2" := (snd p)
  (at level 2, left associativity, format "p .2") : pair_scope.

Coercion pair_of_and P Q (PandQ : P /\ Q) := (and_proj1 PandQ, and_proj2 PandQ).

Definition all_pair I T U (w : forall i : I, T i * U i) :=
  (fun i => (w i).1, fun i => (w i).2).

Definition prod_rect (A B: Type) (T: prod A B -> Type) (h: forall (a: A) (b: B), T (a, b)) p : T p :=
  let: (a, b) := p in h a b.

Register prod as core.prod.type.
Register pair as core.prod.intro.
Register prod_rect as core.prod.rect.

Register fst as core.prod.proj1.
Register snd as core.prod.proj2.

(** [(sig A P)], or more suggestively [{x:A | P x}], denotes the subset
    of elements of the type [A] which satisfy the predicate [P].
    Similarly [(sig2 A P Q)], or [{x:A | P x & Q x}], denotes the subset
    of elements of the type [A] which satisfy both [P] and [Q]. *)

Record sig (A : Type) (P : A -> Type) : Type :=
  exist { sig_proj1 : A;  sig_proj2 : P sig_proj1 }.

Arguments exist {A} _.

Record sig2 (A : Type) (P Q : A -> Type) : Type :=
  exist2 { sig2_proj1 : A; sig2_proj2 : P sig2_proj1; sig2_proj3 : Q sig2_proj1 }.

Arguments exist2 {A} _ _.

Reserved Notation "{ x  |  P }" (at level 0, x at level 99).
Reserved Notation "{ x  |  P  & Q }" (at level 0, x at level 99).

Reserved Notation "{ x : A  |  P }" (at level 0, x at level 99).
Reserved Notation "{ x : A  |  P  & Q }" (at level 0, x at level 99).

Notation "{ x  |  P }" := (sig (fun x => P)) : type_scope.
Notation "{ x  |  P  & Q }" := (sig2 (fun x => P) (fun x => Q)) : type_scope.
Notation "{ x : A  |  P }" := (sig (A:=A) (fun x => P)) : type_scope.
Notation "{ x : A  |  P  & Q }" := (sig2 (A:=A) (fun x => P) (fun x => Q)) :
  type_scope.

(** [sum A B], also noted [A + B] is the disjoint sum of datatypes [A] and [B]. *)
Variant sum A B : Type :=
| Left of A
| Right of B.

Infix "+" := sum (at level 50, left associativity) : type_scope.

Arguments Left {A B} _.
Arguments Right {A B} _.

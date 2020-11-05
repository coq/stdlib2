(************************************************************************)
(*         *   The Coq Proof Assistant / The Coq Development Team       *)
(*  v      *   INRIA, CNRS and contributors - Copyright 1999-2018       *)
(* <O___,, *       (see CREDITS file for the list of authors)           *)
(*   \VV/  **************************************************************)
(*    //   *    This file is distributed under the terms of the         *)
(*         *     GNU Lesser General Public License Version 2.1          *)
(*         *     (see LICENSE file for the text of the license)         *)
(************************************************************************)

(** * Decimal or Hexadecimal numbers *)

Require Import decimal hexadecimal.

Variant uint := UIntDec (u:decimal.uint) | UIntHex (u:hexadecimal.uint).

Variant int := IntDec (i:decimal.int) | IntHex (i:hexadecimal.int).

Variant number := Dec (d:decimal.decimal) | Hex (h:hexadecimal.hexadecimal).

Register uint as num.num_uint.type.
Register int as num.num_int.type.
Register number as num.number.type.

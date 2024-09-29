type proto = [ `ARP | `IPv4 | `IPv6 ]
val pp_proto: proto Fmt.t

type t = {
  source : Macaddr.t;
  destination : Macaddr.t;
  ethertype : proto;
}

val sizeof_ethernet : int

type error = string

val pp : Format.formatter -> t -> unit
val equal : t -> t -> bool

module Unmarshal : sig
  val of_bytes : Bytes.t -> ((t * Bytes.t), error) result
end

module Marshal : sig
  (** [into_bytes t buf] writes a 14-byte ethernet header representing
      [t.ethertype], [t.src_mac], and [t.dst_mac] to [buf] at offset 0.
      Returns [Ok ()] on success and [Error error] on failure.
      Currently, the only possibility for failure
      is a [buf] too small to contain the header; to avoid this, provide a
      buffer of size at least 14. *)
  val into_bytes : t -> Bytes.t -> (unit, error) result

  (** given a [t], construct and return an Ethernet header representing
      [t.ethertype], [t.source], and [t.destination].  [make_bytes] will allocate
      a new 14 bytes for the Ethernet header it returns. *)
  val make_bytes : t -> Bytes.t
end

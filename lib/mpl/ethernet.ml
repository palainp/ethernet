(* This file was autogenerated by MPL *)
open Mpl_stdlib
exception Bad_packet of string

module IPv6 = struct
  class o
    ~(data_length:int)
    (env:env) =
    object(self)
      method env = env_at env 0 self#sizeof
      method sizeof = data_length+2+6+6
      method dest_mac =
        Mpl_raw.at env (0) 6
      (* set_dest_mac unsupported for now (type byte array) *)
      method dest_mac_env : env = env_at env (0) 6
      method dest_mac_frag = Mpl_raw.frag env (0) 6
      method dest_mac_length = 6

      method src_mac =
        Mpl_raw.at env (6) 6
      (* set_src_mac unsupported for now (type byte array) *)
      method src_mac_env : env = env_at env (6) 6
      method src_mac_frag = Mpl_raw.frag env (6) 6
      method src_mac_length = 6


      method data =
        Mpl_raw.at env (6+6+2) data_length
      (* set_data unsupported for now (type byte array) *)
      method data_env : env = env_at env (6+6+2) data_length
      method data_frag = Mpl_raw.frag env (6+6+2) data_length
      method data_length = data_length

      method end_of_packet = 6+6+2+data_length


      method prettyprint =
        let out = prerr_endline in
        out "[ Ethernet.IPv6.ethernet ]";
        out ("  dest_mac = " ^ (Mpl_raw.prettyprint self#dest_mac));
        out ("  src_mac = " ^ (Mpl_raw.prettyprint self#src_mac));
        (* ethertype : bound *)
        out ("  data = " ^ (Mpl_raw.prettyprint self#data));
        (* end_of_packet : bound *)
        ()
    end

  let t
    ~(dest_mac:('a data))
    ~(src_mac:('a data))
    ~(data:('a data))
    env =
      let ___env = env_at env (0) 0 in
      let dest_mac___len = match dest_mac with 
      |`Str x -> Mpl_raw.marshal ___env x; String.length x
      |`Sub fn -> ignore(fn ___env); curpos ___env
      |`None -> 0
      |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
      let ___env = env_at env (6) 0 in
      let src_mac___len = match src_mac with 
      |`Str x -> Mpl_raw.marshal ___env x; String.length x
      |`Sub fn -> ignore(fn ___env); curpos ___env
      |`None -> 0
      |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
      let ___env = env_at env (6+6+2) 0 in
      let data___len = match data with 
      |`Str x -> Mpl_raw.marshal ___env x; String.length x
      |`Sub fn -> ignore(fn ___env); curpos ___env
      |`None -> 0
      |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
      let ethertype = (Mpl_uint16.of_int 34525) in (* const *)
      let dest_mac = dest_mac in
      let src_mac = src_mac in
      let data = data in
      skip env dest_mac___len;
      skip env src_mac___len;
      Mpl_uint16.marshal env ethertype;
      skip env data___len;
      new o
      ~data_length:data___len
      env

  let m (x:(env->o)) env = x env
  let sizeof (x:o) = x#sizeof
  let prettyprint (x:o) = x#prettyprint
  let env (x:o) = x#env
end

module ARP = struct
  type operation_t = [
    |`Request
    |`Reply
    |`Unknown of int
  ]

  let operation_marshal (a:operation_t) =
    match a with
    |`Request -> 1
    |`Reply -> 2
    |`Unknown x -> x

  let operation_unmarshal a : operation_t =
    match a with
    |1 -> `Request
    |2 -> `Reply
    |x -> `Unknown x

  let operation_to_string (a:operation_t) =
    match a with
    |`Request -> "Request"
    |`Reply -> "Reply"
    |`Unknown x -> Printf.sprintf "%d" x

  let operation_of_string s : operation_t option = match s with
    |"Request" -> Some `Request
    |"Reply" -> Some `Reply
    |_ -> None

  type plen_t = [
    |`IPv4
    |`Unknown of int
  ]

  let plen_marshal (a:plen_t) =
    match a with
    |`IPv4 -> 4
    |`Unknown x -> x

  let plen_unmarshal a : plen_t =
    match a with
    |4 -> `IPv4
    |x -> `Unknown x

  let plen_to_string (a:plen_t) =
    match a with
    |`IPv4 -> "IPv4"
    |`Unknown x -> Printf.sprintf "%d" x

  let plen_of_string s : plen_t option = match s with
    |"IPv4" -> Some `IPv4
    |_ -> None

  type ptype_t = [
    |`IPv4
    |`IPv6
    |`Unknown of int
  ]

  let ptype_marshal (a:ptype_t) =
    match a with
    |`IPv4 -> 2048
    |`IPv6 -> 34525
    |`Unknown x -> x

  let ptype_unmarshal a : ptype_t =
    match a with
    |2048 -> `IPv4
    |34525 -> `IPv6
    |x -> `Unknown x

  let ptype_to_string (a:ptype_t) =
    match a with
    |`IPv4 -> "IPv4"
    |`IPv6 -> "IPv6"
    |`Unknown x -> Printf.sprintf "%d" x

  let ptype_of_string s : ptype_t option = match s with
    |"IPv4" -> Some `IPv4
    |"IPv6" -> Some `IPv6
    |_ -> None

  class o
    (env:env) =
    object(self)
      method env = env_at env 0 self#sizeof
      method sizeof = 4+6+4+6+2+1+1+2+2+2+6+6
      method dest_mac =
        Mpl_raw.at env (0) 6
      (* set_dest_mac unsupported for now (type byte array) *)
      method dest_mac_env : env = env_at env (0) 6
      method dest_mac_frag = Mpl_raw.frag env (0) 6
      method dest_mac_length = 6

      method src_mac =
        Mpl_raw.at env (6) 6
      (* set_src_mac unsupported for now (type byte array) *)
      method src_mac_env : env = env_at env (6) 6
      method src_mac_frag = Mpl_raw.frag env (6) 6
      method src_mac_length = 6



      method ptype =
        let ptype = Mpl_uint16.to_int (Mpl_uint16.at env (6+6+2+2)) in
        ptype_unmarshal ptype
      method set_ptype v : unit =
        Mpl_uint16.marshal (env_at env (6+6+2+2) 2) (Mpl_uint16.of_int v)




      method plen =
        let __bitdummy0 = Mpl_byte.to_int (Mpl_byte.at env (6+6+2+2+2)) in
        let __bitdummy1 = Mpl_byte.to_int (Mpl_byte.at env (6+6+2+2+2+1)) in
        let plen = (__bitdummy1 lsl 0) in
        plen_unmarshal plen
      (* set_plen unsupported for now (type bit) *)

      method operation =
        let operation = Mpl_uint16.to_int (Mpl_uint16.at env (6+6+2+2+2+1+1)) in
        operation_unmarshal operation
      method set_operation v : unit =
        Mpl_uint16.marshal (env_at env (6+6+2+2+2+1+1) 2) (Mpl_uint16.of_int v)

      method sha =
        Mpl_raw.at env (6+6+2+2+2+1+1+2) 6
      (* set_sha unsupported for now (type byte array) *)
      method sha_env : env = env_at env (6+6+2+2+2+1+1+2) 6
      method sha_frag = Mpl_raw.frag env (6+6+2+2+2+1+1+2) 6
      method sha_length = 6

      method spa =
        Mpl_raw.at env (6+6+2+2+2+1+1+2+6) 4
      (* set_spa unsupported for now (type byte array) *)
      method spa_env : env = env_at env (6+6+2+2+2+1+1+2+6) 4
      method spa_frag = Mpl_raw.frag env (6+6+2+2+2+1+1+2+6) 4
      method spa_length = 4

      method tha =
        Mpl_raw.at env (6+6+2+2+2+1+1+2+6+4) 6
      (* set_tha unsupported for now (type byte array) *)
      method tha_env : env = env_at env (6+6+2+2+2+1+1+2+6+4) 6
      method tha_frag = Mpl_raw.frag env (6+6+2+2+2+1+1+2+6+4) 6
      method tha_length = 6

      method tpa =
        Mpl_raw.at env (6+6+2+2+2+1+1+2+6+4+6) 4
      (* set_tpa unsupported for now (type byte array) *)
      method tpa_env : env = env_at env (6+6+2+2+2+1+1+2+6+4+6) 4
      method tpa_frag = Mpl_raw.frag env (6+6+2+2+2+1+1+2+6+4+6) 4
      method tpa_length = 4

      method end_of_packet = 6+6+2+2+2+1+1+2+6+4+6+4


      method prettyprint =
        let out = prerr_endline in
        out "[ Ethernet.ARP.ethernet ]";
        out ("  dest_mac = " ^ (Mpl_raw.prettyprint self#dest_mac));
        out ("  src_mac = " ^ (Mpl_raw.prettyprint self#src_mac));
        (* ethertype : bound *)
        (* htype : bound *)
        out ("  ptype = " ^ (ptype_to_string self#ptype));
        (* __bitdummy0 : bound *)
        (* hlen : bound *)
        (* __bitdummy1 : bound *)
        out ("  plen = " ^ (plen_to_string self#plen));
        out ("  operation = " ^ (operation_to_string self#operation));
        out ("  sha = " ^ (Mpl_raw.prettyprint self#sha));
        out ("  spa = " ^ (Mpl_raw.prettyprint self#spa));
        out ("  tha = " ^ (Mpl_raw.prettyprint self#tha));
        out ("  tpa = " ^ (Mpl_raw.prettyprint self#tpa));
        (* end_of_packet : bound *)
        ()
    end

  let t
    ?(ptype=`IPv4)
    ?(plen=`IPv4)
    ?(operation=`Request)
    ~(dest_mac:('a data))
    ~(src_mac:('a data))
    ~(sha:('a data))
    ~(spa:('a data))
    ~(tha:('a data))
    ~(tpa:('a data))
    env =
      let ___env = env_at env (0) 0 in
      let dest_mac___len = match dest_mac with 
      |`Str x -> Mpl_raw.marshal ___env x; String.length x
      |`Sub fn -> ignore(fn ___env); curpos ___env
      |`None -> 0
      |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
      let ___env = env_at env (6) 0 in
      let src_mac___len = match src_mac with 
      |`Str x -> Mpl_raw.marshal ___env x; String.length x
      |`Sub fn -> ignore(fn ___env); curpos ___env
      |`None -> 0
      |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
      let ___env = env_at env (6+6+2+2+2+1+1+2) 0 in
      let sha___len = match sha with 
      |`Str x -> Mpl_raw.marshal ___env x; String.length x
      |`Sub fn -> ignore(fn ___env); curpos ___env
      |`None -> 0
      |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
      let ___env = env_at env (6+6+2+2+2+1+1+2+6) 0 in
      let spa___len = match spa with 
      |`Str x -> Mpl_raw.marshal ___env x; String.length x
      |`Sub fn -> ignore(fn ___env); curpos ___env
      |`None -> 0
      |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
      let ___env = env_at env (6+6+2+2+2+1+1+2+6+4) 0 in
      let tha___len = match tha with 
      |`Str x -> Mpl_raw.marshal ___env x; String.length x
      |`Sub fn -> ignore(fn ___env); curpos ___env
      |`None -> 0
      |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
      let ___env = env_at env (6+6+2+2+2+1+1+2+6+4+6) 0 in
      let tpa___len = match tpa with 
      |`Str x -> Mpl_raw.marshal ___env x; String.length x
      |`Sub fn -> ignore(fn ___env); curpos ___env
      |`None -> 0
      |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
      let hlen = 6 in (* const bit *)
      let plen = plen_marshal plen in
      let __bitdummy1 = Mpl_byte.of_int (plen) in
      let __bitdummy0 = Mpl_byte.of_int (hlen) in
      let ethertype = (Mpl_uint16.of_int 2054) in (* const *)
      let htype = (Mpl_uint16.of_int 1) in (* const *)
      let dest_mac = dest_mac in
      let src_mac = src_mac in
      let __ptype = ptype_marshal ptype in
      let __ptype = (Mpl_uint16.of_int __ptype) in
      let __operation = operation_marshal operation in
      let __operation = (Mpl_uint16.of_int __operation) in
      let sha = sha in
      let spa = spa in
      let tha = tha in
      let tpa = tpa in
      skip env dest_mac___len;
      skip env src_mac___len;
      Mpl_uint16.marshal env ethertype;
      Mpl_uint16.marshal env htype;
      Mpl_uint16.marshal env __ptype;
      Mpl_byte.marshal env __bitdummy0;
      (* bit hlen *)
      Mpl_byte.marshal env __bitdummy1;
      (* bit plen *)
      Mpl_uint16.marshal env __operation;
      skip env sha___len;
      skip env spa___len;
      skip env tha___len;
      skip env tpa___len;
      new o
      env

  let m (x:(env->o)) env = x env
  let sizeof (x:o) = x#sizeof
  let prettyprint (x:o) = x#prettyprint
  let env (x:o) = x#env
end

module IPv4 = struct
  class o
    ~(data_length:int)
    (env:env) =
    object(self)
      method env = env_at env 0 self#sizeof
      method sizeof = data_length+2+6+6
      method dest_mac =
        Mpl_raw.at env (0) 6
      (* set_dest_mac unsupported for now (type byte array) *)
      method dest_mac_env : env = env_at env (0) 6
      method dest_mac_frag = Mpl_raw.frag env (0) 6
      method dest_mac_length = 6

      method src_mac =
        Mpl_raw.at env (6) 6
      (* set_src_mac unsupported for now (type byte array) *)
      method src_mac_env : env = env_at env (6) 6
      method src_mac_frag = Mpl_raw.frag env (6) 6
      method src_mac_length = 6


      method data =
        Mpl_raw.at env (6+6+2) data_length
      (* set_data unsupported for now (type byte array) *)
      method data_env : env = env_at env (6+6+2) data_length
      method data_frag = Mpl_raw.frag env (6+6+2) data_length
      method data_length = data_length

      method end_of_packet = 6+6+2+data_length


      method prettyprint =
        let out = prerr_endline in
        out "[ Ethernet.IPv4.ethernet ]";
        out ("  dest_mac = " ^ (Mpl_raw.prettyprint self#dest_mac));
        out ("  src_mac = " ^ (Mpl_raw.prettyprint self#src_mac));
        (* ethertype : bound *)
        out ("  data = " ^ (Mpl_raw.prettyprint self#data));
        (* end_of_packet : bound *)
        ()
    end

  let t
    ~(dest_mac:('a data))
    ~(src_mac:('a data))
    ~(data:('a data))
    env =
      let ___env = env_at env (0) 0 in
      let dest_mac___len = match dest_mac with 
      |`Str x -> Mpl_raw.marshal ___env x; String.length x
      |`Sub fn -> ignore(fn ___env); curpos ___env
      |`None -> 0
      |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
      let ___env = env_at env (6) 0 in
      let src_mac___len = match src_mac with 
      |`Str x -> Mpl_raw.marshal ___env x; String.length x
      |`Sub fn -> ignore(fn ___env); curpos ___env
      |`None -> 0
      |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
      let ___env = env_at env (6+6+2) 0 in
      let data___len = match data with 
      |`Str x -> Mpl_raw.marshal ___env x; String.length x
      |`Sub fn -> ignore(fn ___env); curpos ___env
      |`None -> 0
      |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
      let ethertype = (Mpl_uint16.of_int 2048) in (* const *)
      let dest_mac = dest_mac in
      let src_mac = src_mac in
      let data = data in
      skip env dest_mac___len;
      skip env src_mac___len;
      Mpl_uint16.marshal env ethertype;
      skip env data___len;
      new o
      ~data_length:data___len
      env

  let m (x:(env->o)) env = x env
  let sizeof (x:o) = x#sizeof
  let prettyprint (x:o) = x#prettyprint
  let env (x:o) = x#env
end

type o = [
|`IPv4 of IPv4.o
|`ARP of ARP.o
|`IPv6 of IPv6.o
]

type x = [
|`IPv4 of (env -> IPv4.o)
|`ARP of (env -> ARP.o)
|`IPv6 of (env -> IPv6.o)
]

let m (x:x) env : o = match x with
|`IPv4 (fn:(env->IPv4.o)) -> `IPv4 (fn env)
|`ARP (fn:(env->ARP.o)) -> `ARP (fn env)
|`IPv6 (fn:(env->IPv6.o)) -> `IPv6 (fn env)

let prettyprint (x:o) = match x with
|`IPv4 x -> x#prettyprint
|`ARP x -> x#prettyprint
|`IPv6 x -> x#prettyprint

let sizeof (x:o) = match x with
|`IPv4 x -> x#sizeof
|`ARP x -> x#sizeof
|`IPv6 x -> x#sizeof

let env (x:o) = match x with
|`IPv4 x -> x#env
|`ARP x -> x#env
|`IPv6 x -> x#env


let unmarshal 
  (env:env) : o =
  skip env 6; (* skipped dest_mac *)
  skip env 6; (* skipped src_mac *)
  let ethertype = Mpl_uint16.unmarshal env in
  match (Mpl_uint16.to_int ethertype) with
  |34525 -> `IPv6 (
    let data_length = (remaining env) in
    skip env data_length; (* skipped data *)
    skip env 0; (* skipped end_of_packet *)
    new IPv6.o env
    ~data_length:data_length
  )
  |2054 -> `ARP (
    skip env 2; (* skipped htype *)
    skip env 2; (* skipped ptype *)
    skip env 1; (* skipped __bitdummy0 *)
    skip env 1; (* skipped __bitdummy1 *)
    skip env 2; (* skipped operation *)
    skip env 6; (* skipped sha *)
    skip env 4; (* skipped spa *)
    skip env 6; (* skipped tha *)
    skip env 4; (* skipped tpa *)
    skip env 0; (* skipped end_of_packet *)
    new ARP.o env
  )
  |2048 -> `IPv4 (
    let data_length = (remaining env) in
    skip env data_length; (* skipped data *)
    skip env 0; (* skipped end_of_packet *)
    new IPv4.o env
    ~data_length:data_length
  )
  |x -> raise (Bad_packet (Printf.sprintf ": %d" x))

(* "svgjs": "^2.6.2" *)

module rec Line:
sig
  type param_t = {
      width: int [@bs.optional]; (** should be "bubble" *)
      color: string [@bs.optional];
      opacity: float [@bs.optional];
    } [@@bs.deriving {abstract = light}]
         
  (* type param_t = *)
  (*   | URL of string *)
  (*   | Color of string *)
  (*   | Spec of spec_param_t *)

  class type _line =
    object
      method stroke: param_t -> Line.t
    end [@bs]
  type t = _line Js.t
end = Line

module rec SVG:
sig
  class type _svg =
    object
      method nested: unit -> SVG.t
      method line: int -> int -> int -> int -> Line.t
      (* TDOO: precent *)
      method size: int -> int -> SVG.t
    end [@bs]

  external svg: string -> SVG.t = "SVG"  [@@bs.module "svgjs"]
  type t = _svg Js.t
end = SVG

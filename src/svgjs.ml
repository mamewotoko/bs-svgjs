(* "svgjs": "^2.6.2" *)

(* element.js *)
module rec SVGElement:
sig
  class type ['a] _svgelement =
    object
      method x: int [@@bs.get]
      method y: int [@@bs.get]
      method cx: int [@@bs.get]
      method cy: int [@@bs.get]
      (* TODO: return original object, not t *)
      method move: int -> int -> 'a
      method center: int -> int -> 'a
      method width: int [@@bs.get]
      method height: int [@@bs.get]
      method size: int -> int -> 'a
    end [@bs]
  type 'a t = 'a _svgelement Js.t
end = SVGElement
  
module rec Line:
sig
  type param_t = {
      width: int [@bs.optional];
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

module rec Text:
sig
  type font_param_t = {
      fill: string [@bs.optional];
      size: int [@bs.optional];
      anchor: string [@bs.optional]; (* start | middle | end *)
      family: string [@bs.optional];
      weight: string [@bs.optional];
      stretch: string [@bs.optional];
      variant: string [@bs.optional];
      style: string [@bs.optional];
    } [@@bs.deriving {abstract = light}]
               
  class type _text =
    object
      (* inherit [Text.t] SVGElement._svgelement *)
      method build: string -> Text.t
      method clear: unit -> Text.t
      method length: unit -> int
      method font: font_param_t -> Text.t
      method move: int -> int -> Text.t
      (* method set_font: unit ->  *)
    end [@bs]
  type t = _text Js.t
end = Text

module rec SVG:
sig
  class type _svg =
    object
      inherit [SVG.t] SVGElement._svgelement
      method nested: unit -> SVG.t
      method line: int -> int -> int -> int -> Line.t
      method text: string -> Text.t
      (* TDOO: precent *)
      (* method size: int -> int -> SVG.t *)
    end [@bs]
  type t = _svg Js.t
  external svg: string -> SVG.t = "SVG"  [@@bs.module "svgjs"]
end = SVG

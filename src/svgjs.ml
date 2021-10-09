(* svgjs: 3.1.1 *)

module rec SVGElement:
sig
  type param_t = {
      width: int [@bs.optional];
      color: string [@bs.optional];
      opacity: float [@bs.optional];
    } [@@bs.deriving {abstract = light}]

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
      (* TODO: cx, cy are optional *)
      method rotate: degree:float -> int -> int -> 'a
      method scale: float -> float -> int -> int -> 'a
      method translate: int -> int -> 'a
      method skew: int -> int -> int -> int -> 'a
      method opacity: float -> 'a
      method dx: int -> 'a
      method dy: int -> 'a
      method dmove: int -> int -> 'a
      method remove: unit -> 'a
      (* method addTo: parent:SVGElement.t *)
      method id: string -> 'a
      method show: unit -> 'a
      method hide: unit -> 'a
      method visible: unit -> bool
      (* TODO: url or callback *)
      method linkTo: url:string -> 'a
      method fill: color:string -> 'a
      method addTo: 'a -> 'a
      method hasClass: string -> bool
      method addClass: string -> 'a
      method removeClass: string -> 'a
      method toggleClass: string -> 'a
      (* TODO *)
      (* method matches: selector:string -> 'b SVGElement.t *)
      (* method classes *)
      (* check *)
      method stroke: param_t -> 'a
                                  (*TODO: toString *)

    end [@bs]
  type 'a t = 'a _svgelement Js.t
end = SVGElement

module rec Image:
sig
  class type _image =
    object
      inherit [Image.t] SVGElement._svgelement
    end [@bs]
  type t = _image Js.t
end = Image

module rec Line:
sig
  class type _line =
    object
      inherit [Line.t] SVGElement._svgelement
                       (* TODO: method plot *)
                       (* TODO: method array *)

    end [@bs]
  type t = _line Js.t
end = Line

(* polyline *)
module rec Polyline:
sig
  class type _polyline =
    object
      inherit [Polyline.t] SVGElement._svgelement
      method clear: unit -> Polyline.t
      method plot: string -> Polyline.t
    end [@bs]
  type t =  _polyline Js.t
end = Polyline

(* polygon *)
module rec Polygon:
sig
  class type _polygon =
    object
      inherit [Polygon.t] SVGElement._svgelement
      method clear: unit -> Polygon.t
      method length: unit -> int
      method plot: string -> Polygon.t
    end [@bs]
  type t =  _polygon Js.t
end = Polygon

(* path *)
module rec Path:
sig
  class type _path =
    object
      inherit [Path.t] SVGElement._svgelement
      method clear: unit -> Path.t
      method length: unit -> int
      method plot: string -> Path.t
    end [@bs]
  type t =  _path Js.t
end = Path

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
      inherit [Text.t] SVGElement._svgelement
      method build: string -> Text.t
      method clear: unit -> Text.t
      method length: unit -> int
      method font: font_param_t -> Text.t
      (* method set_font: unit ->  *)
    end [@bs]
  type t = _text Js.t
end = Text

module rec Rect:
sig
  class type _rect =
    object
      inherit [Rect.t] SVGElement._svgelement
      method radius: int -> Rect.t
    end [@bs]
  type t = _rect Js.t
end = Rect

module rec Circle:
sig
  class type _circle =
    object
      inherit [Circle.t] SVGElement._svgelement
      method radius: int -> Circle.t
    end [@bs]
  type t = _circle Js.t
end = Circle

module rec Ellipse:
sig
  class type _ellipse =
    object
      inherit [Ellipse.t] SVGElement._svgelement
      method radius: int -> int -> Ellipse.t
    end [@bs]
  type t = _ellipse Js.t
end = Ellipse

module rec A:
sig
  class type _a =
    object
      inherit [A.t] SVGElement._svgelement
      method target: string -> A.t
      method text: string -> Text.t
      method image: path:string -> width:int -> height:int -> Image.t
    end [@bs]
  type t = _a Js.t
end = A

(* module rec G: *)
(*   class type _g = *)
(*     object *)
(*       method add: SVG.t -> SVG.t *)
(*     end [@bs] *)
(*   type t = _g Js.t *)
(* end = G *)

(* TODO; defs *)
(* element.js *)
module rec SVG:
sig
  class type _svg =
    object
      method size: width:int -> height:int -> 'a
      method nested: unit -> SVG.t
      (* TODO; result type should be group*)
      method group: unit -> SVG.t

      method line: from_x:int -> from_y:int -> to_x:int -> to_y:int -> Line.t
      method rect: width:int -> height:int -> Rect.t
      method circle: radius:int -> Circle.t
      method ellipse: radius_x:int -> radius_y:int -> Ellipse.t
      method path: path:string -> Path.t
      method polyline: path:string -> Polygon.t
      method polygon: path:string -> Polygon.t
      method text: string -> Text.t
      method image: path:string -> width:int -> height:int -> Image.t
      method link: url:string -> A.t
    end [@bs]
  type t = _svg Js.t
  external svg: string -> SVG.t = "SVG"  [@@bs.module "svgjs"]
end = SVG

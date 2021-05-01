open Svgjs
open Webapi

(*
https://web.archive.org/web/20140122124421/http:/ensign.editme.com/t43dances

Usage:
opam install -y labltk

 *)

type planet_t =
  | Mercury
  | Venus
  | Earth
  | Mars
  | Jupiter
  | Saturn
  | Uranus
  | Neptune
  | Pluto
;;

let year = function
  | Mercury -> 87.969
  | Venus -> 224.701
  | Earth -> 365.256
  | Mars -> 686.980
  | Jupiter -> 4332.6
  | Saturn -> 10759.2
  | Uranus -> 30685.
  | Neptune -> 60190.
  | Pluto -> 90465.
;;

let orbit = function
  | Mercury -> 57.91
  | Venus -> 108.21
  | Earth -> 149.60
  | Mars -> 227.92
  | Jupiter -> 778.57
  | Saturn -> 1433.5
  | Uranus -> 2872.46
  | Neptune -> 4495.1
  | Pluto -> 5869.7
;;

let name = function
  | Mercury -> "Mercury"
  | Venus -> "Venus"
  | Earth -> "Earth"
  | Mars -> "Mars"
  | Jupiter -> "Jupiter"
  | Saturn -> "Saturn"
  | Uranus -> "Uranus"
  | Neptune -> "Neptune"
  | Pluto -> "Pluto"
;;

(* let draw_caption outer_planet inner_planet orbits =
 *   let outer_planet_name = name outer_planet in
 *   let inner_planet_name = name inner_planet in
 *   let orbit_text = Printf.sprintf "%.0f" orbits in
 *   draw_text 10 10 *)
let canvas_len = 400
let pi = 4.0 *. atan 1.0

let black = `Color "#000000"
let blue = `Color "#0000FF"
let red = `Color "#FF0000"
let green = `Color "#00FF00"
let purple = `Color "#800080"
let maroon = `Color "#800000"
let navy = `Color "#8B0000"
let dark_red = `Color "#8B0000"
let orange = `Color "#FFA500"

let draw_text draw color x y txt =
  draw ## text txt
       ## move x y
       ## font (Text.font_param_t ~fill:color ())
;;
           
let draw_line draw color from_x from_y to_x to_y =
  (draw ## line from_x from_y to_x to_y)
    ## stroke (Line.param_t ~width:1 ~color:color ())
;;

let draw_main (draw : SVG.t) outer_planet inner_planet orbits =
  let outer_planet_year = year outer_planet in
  let inner_planet_year = year inner_planet in
  let outer_planet_radius = orbit outer_planet in
  let inner_planet_radius = orbit inner_planet in
  let interval_days = outer_planet_year /. 75. in
  let ycenter = float_of_int (canvas_len / 2) in
  let xcenter = float_of_int (canvas_len / 2) in
  (* outer radius *)
  let r1 = ycenter in 
  let r2 = r1 *. inner_planet_radius /. outer_planet_radius in
  let r = ref 0. in
  let rstop = outer_planet_year *. orbits in
  let a1 = ref 0. in
  let a1_interval = 2. *. pi *. interval_days /. outer_planet_year in
  let a2 = ref 0. in
  let a2_interval = 2. *. pi *. interval_days /. inner_planet_year in
  (* wait until q key is pressed*)
  (* draw text *)
  let outer_planet_name = name outer_planet in
  let inner_planet_name = name inner_planet in

  begin
    let orbit_text = Printf.sprintf "%.0f orbits" orbits in
    let f = Text.font_param_t ~fill:"#0000FF" () in
    (draw ## image ~path:"image/favicon-32x32.png" ~width:32 ~height:32) ## move (canvas_len - 32) 0 |> ignore;
    (((draw ## text outer_planet_name) ## move 10 20) ## font f) ## rotate ~degree:~-.20. 10 10 |> ignore;
    ((draw ## text inner_planet_name) ## move 10 40) ## font f |> ignore;
    ((draw ## text orbit_text) ## move 10 (canvas_len - 20)) ## font f |> ignore;
    ((draw ## link ~url:"http://mamewo.ddo.jp/") ## text "link") ## move (canvas_len - 50) 30 |> ignore;
    ((draw ## text orbit_text) ## move 10 (canvas_len - 20)) ## font f |> ignore;
    
    (* draw_text draw "blue" 30 20 outer_planet_name; *)
    (* draw_text draw "blue" 30 40 inner_planet_name; *)
    (* draw_text draw "blue" 30 (canvas_len - 20) orbit_text; *)
    while !r < rstop do
      let i = int_of_float (floor (!r /. interval_days /. 75.)) in
      let color = 
        if i = 0 then "#000000"
        else if i = 1 then "#0000FF"
        else if i = 2 then "#FF0000"
        else if i = 3 then "#00FF00"
        else if i = 4 then "#800080"
        else if i = 5 then "#800000"
        else if i = 6 then "#8B0000"
        else if i = 7 then "#8B0000"
        else "#FFA500" in
      begin
        a1 := !a1 -. a1_interval;
        a2 := !a2 -. a2_interval;
        let x1 = r1 *. cos !a1 in
        let y1 = r1 *. sin !a1 in
        let x2 = r2 *. cos !a2 in
        let y2 = r2 *. sin !a2 in
        ignore @@ draw_line draw color
          (int_of_float (x1 +. xcenter)) (int_of_float (y1 +. ycenter))
          (int_of_float (x2 +. xcenter)) (int_of_float (y2 +. ycenter));
        r := !r +. interval_days;
      end;
    done;
  end
;;

let main () =
  let draw = SVG.svg "target" in
  draw ## size ~width:canvas_len ~height:canvas_len
  |> ignore;
  draw_main draw Earth Venus 8.
  |> ignore;
;;

let _ =
  Dom.window
  |> Dom.Window.asEventTarget
  |> Dom.EventTarget.addLoadEventListener (fun _ -> main ())
;;

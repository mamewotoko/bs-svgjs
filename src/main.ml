open Svgjs
open Webapi

let main () =
  let draw = SVG.svg "target" in
  Js.log "size";
  draw ## size 400 400
  |> ignore ;
  Js.log "line";
  let line = draw ## line 0 0 400 400 in
  line ## stroke (Line.param_t
                    ~width: 2
                    ())
  |> ignore;
  ()
;;       
                       
let _ =
  Dom.window
  |> Dom.Window.asEventTarget
  |> Dom.EventTarget.addLoadEventListener (fun _ -> main ())
;;

module type AI = sig
  type t
  val step : t -> t
end

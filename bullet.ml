module Bot = struct 
  type t = int      (* can change this later *)
end

module MakeBullet (B : Bot) = struct
  type bot = B.t

  type t = {
    xPos : float;
    yPos : float;
    xVel : float;
    yVel : float;
    speed : float;
    owner : B.t;
  }

  let getPosition t =
    (t.xPos, t.yPos)

  let getVelocity t =
    (t.xVel, t.yVel)

  let getSpeed t =
    t.speed

  let getOwner t =
    t.owner

  let make (xPos,yPos) (xVel,yVel) bot = {
    xPos = xPos;
    yPos = yPos;
    xVel = xVel;
    yVel = yVel;
    speed = 0;
    owner = bot;
  }
    
  let step t = {
    xPos = t.xPos+t.xVel;
    yPos = t.yPos+t.yVel;
    xVel = t.xVel;
    yVel = t.yVel;
    speed = t.speed;
    owner = t.owner;    
  }

end

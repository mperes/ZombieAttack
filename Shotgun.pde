class Shotgun extends Weapon{

  Shotgun() {
    //:    Name,   Damage, Range, Max Ammo
    super("shotgun", 1.0, 200.0, 15);
  }
  
  void fire(float x, float y, float direction) {
    if(currentAmmo > 0) {
      currentAmmo--;
      fx_fire.trigger();
      bullets.add(new Bullet(x, y, direction, this.range));
      bullets.add(new Bullet(x, y, direction+(TWO_PI/120), this.range));
      bullets.add(new Bullet(x, y, direction-(TWO_PI/120), this.range));
      println("boom!");
    } else {
      fx_jammed.trigger();
      println("Reload!");
    }
  }
}

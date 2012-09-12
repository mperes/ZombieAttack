class Shotgun extends Weapon{

  Shotgun(String name, float damage, float range, int ammo) {
    super("shotgun", 1.0, 10.0, 15);
  }
  
  void fire(float x, float y, float direction) {
    if(currentAmmo > 0) {
      currentAmmo--;
      fx_fire.trigger();
      bullets.add(new Bullet(x, y, direction));
      bullets.add(new Bullet(x, y, direction+(TWO_PI/120)));
      bullets.add(new Bullet(x, y, direction-(TWO_PI/120)));
      println("boom!");
    } else {
      fx_jammed.trigger();
      println("Reload!");
    }
  }
}

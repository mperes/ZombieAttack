class Weapon {
  
  String name;
  float damage;
  float range;
  int ammo;
  int currentAmmo;
  ArrayList<Bullet> bullets;
  AudioSample fx_fire;
  AudioSample fx_jammed;
  AudioSample fx_reload;
  
  Weapon(String name, float damage, float range, int ammo) {
    this.name = name;
    this.damage = damage;
    this.range = range;
    this.ammo = ammo;
    this.currentAmmo = ammo;
    bullets = new ArrayList<Bullet>();
    this.fx_fire = minim.loadSample(SOUNDFXPATH+name+"_fire.wav", 2048);
    this.fx_jammed = minim.loadSample(SOUNDFXPATH+name+"_jammed.wav", 2048);
    this.fx_reload = minim.loadSample(SOUNDFXPATH+name+"_reload.wav", 2048);
  }
  
  void fire(float x, float y, float direction) {
    if(currentAmmo > 0) {
      currentAmmo--;
      fx_fire.trigger();
      bullets.add(new Bullet(x, y, direction, this.range));
      println("boom!");
    } else {
      fx_jammed.trigger();
      println("Reload!");
    }
  }
  void reload() {
      currentAmmo = ammo;
      fx_reload.trigger();
      println("Reloaded!");
  }
}

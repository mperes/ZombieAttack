class Weapon {
  
  String name;
  float damage;
  float range;
  int ammo;
  int currentAmmo;
  ArrayList<Bullet> bullets;
  AudioSample fx_fire;
  AudioSample fx_hit;
  AudioSample fx_jammed;
  AudioSample fx_reload;
  
  Weapon(String name, float damage, float range, int ammo) {
    this.name = name;
    this.damage = damage;
    this.range = range;
    this.ammo = ammo;
    this.currentAmmo = ammo;
    bullets = new ArrayList<Bullet>();
    this.fx_fire = minim.loadSample(SOUNDFXPATH+name+"_fire.wav", SOUNDBUFFERSIZE);
    this.fx_hit = minim.loadSample(SOUNDFXPATH+name+"_hit.wav", SOUNDBUFFERSIZE);
    this.fx_jammed = minim.loadSample(SOUNDFXPATH+name+"_jammed.wav", SOUNDBUFFERSIZE);
    this.fx_reload = minim.loadSample(SOUNDFXPATH+name+"_reload.wav", SOUNDBUFFERSIZE);
  }
  
  void fire(float x, float y, float direction) {
    if(currentAmmo > 0) {
      currentAmmo--;
      fx_fire.trigger();
      bullets.add(new Bullet(x, y, direction, this.range));
    } else {
      fx_jammed.trigger();
    }
  }
  void reload() {
      currentAmmo = ammo;
      fx_reload.trigger();
  }
}

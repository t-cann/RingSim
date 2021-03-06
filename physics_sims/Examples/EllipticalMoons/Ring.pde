/**Class Ring
 * @author Thomas Cann
 * @version 1.0
 */
class Ring {

  ArrayList<RingParticle> particles;
  float r_inner, r_outer;
  color c;

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  Ring(float Inner, float Outer, int n_particles) {
    particles = new ArrayList<RingParticle>();
    for (int i = 0; i < n_particles; i++) {
      particles.add(new RingParticle(Inner, Outer));
    }
  }
  void update(ArrayList<Moon> m) {
    for (RingParticle p : particles) {
      p.update(m);
    }
  }
  void display() {
    for (RingParticle p : particles) {
      p.display();
    }
  }
  void render(PGraphics x) {
    for (RingParticle p : particles) {
      p.render(x);
    }
  }
}

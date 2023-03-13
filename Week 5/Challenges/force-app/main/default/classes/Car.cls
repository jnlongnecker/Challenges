public class Car extends Vehicle {
  public Integer steeringRotation {
    get;
    set {
      if (value < -1440) {
        value = -1440;
      }
      if (value > 1440) {
        value = 1440;
      }
      steeringRotation = value;
    }
  }

  public Integer tireRotation {
    get;
    private set {
      if (value < -90) {
        value = -90;
      }
      if (value > 90) {
        value = 90;
      }
      tireRotation = value;
    }
  }

  public Integer gear { get; private set; }

  public Car() {
    super();
    setup();
  }

  public Car(Integer speed) {
    super(speed);
    setup();
  }

  public Car(Integer speed, Integer occupant) {
    super(speed, occupant);
    setup();
  }

  public Car(Integer speed, Integer occupants, String name) {
    super(speed, occupants, name);
    setup();
  }

  public Car(Integer speed, Integer occupants, String name, Integer capacity) {
    super(speed, occupants, name, capacity);
    setup();
  }

  private void setup() {
    steeringRotation = 0;
    tireRotation = 0;
    media.add(Medium.LAND);
  }

  public override void turn(Integer amountInDegrees) {
    steeringRotation += amountInDegrees;
    tireRotation += Math.round(amountInDegrees * 0.0625);
  }

  public override void accelerate(Double amount) {
    super.accelerate(amount);

    gear = (Integer) Math.ceil(0.4444 * (Math.sqrt(Speed)));
  }
}

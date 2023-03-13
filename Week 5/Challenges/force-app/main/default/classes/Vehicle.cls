public abstract class Vehicle {
  public enum Medium {
    LAND,
    AIR,
    WATER
  }

  public Double speed {
    get;
    private set {
      if (value < 0) {
        value = 0;
      }
      speed = value;
    }
  }

  public String name { get; private set; }
  public Integer occupants {
    get;
    set {
      if (value < 0) {
        value = 0;
      }

      occupants = 0;
    }
  }

  public final Integer CAPACITY {
    get;
    set {
      if (value < 1) {
        value = 1;
      }
      CAPACITY = value;
    }
  }

  protected List<Medium> media;

  public Vehicle() {
    this(0);
  }

  public Vehicle(Integer speed) {
    this(speed, 0);
  }

  public Vehicle(Integer speed, Integer occupants) {
    this(speed, occupants, 'Unnamed');
  }

  public Vehicle(Integer speed, Integer occupants, String name) {
    this(speed, occupants, name, 1);
  }

  public Vehicle(
    Integer speed,
    Integer occupants,
    String name,
    Integer capacity
  ) {
    this.speed = speed;
    this.occupants = occupants;
    this.name = name;
    this.CAPACITY = capacity;
  }

  public virtual void accelerate(Double amount) {
    speed += amount;
  }

  public abstract void turn(Integer amountInDegrees);

  public override String toString() {
    String output = '';
    output += 'Speed: ' + speed;
    output += ', Name: ' + name;
    output += ', Occupants: ' + occupants;
    if (media.isEmpty()) {
      return output;
    }

    output += ', Media: ';
    String mediaString = '';
    for (Medium m : media) {
      mediaString += m + ', ';
    }

    mediaString = mediaString.substring(mediaString.length() - 3);
    output += mediaString;

    return output;
  }
}

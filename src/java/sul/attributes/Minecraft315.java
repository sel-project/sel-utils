// This file has been automatically generated by sel-utils
// https://github.com/sel-project/sel-utils
package sul.attributes;

public enum Minecraft315 {

	ABSORPTION("generic.absorption", 0, 4, 0);

	MAX_HEALTH("generic.maxHealth", 0, 1024, 20);

	SPEED("generic.movementSpeed", 0, 24791, 0.1);

	KNOCKBACK_RESISTANCE("generic.knockbackResistance", 0, 1, 0);

	public final String name;
	public final float min, max, def;

	Minecraft315(String name, float min, float max, float def) {
		this.name = name;
		this.min = min;
		this.max = max;
		this.def = def;
	}

}

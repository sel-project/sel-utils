/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft110.xml
 */
package sul.protocol.minecraft110.clientbound;

import java.util.UUID;

import sul.protocol.minecraft110.types.*;
import sul.utils.*;

class Particle extends Packet {

	public final static int ID = (int)34;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	// particle id
	public static immutable int EXPLODE = 0;
	public static immutable int LARGE_EXPLOSION = 1;
	public static immutable int HUGE_EXPLOSION = 2;
	public static immutable int FIREWORK_SPARK = 3;
	public static immutable int BUBBLE = 4;
	public static immutable int SPLASH = 5;
	public static immutable int WAKE = 6;
	public static immutable int SUSPENDED = 7;
	public static immutable int DEPTH_SUSPEND = 8;
	public static immutable int CRIT = 9;
	public static immutable int MAGIC_CRIT = 10;
	public static immutable int SMOKE = 11;
	public static immutable int LARGE_SMOKE = 12;
	public static immutable int SPELL = 13;
	public static immutable int INSTANT_SPELL = 14;
	public static immutable int MOB_SPELL = 15;
	public static immutable int MOB_SPELL_AMBIENT = 16;
	public static immutable int WITCH_MAGIC = 17;
	public static immutable int DRIP_WATER = 18;
	public static immutable int DRIP_LAVA = 19;
	public static immutable int ANGRY_VILLAGER = 20;
	public static immutable int HAPPY_VILLAGER = 21;
	public static immutable int TOWN_AURA = 22;
	public static immutable int NOTE = 23;
	public static immutable int PORTAL = 24;
	public static immutable int ENCHANTMENT_TABLE = 25;
	public static immutable int FLAME = 26;
	public static immutable int LAVA = 27;
	public static immutable int FOOTSTEP = 28;
	public static immutable int CLOUD = 29;
	public static immutable int RED_DUST = 30;
	public static immutable int SNOWBALL_POOF = 31;
	public static immutable int SNOW_SHOVEL = 32;
	public static immutable int SLIME = 33;
	public static immutable int HEART = 34;
	public static immutable int BARRIER = 35;
	public static immutable int ITEM_CRACK = 36;
	public static immutable int BLOCK_CRACK = 37;
	public static immutable int BLOCK_DUST = 38;
	public static immutable int DROPLET = 39;
	public static immutable int TAKE = 40;
	public static immutable int MOB_APPEARANCE = 41;
	public static immutable int DRAGON_BREATH = 42;
	public static immutable int ENDROD = 43;
	public static immutable int DAMAGE_INDICATOR = 44;
	public static immutable int SWEEP_ATTACK = 45;

	public int particleId;
	public boolean longDistance;
	public Tuples.FloatXYZ position;
	public Tuples.FloatXYZ offset;
	public float data;
	public int count;
	public int[2] additionalData;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeIntB(particleId);
		this.writeBoolB(longDistance);
		this.writeFloatB(position.x);this.writeFloatB(position.y);this.writeFloatB(position.z);
		this.writeFloatB(offset.x);this.writeFloatB(offset.y);this.writeFloatB(offset.z);
		this.writeFloatB(data);
		this.writeIntB(count);
		for(varuint YWRkaXRpb25hbERh:additionalData){ this.writeVaruint(YWRkaXRpb25hbERh); }
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}

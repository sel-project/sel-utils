/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft109.xml
 */
package sul.protocol.minecraft109.clientbound;

import java.util.UUID;

import sul.protocol.minecraft109.types.*;
import sul.utils.*;

class Effect extends Packet {

	public final static int ID = (int)33;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	// effect id
	public static immutable int DISPENSER_DISPENSE = 1000;
	public static immutable int DISPENSER_FAIL_DISPENSE = 1001;
	public static immutable int DISPENSER_SHOOT = 1002;
	public static immutable int ENDER_EYE_LAUNCH = 1003;
	public static immutable int FIREWORK_SHOT = 1004;
	public static immutable int IRON_DOOR_OPEN = 1005;
	public static immutable int WOODEN_DOOR_OPEN = 1006;
	public static immutable int WOODEN_TRAPDOOR_OPEN = 1007;
	public static immutable int FENCE_GATE_OPEN = 1008;
	public static immutable int FIRE_EXTINGUISH = 1009;
	public static immutable int PLAY_RECORD = 1010;
	public static immutable int IRON_DOOR_CLOSE = 1011;
	public static immutable int WOODEN_DOOR_CLOSE = 1012;
	public static immutable int WOODEN_TRAPDOOR_CLOSE = 1013;
	public static immutable int FENCE_GATE_CLOSE = 1014;
	public static immutable int GHAST_WARN = 1015;
	public static immutable int GHAST_SHOOT = 1016;
	public static immutable int ENDERDRAGON_SHOOT = 1017;
	public static immutable int BLAZE_SHOOT = 1018;
	public static immutable int ZOMBIE_ATTACK_WOOD_DOOR = 1019;
	public static immutable int ZOMBIE_ATTACK_IRON_DOOR = 1020;
	public static immutable int ZOMBIE_BREAK_WOOD_DOOR = 1021;
	public static immutable int WITHER_BREAK_BLOCK = 1022;
	public static immutable int WITHER_SPAWN = 1023;
	public static immutable int WITHER_SHOOT = 1024;
	public static immutable int BAT_TAKE_OFF = 1025;
	public static immutable int ZOMBIE_INFECT_VILLAGER = 1026;
	public static immutable int ZOMBIE_VILLAGER_CONVERT = 1027;
	public static immutable int ENDER_DRAGON_BREATH = 1028;
	public static immutable int ANVIL_BREAK = 1029;
	public static immutable int ANVIL_USE = 1030;
	public static immutable int ANVIL_LAND = 1031;
	public static immutable int PORTAL_TRAVEL = 1032;
	public static immutable int CHORUS_FLOWER_GROW = 1033;
	public static immutable int CHORUS_FLOWER_DIE = 1034;
	public static immutable int BREWING_STAND_BREW = 1035;
	public static immutable int IRON_TRAPDOOR_OPEN = 1036;
	public static immutable int IRON_TRAPDOOR_CLOSE = 1037;
	public static immutable int SPAWN_10_SMOKE_PARTICLES = 2000;
	public static immutable int BREAK_BREAK_PARTICLES_AND_SOUND = 2001;
	public static immutable int SPLASH_POTION_PARTICLES_AND_SOUND = 2002;
	public static immutable int ENDER_EYE_BREAK_PARTICLES_AND_SOUND = 2003;
	public static immutable int MOB_SPAWN_PARTICLES = 2004;
	public static immutable int BONEMEAL_PARTICLES = 2005;
	public static immutable int DRAGON_BREATH = 2006;
	public static immutable int END_GATEWAY_SPAWN = 3000;
	public static immutable int ENDERDRAGON_GROWL = 3001;

	public int effectId;
	public long position;
	public int data;
	public boolean disableVolume;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeIntB(effectId);
		this.writeLongB(position);
		this.writeIntB(data);
		this.writeBoolB(disableVolume);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}

/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft107.xml
 */
package sul.protocol.minecraft107.clientbound;

import java.util.UUID;

import sul.protocol.minecraft107.types.*;
import sul.utils.*;

class WindowProperty extends Packet {

	public final static int ID = (int)21;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	// property
	public static immutable short FURNANCE_FIRE_ICON = 0;
	public static immutable short FURNACE_MAX_FUEL_BURN_TIME = 1;
	public static immutable short FURNACE_PROGRESS_ARROW = 2;
	public static immutable short FURNCE_MAX_PROGRESS = 3;
	public static immutable short ENCHANTMENT_LEVEL_REQUIREMENT_TOP = 0;
	public static immutable short ENCHANTMENT_LEVEL_REQUIREMENT_MIDDLE = 1;
	public static immutable short ENCHANTMENT_LEVEL_REQUIREMENT_BOTTOM = 2;
	public static immutable short ENCHANTMENT_SEED = 3;
	public static immutable short ENCHANTMENT_ID_TOP = 4;
	public static immutable short ENCHANTMENT_ID_MIDDLE = 5;
	public static immutable short ENCHANTMENT_ID_BOTTOM = 6;
	public static immutable short ENCHANTMENT_LEVEL_TOP = 7;
	public static immutable short ENCHANTMENT_LEVEL_MIDDLE = 8;
	public static immutable short ENCHANTMENT_LEVEL_BOTTOM = 9;
	public static immutable short BEACON_POWER_LEVEL = 0;
	public static immutable short BEACON_FIRST_EFFECT = 1;
	public static immutable short BEACON_SECOND_EFFECT = 2;
	public static immutable short ANVIL_REPAIR_COST = 0;
	public static immutable short BREWING_STAND_BREW_TIME = 0;

	public byte window;
	public short property;
	public short value;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeByteB(window);
		this.writeShortB(property);
		this.writeShortB(value);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}

/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft315.xml
 */
package sul.protocol.minecraft315.clientbound;

import java.util.UUID;

import sul.protocol.minecraft315.types.*;
import sul.utils.*;

class BlockAction extends Packet {

	public final static int ID = (int)10;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	// action
	public static immutable byte NOTE_BLOCK_HARP = 0;
	public static immutable byte NOTE_BLOCK_BASS_DRUM = 1;
	public static immutable byte NOTE_BLOCK_SNARE_DRUM = 2;
	public static immutable byte NOTE_BLOCK_CLICKS = 3;
	public static immutable byte NOTE_BLOCK_STICKS = 3;
	public static immutable byte NOTE_BLOCK_BASS_GUITAR = 4;
	public static immutable byte PISTON_EXTEND = 0;
	public static immutable byte PISTON_RETRACT = 1;
	public static immutable byte CHEST_WATCHERS = 1;
	public static immutable byte BEACON_RECALCULATE = 1;
	public static immutable byte MOB_SPAWNER_RESET_DELAY = 1;
	public static immutable byte END_GATEWAY_YELLOW_BEAM = 1;

	// parameter
	public static immutable byte PISTON_DOWN = 0;
	public static immutable byte PISTON_UP = 1;
	public static immutable byte PISTON_SOUTH = 2;
	public static immutable byte PISTON_WEST = 3;
	public static immutable byte PISTON_NORTH = 4;
	public static immutable byte PISTON_EAST = 5;

	public long position;
	public byte action;
	public byte parameter;
	public int blockType;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeLongB(position);
		this.writeByteB(action);
		this.writeByteB(parameter);
		this.writeVaruint(blockType);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}

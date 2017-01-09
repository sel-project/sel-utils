/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft316.xml
 */
package sul.protocol.minecraft316.clientbound;

import java.util.UUID;

import sul.protocol.minecraft316.types.*;
import sul.utils.*;

class UpdateBlockEntity extends Packet {

	public final static int ID = (int)9;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	// action
	public static immutable byte MOB_SPAWNER_DATA = 1;
	public static immutable byte COMMAND_BLOCK_TEXT = 2;
	public static immutable byte BEACON_POWERS = 3;
	public static immutable byte MOB_HEAD_DATA = 4;
	public static immutable byte FLOWER_POT_FLOWER = 5;
	public static immutable byte BANNER_DATA = 6;
	public static immutable byte STRUCTURE_DATA = 7;
	public static immutable byte END_GATEWAY_DESTINATION = 8;
	public static immutable byte SIGN_TEXT = 9;
	public static immutable byte SHULKER_BOX_DECLARATION = 10;

	public long position;
	public byte action;
	public byte[] nbt;

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
		this.writeBytes(nbt);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}

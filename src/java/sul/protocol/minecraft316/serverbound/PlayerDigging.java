/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft316.xml
 */
package sul.protocol.minecraft316.serverbound;

import java.util.UUID;

import sul.protocol.minecraft316.types.*;
import sul.utils.*;

class PlayerDigging extends Packet {

	public final static int ID = (int)19;

	public final static boolean CLIENTBOUND = false;
	public final static boolean SERVERBOUND = true;

	// status
	public static immutable int START_DIGGING = 0;
	public static immutable int CANCEL_DIGGING = 1;
	public static immutable int FINISH_DIGGING = 2;
	public static immutable int DROP_ITEM_STACK = 3;
	public static immutable int DROP_ITEM = 4;
	public static immutable int SHOOT_ARROW = 5;
	public static immutable int FINISH_EATING = 5;
	public static immutable int SWAP_ITEM_IN_HAND = 6;

	public int status;
	public long position;
	public byte face;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeVaruint(status);
		this.writeLongB(position);
		this.writeByteB(face);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}

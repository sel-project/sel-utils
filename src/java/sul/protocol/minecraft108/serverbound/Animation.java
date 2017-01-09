/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft108.xml
 */
package sul.protocol.minecraft108.serverbound;

import java.util.UUID;

import sul.protocol.minecraft108.types.*;
import sul.utils.*;

class Animation extends Packet {

	public final static int ID = (int)26;

	public final static boolean CLIENTBOUND = false;
	public final static boolean SERVERBOUND = true;

	// hand
	public static immutable int MAIN_HAND = 0;
	public static immutable int OFF_HAND = 1;

	public int hand;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeVaruint(hand);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}

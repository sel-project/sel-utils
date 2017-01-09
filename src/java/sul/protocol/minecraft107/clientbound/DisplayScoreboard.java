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

class DisplayScoreboard extends Packet {

	public final static int ID = (int)56;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	// position
	public static immutable byte LIST = 0;
	public static immutable byte SIDEBAR = 1;
	public static immutable byte BELOW_NAME = 2;

	public byte position;
	public String scoreName;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeByteB(position);
		byte[] c2NvcmVOYW1l=scoreName.getBytes("UTF-8"); this.writeVaruint((int)c2NvcmVOYW1l.length); this.writeBytes(c2NvcmVOYW1l);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}

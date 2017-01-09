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

class ResourcePackStatus extends Packet {

	public final static int ID = (int)22;

	public final static boolean CLIENTBOUND = false;
	public final static boolean SERVERBOUND = true;

	// result
	public static immutable int LOADED = 0;
	public static immutable int DECLINED = 1;
	public static immutable int FAILED = 2;
	public static immutable int ACCEPTED = 3;

	public String hash;
	public int result;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		byte[] aGFzaA=hash.getBytes("UTF-8"); this.writeVaruint((int)aGFzaA.length); this.writeBytes(aGFzaA);
		this.writeVaruint(result);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}

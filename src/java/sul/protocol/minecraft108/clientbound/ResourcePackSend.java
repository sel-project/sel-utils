/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft108.xml
 */
package sul.protocol.minecraft108.clientbound;

import java.util.UUID;

import sul.protocol.minecraft108.types.*;
import sul.utils.*;

class ResourcePackSend extends Packet {

	public final static int ID = (int)50;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	public String url;
	public String hash;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		byte[] dXJs=url.getBytes("UTF-8"); this.writeVaruint((int)dXJs.length); this.writeBytes(dXJs);
		byte[] aGFzaA=hash.getBytes("UTF-8"); this.writeVaruint((int)aGFzaA.length); this.writeBytes(aGFzaA);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}

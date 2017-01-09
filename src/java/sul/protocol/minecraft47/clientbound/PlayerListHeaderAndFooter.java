/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft47.xml
 */
package sul.protocol.minecraft47.clientbound;

import java.util.UUID;

import sul.protocol.minecraft47.types.*;
import sul.utils.*;

class PlayerListHeaderAndFooter extends Packet {

	public final static int ID = (int)71;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	public String header;
	public String footer;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		byte[] aGVhZGVy=header.getBytes("UTF-8"); this.writeVaruint((int)aGVhZGVy.length); this.writeBytes(aGVhZGVy);
		byte[] Zm9vdGVy=footer.getBytes("UTF-8"); this.writeVaruint((int)Zm9vdGVy.length); this.writeBytes(Zm9vdGVy);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}

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

class TabComplete extends Packet {

	public final static int ID = (int)14;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	public String[] matches;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeVaruint((int)matches.length); for(string bWF0Y2hlcw:matches){ byte[] YldGMFkyaGxjdw=bWF0Y2hlcw.getBytes("UTF-8"); this.writeVaruint((int)YldGMFkyaGxjdw.length); this.writeBytes(YldGMFkyaGxjdw); }
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}

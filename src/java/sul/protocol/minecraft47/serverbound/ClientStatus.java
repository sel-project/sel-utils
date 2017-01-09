/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft47.xml
 */
package sul.protocol.minecraft47.serverbound;

import java.util.UUID;

import sul.protocol.minecraft47.types.*;
import sul.utils.*;

class ClientStatus extends Packet {

	public final static int ID = (int)22;

	public final static boolean CLIENTBOUND = false;
	public final static boolean SERVERBOUND = true;

	// action
	public static immutable int RESPAWN = 0;
	public static immutable int REQUEST_STATS = 1;
	public static immutable int OPEN_INVENTORY = 2;

	public int action;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeVaruint(action);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}

/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft210.xml
 */
package sul.protocol.minecraft210.clientbound;

import java.util.UUID;

import sul.protocol.minecraft210.types.*;
import sul.utils.*;

class PlayerListItem extends Packet {

	public final static int ID = (int)45;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

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

	public static class AddPlayer extends PlayerListItem {

	}

	public static class UpdateGamemode extends PlayerListItem {

	}

	public static class UpdateLatency extends PlayerListItem {

	}

	public static class UpdateDisplayName extends PlayerListItem {

	}

	public static class RemovePlayer extends PlayerListItem {

	}

}

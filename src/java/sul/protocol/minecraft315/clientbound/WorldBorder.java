/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft315.xml
 */
package sul.protocol.minecraft315.clientbound;

import java.util.UUID;

import sul.protocol.minecraft315.types.*;
import sul.utils.*;

class WorldBorder extends Packet {

	public final static int ID = (int)53;

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

	public static class SetSize extends WorldBorder {

	}

	public static class LerpSize extends WorldBorder {

	}

	public static class SetCenter extends WorldBorder {

	}

	public static class Initialize extends WorldBorder {

	}

	public static class SetWarningTime extends WorldBorder {

	}

	public static class SetWarningBlocks extends WorldBorder {

	}

}

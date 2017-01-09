/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/hncom1.xml
 */
package sul.protocol.hncom1.generic;

import java.util.UUID;

import sul.protocol.hncom1.types.*;
import sul.utils.*;

class RemoteCommand extends Packet {

	public final static byte ID = (byte)8;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	// origin
	public static immutable byte HUB = 0;
	public static immutable byte EXTERNAL_CONSOLE = 1;
	public static immutable byte RCON = 2;

	public byte origin;
	public Address sender;
	public String command;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeByteB(ID);
		this.writeByteB(origin);
		this.writeBytes(sender.encode());
		byte[] Y29tbWFuZA=command.getBytes("UTF-8"); this.writeVaruint((int)Y29tbWFuZA.length); this.writeBytes(Y29tbWFuZA);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}

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

class ScoreboardObjective extends Packet {

	public final static int ID = (int)63;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	// mode
	public static immutable byte CREATE = 0;
	public static immutable byte REMOVE = 1;
	public static immutable byte UPDATE = 2;

	// type
	public static immutable String NUMERIC = "integer";
	public static immutable String GRAPHIC = "hearts";

	public String name;
	public byte mode;
	public String value;
	public String type;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		byte[] bmFtZQ=name.getBytes("UTF-8"); this.writeVaruint((int)bmFtZQ.length); this.writeBytes(bmFtZQ);
		this.writeByteB(mode);
		if(mode!=1){ byte[] dmFsdWU=value.getBytes("UTF-8"); this.writeVaruint((int)dmFsdWU.length); this.writeBytes(dmFsdWU); }
		if(mode!=1){ byte[] dHlwZQ=type.getBytes("UTF-8"); this.writeVaruint((int)dHlwZQ.length); this.writeBytes(dHlwZQ); }
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}

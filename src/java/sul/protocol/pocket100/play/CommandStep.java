/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/pocket100.xml
 */
package sul.protocol.pocket100.play;

import java.util.UUID;

import sul.protocol.pocket100.types.*;
import sul.utils.*;

class CommandStep extends Packet {

	public final static byte ID = (byte)78;

	public final static boolean CLIENTBOUND = false;
	public final static boolean SERVERBOUND = true;

	public String command;
	public String overload;
	public int unknown2;
	public int unknown3;
	public boolean isOutput;
	public long unknown5;
	public String input;
	public String output;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeByteB(ID);
		byte[] Y29tbWFuZA=command.getBytes("UTF-8"); this.writeVaruint((int)Y29tbWFuZA.length); this.writeBytes(Y29tbWFuZA);
		byte[] b3ZlcmxvYWQ=overload.getBytes("UTF-8"); this.writeVaruint((int)b3ZlcmxvYWQ.length); this.writeBytes(b3ZlcmxvYWQ);
		this.writeVaruint(unknown2);
		this.writeVaruint(unknown3);
		this.writeBoolB(isOutput);
		this.writeVarulong(unknown5);
		byte[] aW5wdXQ=input.getBytes("UTF-8"); this.writeVaruint((int)aW5wdXQ.length); this.writeBytes(aW5wdXQ);
		byte[] b3V0cHV0=output.getBytes("UTF-8"); this.writeVaruint((int)b3V0cHV0.length); this.writeBytes(b3V0cHV0);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}
